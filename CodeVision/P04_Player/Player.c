/*WavPlayer  
* Monoural y Stereo 
* frecuencias 22050, 24000, 32000
*
*/

// LCD config
#asm
    .equ __lcd_port=0x11
    .equ __lcd_EN=4
    .equ __lcd_RS=5
    .equ __lcd_D4=0
    .equ __lcd_D5=1
    .equ __lcd_D6=2
    .equ __lcd_D7=3
#endasm

#include <io.h>
#include <delay.h>
#include <stdio.h>
#include <ff.h>
#include <display.h>

    
char bufferL[256];
char bufferH[256]; 
char NombreArchivo[13]; 
unsigned int i=0;
bit LeerBufferH,LeerBufferL;
unsigned long muestras;
bit mono;                 //variable para identificar si es mono o stereo
bit rewind=0;             //Bandera del boton rewind
char numc;                //numero de cancion
char total_canciones='6'; //numero total de canciones alamasenadas
char frec_mues;           //variable para guardar frec. muestreo y mostrarla en el LCD
long muestras_totales;    //guarda el numero total de muestras, es utilisado en la funcion display_info
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
        
//Interrupción que se ejecuta cada T=1/Fmuestreo_Wav
interrupt [TIM2_COMPA] void timer2_compa_isr(void)         
{
  if(mono==1){   //mono
      if (i<256){
        OCR0A=bufferL[i];
        OCR0B=bufferL[i++]; 
        }
      else      
      {
        OCR0A=bufferH[i-256];
        OCR0B=bufferH[i-256];
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
    else {       //stereo 
      if (i<256){
        OCR0A=bufferL[i++];
        OCR0B=bufferL[i++];
        }
      else      
      {
        OCR0A=bufferH[i-256];
        i++;
        OCR0B=bufferH[i-256];
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
}


//LCD
void display_info() 
{
  int j;
  f_lseek(&archivo,44+muestras_totales);//Ir a los bytes de info
  f_read(&archivo, bufferL, 128,&br);  

   EraseLCD();
  //Nombre cancion
   j=18;
   while((bufferL[j]&0xF0)==0x00) {j++;}  
   MoveCursor(0,0);
   while((bufferL[j]&0xF0)!=0x00) {
     CharLCD(bufferL[j]); 
     j++;
   } 
  //Artista  
  while((bufferL[j]&0xF0)==0x00) {j++;}
  j+=5;
  while((bufferL[j]&0xF0)==0x00) {j++;}
  MoveCursor(0,1);
  while((bufferL[j]&0xF0)!=0x00) {
    CharLCD(bufferL[j]);
    j++;
  } 
  //Disco
  while((bufferL[j]&0xF0)==0x00) {j++;}
  j+=5;
  while((bufferL[j]&0xF0)==0x00) {j++;}
  MoveCursor(0,2);
  while((bufferL[j]&0xF0)!=0x00) {
    CharLCD(bufferL[j]);
    j++;
  } 
  //caracterisitcas wav
   MoveCursor(0,3); 
   StringLCD("Frec: ");
   if (frec_mues==0x22) { StringLCD("22050");}
   if (frec_mues==0xC0) { StringLCD("24000");}
   if (frec_mues==0x00) { StringLCD("32000");} 
   if (mono==1) {StringLCD(" Mono");}
   if (mono==0) {StringLCD(" Ster");}
  
  f_lseek(&archivo,44); //regresar a los bytes de la cancion
}


//Toca Cancion
void TocaCancion(unsigned char NombreCancion[])
{
       
        
        res = f_open(&archivo, NombreCancion, FA_OPEN_EXISTING | FA_READ); 
        if (res==FR_OK){ 
          
            PORTD.6=1;  //Prende Led      
            
            
            f_read(&archivo, bufferL, 44,&br); //leer encabezado  
            muestras=(long)bufferL[43]*16777216+(long)bufferL[42]*65536+(long)bufferL[41]*256+bufferL[40];  //obtener número de muestras  
            muestras_totales=muestras;
            //leer si es stereo o mono
            if (bufferL[22]==1) 
              mono=1;
            else
              mono=0;  
            //frecuencia muestreo: no es necesario leer el numero completo, con solo leer un byte se puede saber a que frecuencia esta
            if (bufferL[24]==0x22) { OCR2A=90;}  //22050
            if (bufferL[24]==0xC0) { OCR2A=83;}  //24000
            if (bufferL[24]==0x00) { OCR2A=62;}  //32000
            frec_mues=bufferL[24]; //variable para guardar frec. muestreo y mostrarla en el LCD
            //leer datos cancion    
            display_info();
                     
            f_read(&archivo, bufferL, 256,&br); //leer los primeros 512 bytes del WAV
            muestras=muestras-br;
            f_read(&archivo, bufferH, 256,&br);
            muestras=muestras-br;    
            LeerBufferL=0;     
            LeerBufferH=0; 
            TCCR0A=0xA3;
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
                 //botón de Foward  
                 if (PINC.2==0)    
                     muestras=0;  
                 //boton Play-Pause
                 if (PINC.0==0){ 
                   TCCR0A=0x00;  //Apaga sonido 
                   TCCR0B=0x00;    
                   PORTB.7=0;   
                   PORTD.0=0;
                   delay_ms(800);
                   while(PINC.0==1);//esperar hasta que se vuelva a presionar
                   delay_ms(300);
                   TCCR0A=0xA3;//Prende sonido 
                   TCCR0B=0x01;    
                 }   
                 //Boton Rewind
                 if(PINC.1==0){  
                  muestras=0;
                  rewind=1;
                 }
                                      
            }while(muestras>256);         
            TCCR0A=0x00;  //Apaga sonido 
            TCCR0B=0x00;    
            PORTB.7=0;   
            PORTD.0=0;
            f_close(&archivo);   
            PORTD.6=0;  //Apaga Led   
            }
}


void main()
{

    CLKPR=0x80;
    CLKPR=0x00;  //Micro físico a correr a 16MHz    
    
    SetupLCD();
    DDRB.7=1;    //OC0A  Salidas PWM para audio estereo
    DDRD.0=1;    //OC0B      
    
    DDRD.6=1;    //Led Teensy
    PORTC.0=1;   //Pull-ups Play
    PORTC.1=1;   //Rewind
    PORTC.2=1;   //Forward
                                                     
    //Interrupción cada 10ms para SD (oscilador de 16MHz)
    TCCR1B=0x0A;        //CK/8 (periodo timer = 0.5 useg) 
    OCR1AH=19999/256;   // 20000 cuentas x0.5useg=10mseg
    OCR1AL=19999%256;
    TIMSK1=0x02; 
    
    //Fast PWM 
  //TCCR0A=0xA3;     salida unicamente por OC0A (monoural)                                             
    TCCR0A=0xA3;    //salida OC0A OC0B (stereo)
       
    //Frec muestreo                           
    TCCR2A=0x02;
    TCCR2B=0x02;   // CK/8
    OCR2A=90;      //Interrupción periódica cada 1/22050 seg (perido de muestreo)
        
    // Timer/Counter 2 Interrupt(s) initialization
    TIMSK2=0x02;
    
    #asm("sei")   
    disk_initialize(0);  /* Inicia el puerto SPI para la SD */
    delay_ms(500);
    
    sprintf(NombreArchivo,"0:A001.wav");
    numc='1';
    
    while(1)
    { 
    /* mount logical drive 0: */
      if ((res=f_mount(0,&drive))==FR_OK){  
          
          TocaCancion(NombreArchivo);
          //cambiar cancion
          if (rewind==0){  
            numc++;
            if (numc>total_canciones){numc='1';}
            NombreArchivo[5]=numc; 
          }
          else{
            rewind=0; 
          }
          delay_ms(300);
      
      }  
      //f_mount(0, 0); //Cerrar drive de SD
    }            

    f_mount(0, 0); //Cerrar drive de SD
    while(1);
}

