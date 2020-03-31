    //Programa base que reproduce un WAV llamada A001.wav
    //cuyas características son: PCM, 22050 Hz de frecuencia de muestreo, 
    //8 bits por muestra y monoaural
    #include <io.h>
    #include <delay.h>
    #include <stdio.h>
    #include <ff.h>
    #include <display.h>
    
     #asm
        .equ __lcd_port=0x11
        .equ __lcd_EN=4
        .equ __lcd_RS=5
        .equ __lcd_D4=0
        .equ __lcd_D5=1
        .equ __lcd_D6=2
        .equ __lcd_D7=3
    #endasm


    char bufferL[256];
    char bufferH[256]; 
    char NombreArchivo[13], NombreTexto[15]; 
    unsigned int i=0;
    bit LeerBufferH,LeerBufferL,mono;
    unsigned char cancion;
    
    unsigned int  br,b,c;
    
    unsigned char Nombre[20];
    unsigned char Artista[20];
    unsigned char Muestreo[20];
           
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
        if(mono==1){
            if (i<256){
              OCR0A=bufferL[i];
              OCR0B=bufferL[i++];
            }else      
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
        }else{
           if (i<256){
              OCR0A=bufferL[i++];
              OCR0B=bufferL[i++];
            }else      
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
    
    
    void LeerDatos(unsigned char NombreTexto[]){
        res = f_open(&archivo, NombreTexto, FA_OPEN_ALWAYS | FA_WRITE | FA_READ);     
               if (res==FR_OK){
                sprintf(Nombre,"                   ");
                sprintf(Artista,"                   ");
                sprintf(Muestreo,"                   ");
                f_read(&archivo, bufferL, 256,&br); //leer archivo            
                c = 0;
                for(b = 0;bufferL[b] != 0x0D; b++)
                {
                    Nombre[c] = bufferL[b];   
                    c++;
                }   
                    
                c = 0;
                for(b += 2;bufferL[b] != 0x0D; b++)
                {
                    Artista[c] = bufferL[b]; 
                    c++;
                }    
                    
                c = 0;
                for(b += 2;bufferL[b] != 0x0D; b++)
                {
                    Muestreo[c] = bufferL[b];
                    c++;
                } 
                    f_close(&archivo);           
                }
                
                 EraseLCD();
                 MoveCursor(0,0);
                 StringLCDVar(Nombre);
                 MoveCursor(0,1);
                 StringLCDVar(Artista);
                 MoveCursor(0,2);
                 StringLCDVar(Muestreo);
                       
                 f_close(&archivo); 
    }
    
    void LeerFrecuencia(unsigned char NombreArchivo[]){
        res = f_open(&archivo, NombreArchivo, FA_OPEN_ALWAYS | FA_WRITE | FA_READ);
            if (res==FR_OK){
                f_read(&archivo, bufferL, 45,&br);
                if(bufferL[25] == 0x7D){
                    OCR2A=62;    //Interrupción periódica cada 1/32000 seg     $7D00   lugar 25 leer 2 bytes mas significativos
                }else if (bufferL[25] == 0x5D){
                    OCR2A=82;    //Interrupción periódica cada 1/24000 seg     $5DC0
                }else if(bufferL[25] == 0x56){
                    OCR2A=90;      //Interrupción periódica cada 1/22050 seg     $5622
                }
                if(bufferL[22] == 1){
                    mono=1;    //La cancion es mono
                }else{
                    mono=0;   //La cancion es estereo
                }
            }   
        
    }
    
    void TocaCancion(unsigned char NombreCancion[])
    {
            res = f_open(&archivo, NombreCancion, FA_OPEN_EXISTING | FA_READ); 
            if (res==FR_OK){ 
              
                PORTD.6=1;  //Prende Led      
                
                
                f_read(&archivo, bufferL, 58,&br); //leer encabezado    
                
                f_read(&archivo, bufferL, 256,&br); //leer los primeros 512 bytes del WAV
                f_read(&archivo, bufferH, 256,&br);    
                LeerBufferL=0;     
                LeerBufferH=0;
                TCCR0B=0x01;    //Prende sonido   
                i=0;
                do{   
                     while((LeerBufferH==0)&&(LeerBufferL==0));
                     if (LeerBufferL)
                     {                       
                         f_read(&archivo, bufferL, 256,&br); //leer encabezado
                         LeerBufferL=0;
                     }
                     else
                     { 
                         f_read(&archivo, bufferH, 256,&br); //leer encabezado
                         LeerBufferH=0;
                     }  
                     if (PINC.3==0)     //botón de Foward
                         br=0;
    
                     if ( PINC.1 == 0){
                        delay_ms(400);       
                        while (1){
                            TCCR0A = 0x00;
                            TIMSK2=0x00;
                            if ( PINC.1 == 0){
                                delay_ms(400);
                                break;
                            }
                        }
                        TCCR0A = 0xA3;
                        TIMSK2 = 0x02;
                     }
                     
                     if (PINC.2 == 0)
                     { 
                        delay_us(40);
                        TIMSK2 = 0x00;
                        f_lseek(&archivo, 58);
                        TIMSK2 = 0x02;
                     } 
                     if (PINC.0 == 0)
                     {
                        delay_us(40);
                        br = 0;
                        delay_us(40);
                     }                              
                }while(br==256);
                TCCR0B=0x00;   //Apaga sonido
                f_close(&archivo);   
                PORTD.6=0;  //Apaga Led 
                }
    }
    
    
    void main()
    {
    
        CLKPR=0x80;
        CLKPR=0x00;  //Micro físico a correr a 16MHz       
        
        DDRD.0=1;
        DDRD.6=1;    //Led Teensy 
        
        PORTC.0=1;
        PORTC.1=1;
        PORTC.2=1;
        PORTC.3=1;
        DDRB.7=1;   
        
        TCCR1B=0x0A;     //CK/8 10ms con oscilador de 8MHz
        OCR1AH=0x4E;
        OCR1AL=0x20;
        TIMSK1=0x02; 
                                                        
        TCCR0A=0xA3;  //Fast PWM en Timer 0
                                      
        ASSR=0x00;
        TCCR2A=0x02;
        TCCR2B=0x02;   // CK/8
        OCR2A=90;      //Interrupción periódica cada 1/22050 seg
            
        // Timer/Counter 2 Interrupt(s) initialization
        TIMSK2=0x02;
        SetupLCD();
        #asm("sei")   
        disk_initialize(0);  /* Inicia el puerto SPI para la SD */
        delay_ms(500);
        
        if ((res=f_mount(0,&drive))==FR_OK){    
            MoveCursor(0,1); 
            StringLCD("Drive detectado");       
            delay_ms(1000);
            /* mount logical drive 0: */
            
            while(1){
                
                    for(cancion = 1; cancion < 7; cancion++){
                        sprintf(NombreTexto,"A00%i.txt",cancion);         
                        LeerDatos(NombreTexto);

                        sprintf(NombreArchivo,"A00%i.wav",cancion);
                        LeerFrecuencia(NombreArchivo);
                                  
                        TocaCancion(NombreArchivo);
                        delay_ms(500);
                        
                    }
                }   
                        f_mount(0, 0); //Cerrar drive de SD 
        }            
        while(1);
}
