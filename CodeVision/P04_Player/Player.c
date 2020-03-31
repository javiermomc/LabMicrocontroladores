//Programa base que reproduce un WAV llamada A001.wav
//cuyas caracter�sticas son: PCM, 22050 Hz de frecuencia de muestreo, 
//8 bits por muestra y monoaural

#include <io.h>
#include <delay.h>
#include <stdio.h>
#include <ff.h>

    
char bufferL[256];
char bufferH[256]; 
char NombreArchivo[13]; 
unsigned int i=0;
bit LeerBufferH,LeerBufferL;
unsigned long muestras;

unsigned int  br;
       
/* FAT function result */
FRESULT res;
    
/* will hold the information for logical drive 0: */
FATFS drive;
FIL archivo; // file objects 

interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
disk_timerproc();
/* MMC/SD/SD HC card access low level timing function */
}
        
//Interrupci�n que se ejecuta cada T=1/Fmuestreo_Wav
interrupt [TIM2_COMPA] void timer2_compa_isr(void)         
{
    if (i<256)
      OCR0A=bufferL[i++];
    else      
    {
      OCR0A=bufferH[i-256];
      i++;
    }   
    if (i==256)
       LeerBufferL=1;
    if (i==512)
    {
       LeerBufferH=1;
       i=0;
    }   
}

void TocaCancion(unsigned char NombreCancion[])
{
        res = f_open(&archivo, NombreCancion, FA_OPEN_EXISTING | FA_READ); 
        if (res==FR_OK){ 
          
            PORTD.6=1;  //Prende Led      
            
            
            f_read(&archivo, bufferL, 44,&br); //leer encabezado  
            muestras=(long)bufferL[43]*16777216+(long)bufferL[42]*65536+(long)bufferL[41]*256+bufferL[40];  //obtener n�mero de muestras  
            
            f_read(&archivo, bufferL, 256,&br); //leer los primeros 512 bytes del WAV
            muestras=muestras-br;
            f_read(&archivo, bufferH, 256,&br);
            muestras=muestras-br;    
            LeerBufferL=0;     
            LeerBufferH=0; 
            TCCR0A=0x83;
            TCCR0B=0x01;    //Prende sonido   
            i=0;
            do{   
                 while((LeerBufferH==0)&&(LeerBufferL==0));
                 if (LeerBufferL)
                 {                       
                     f_read(&archivo, bufferL, 256,&br); 
                     LeerBufferL=0;   
                     muestras=muestras-br;
                 }
                 else
                 { 
                     f_read(&archivo, bufferH, 256,&br); 
                     LeerBufferH=0; 
                     muestras=muestras-br;
                 }     
                 if (PINF.7==0)     //bot�n de Foward
                     muestras=0;                   
            }while(muestras>256);         
            TCCR0A=0x00;  //Apaga sonido 
            TCCR0B=0x00;    
            PORTB.7=0;
            f_close(&archivo);   
            PORTD.6=0;  //Apaga Led 
            }
}


void main()
{

    CLKPR=0x80;
    CLKPR=0x00;  //Micro f�sico a correr a 16MHz

    DDRB.7=1; 
    DDRD.6=1;    //Led Teensy
    PORTF.7=1;   //Pull-up     
                                                      
    //Interrupci�n cada 10ms para SD (oscilador de 16MHz)
    TCCR1B=0x0A;        //CK/8 (periodo timer = 0.5 useg) 
    OCR1AH=19999/256;   // 20000 cuentas x0.5useg=10mseg
    OCR1AL=19999%256;
    TIMSK1=0x02; 
                                                    
    TCCR0A=0x83;    //Salida de Fast PWM en OC0A
                                  
    TCCR2A=0x02;
    TCCR2B=0x02;   // CK/8
    OCR2A=90;      //Interrupci�n peri�dica cada 1/22050 seg (perido de muestreo)
        
    // Timer/Counter 2 Interrupt(s) initialization
    TIMSK2=0x02;
    
    #asm("sei")   
    disk_initialize(0);  /* Inicia el puerto SPI para la SD */
    delay_ms(500);
    
    sprintf(NombreArchivo,"0:A001.wav");
    /* mount logical drive 0: */
    if ((res=f_mount(0,&drive))==FR_OK){  
      
        TocaCancion(NombreArchivo);
        
        
        }  
        f_mount(0, 0); //Cerrar drive de SD
    while(1);            
         
    
    
   
    f_mount(0, 0); //Cerrar drive de SD
    while(1);
}