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


    char bufferL[256], bufferH[256], fileName[16], text[16]; 
    unsigned int i=0;
    bit LeerBufferH, LeerBufferL, mono;
    unsigned long muestras, inicio;
    unsigned int  br;
                   
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
    
char name[16], artist[16], album[16], j;    
void GetInfo(unsigned char NombreTexto[]){     
    if (f_open(&archivo, NombreTexto, FA_OPEN_ALWAYS | FA_READ)==FR_OK){
        f_read(&archivo, bufferL, 44,&br); //leer encabezado  
        muestras=(long)bufferL[43]*16777216+(long)bufferL[42]*65536+(long)bufferL[41]*256+bufferL[40];  //obtener número de muestras
        f_lseek(&archivo, muestras+64);
        f_read(&archivo, bufferL, 256,&br); // Read information 
        f_close(&archivo);
        i=0;
        for(j=0; bufferL[i]!=0&&bufferL[i+1]!=0&&j<16; j++){
            name[j] = bufferL[i];
            i++;
        }
        i+=10;
        for(j=0; bufferL[i]!="."&&bufferL[i+1]!="I"&&bufferL[i+2]!="P"&&bufferL[i+3]!="R"&&bufferL[i+4]!="D"&&j<16; j++){
            artist[j] = bufferL[i];
            i++;
        }
        i+=9;
        for(j=0; bufferL[i]!=0&&bufferL[i+1]!=0&&j<16; j++){
            album[j] = bufferL[i];
            i++;
        }
    }           
}
    
    void GetFrequency(unsigned char NombreArchivo[]){
        if (f_open(&archivo, NombreArchivo, FA_OPEN_ALWAYS | FA_WRITE | FA_READ)==FR_OK){
            f_read(&archivo, bufferL, 45,&br);
            f_close(&archivo);
            switch(bufferL[25]){
                case 0x7D:  OCR2A=62;    // Frequency is 32000Hz
                case 0x5D:  OCR2A=82;    // Frequency is 24000Hz
                case 0x55:  OCR2A=90;    // Frequency is 22050Hz
            }
            if(bufferL[22] == 1)
                mono=1;      // Set mono on
            else
                mono=0;      // Set stereo on   
        }   
        
    }
    
    void TocaCancion(unsigned char NombreCancion[])
    {  
        if (f_open(&archivo, NombreCancion, FA_OPEN_EXISTING | FA_READ)==FR_OK){ 
            PORTD.6=1;  //Prende Led                  
            f_read(&archivo, bufferL, 44,&br); //leer encabezado  
            muestras=(long)bufferL[43]*16777216+(long)bufferL[42]*65536+(long)bufferL[41]*256+bufferL[40];  //obtener número de muestras  
            inicio = muestras;
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
                 if (PINC.2==0)     //botón de Foward
                     muestras=0;
                 if (PINC.1==0)     //botón de Foward
                     muestras=inicio;                   
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
        
        if (f_mount(0,&drive)==FR_OK){    
            MoveCursor(0,1); 
            StringLCD("Drive detectado");       
            delay_ms(1000);
            /* mount logical drive 0: */
           i=0; 
            while(1){ 
                sprintf(fileName, "0:S%02u.BMP", i);
                if(f_open(&archivo, fileName, FA_OPEN_EXISTING)!=FR_OK)
                    i++;
                f_close(&archivo);
                if(i>6)
                    i=0;
                GetInfo(fileName);
                sprintf(text, "%s-%s", name, album);    
                EraseLCD();
                MoveCursor(0,0);
                StringLCDVar(text);
                MoveCursor(0,1);
                StringLCDVar(artist);
                GetFrequency(fileName);          
                TocaCancion(fileName);
                i++;
            }   
                        f_mount(0, 0); //Cerrar drive de SD 
        }            
        while(1);
}
