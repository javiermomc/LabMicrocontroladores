/*
 * scope.c
 *
 * Created: 08/03/2020 06:58:19 p. m.
 * Author: Chucho L�pez Ortega
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

#include <90usb1286.h>
#include <display.h>
#include <delay.h>
#include <stdio.h>
#include <ff.h>

// Voltage Reference: AVCC pin
#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (1<<ADLAR))

// Read the 8 most significant bits
// of the AD conversion result
unsigned char read_adc(unsigned char adc_input)
{
ADMUX=adc_input | ADC_VREF_TYPE;
// Delay needed for the stabilization of the ADC input voltage
//delay_us(10);
// Start the AD conversion
ADCSRA|=(1<<ADSC);
// Wait for the AD conversion to complete
while ((ADCSRA & (1<<ADIF))==0);
ADCSRA|=(1<<ADIF);
return ADCH;
}

int freq;
void getFrequency(){
    TCCR3A = 0b00000000;
    TCCR3B = 0x07;
    TCNT3H = 0;
    TCNT3L = 0;
    delay_ms(998);
    delay_us(870);
    freq = TCNT3L + TCNT3H*256;   
}

int i, buffer[128];
// Fills the array to sample the scope shot
void scope(){
    #asm("cli")
    for (i=0;i<128;i++){
        buffer[i] = read_adc(7);
        delay_us(21);
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
        #asm("NOP");
    }
    #asm("sei")
}

// SD
char fileName[]  = "0:IM000.BMP";
unsigned int br;        
/* will hold the information for logical drive 0: */
FATFS drive;
FIL archivo; // file objects
    
interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
disk_timerproc();
/* MMC/SD/SD HC card access low level timing function */
}

flash unsigned char Letra0[9] ={0xC7,0xBB,0xBB,0xBB,0xBB,0xBB,0xBB,0xBB,0xC7};
flash unsigned char Letra1[9] ={0xEF,0x8F,0xEF,0xEF,0xEF,0xEF,0xEF,0xEF,0x83};
flash unsigned char Letra2[9] ={0xC7,0xBB,0xFB,0xFB,0xF7,0xEF,0xDF,0xBF,0x83};
flash unsigned char Letra3[9] ={0xC7,0xBB,0xFB,0xFB,0xE7,0xFB,0xFB,0xBB,0xC7};
flash unsigned char Letra4[9] ={0xF7,0xE7,0xE7,0xD7,0xD7,0xB7,0x83,0xF7,0xE3};
flash unsigned char Letra5[9] ={0x83,0xBF,0xBF,0xBF,0x87,0xFB,0xFB,0xBB,0xC7};
flash unsigned char Letra6[9] ={0xE7,0xDF,0xBF,0xBF,0x87,0xBB,0xBB,0xBB,0xC7};
flash unsigned char Letra7[9] ={0x83,0xBB,0xFB,0xF7,0xF7,0xEF,0xEF,0xDF,0xDF};
flash unsigned char Letra8[9] ={0xC7,0xBB,0xBB,0xBB,0xC7,0xBB,0xBB,0xBB,0xC7};
flash unsigned char Letra9[9] ={0xC7,0xBB,0xBB,0xBB,0xC3,0xFB,0xFB,0xF7,0xCF};
flash unsigned char LetraH[9] ={0x88,0xDD,0xDD,0xDD,0xC1,0xDD,0xDD,0xDD,0x88};
flash unsigned char LetraZ[9] ={0xFF,0xFF,0xFF,0x81,0xBB,0xF7,0xEF,0xDD,0x81};

void sd_openDrive(){
    if (f_mount(0,&drive)!=FR_OK){
        EraseLCD();
        MoveCursor(0,0);
        StringLCD("Drive no detectado");
    }
}
void sd_closeDrive(){
    f_mount(0, 0); //Cerrar drive de SD 
    EraseLCD();
    MoveCursor(0,0);
    StringLCD("Drive cerrado");
    delay_ms(1000);
}

int j;
char k = 0x80;
char temp = 0xFF;
char encabezado[62];


char output[64];
char aNum[9];
void getNum(int num){
    char i;
    switch(num){
        case 0:
            for(i=0;i<9;i++)
            aNum[i] = Letra0[i];
            break;
        case 1:
            for(i=0;i<9;i++)
            aNum[i] = Letra1[i];
            break;
        case 2:
            for(i=0;i<9;i++)
            aNum[i] = Letra2[i];
            break;
        case 3:
            for(i=0;i<9;i++)
            aNum[i] = Letra3[i];
            break;
        case 4:
            for(i=0;i<9;i++)
            aNum[i] = Letra4[i];
            break;
        case 5:
            for(i=0;i<9;i++)
            aNum[i] = Letra5[i];
            break;
        case 6:
            for(i=0;i<9;i++)
            aNum[i] = Letra6[i];
            break;
        case 7:
            for(i=0;i<9;i++)
            aNum[i] = Letra7[i];
            break;
        case 8:
            for(i=0;i<9;i++)
            aNum[i] = Letra8[i];
            break;
        case 9:
            for(i=0;i<9;i++)
            aNum[i] = Letra9[i];
            break;
        case 10:
            for(i=0;i<9;i++)
            aNum[i] = LetraH[i];
            break;
        case 11:
            for(i=0;i<9;i++)
            aNum[i] = LetraZ[i];
            break;
        default:
            for(i=0;i<9;i++)
            aNum[i] = Letra0[i];
            break;
    }
}

char m, d, c, u;
void itoa(int n){
    int num = n;
    m = num/1000;
    num = n - m*1000;
    d = num/100;
    num = num-d*100;
    c = num/10;
    num = num-c*10;
    u = num;    
}

char aP, nP;
    
void main(void) {
    SetupLCD(); // LCD Setup  
    // ADC initialization
    // ADC Clock frequency: 1000.000 kHz
    // ADC Voltage Reference: AVCC pin
    // ADC High Speed Mode: On
    // Only the 8 most significant bits of
    // the AD conversion result are used
    // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
    // ADC4: On, ADC5: On, ADC6: On, ADC7: Off
    DIDR0=(1<<ADC7D) | (0<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
    ADMUX=ADC_VREF_TYPE;
    ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
    ADCSRB=(1<<ADHSM);

    // Trigger for scope shot
    PORTD.7 = 1;
    
    // SD
    CLKPR=0x80;
    CLKPR=0;        //16 MHz
    
    // C�digo para hacer una interrupci�n peri�dica cada 10ms
    TCCR1B=0x0A;             //  CK/8
    OCR1AH=19999/256;
    OCR1AL=19999%256;
    TIMSK1=0x02;
    StringLCD("Openning disk...");
    #asm("sei")
    disk_initialize(0);
    delay_ms(200);
    EraseLCD();
    while (1) {
    // Please write your application code here 
    MoveCursor(0,0); 
    StringLCD("Ready");
        if (PIND.7 == 0){
            EraseLCD();
            StringLCD("Loading...");
            getFrequency(); // Get function frequency 
            scope(); 
            sd_openDrive();
            if(f_open(&archivo,"0:BASE.BMP", FA_OPEN_EXISTING | FA_READ)==FR_OK){
                f_read(&archivo, encabezado, 64, &br);
                f_close(&archivo);
                i=0;
                do{
                f_close(&archivo);
                sprintf(fileName, "0:IM%03u.BMP", i);
                i++;
                }while(f_open(&archivo, fileName, FA_OPEN_EXISTING)==FR_OK); // Check if file exists
                f_close(&archivo);
                MoveCursor(0,1);
                StringLCDVar(fileName); 
                if (f_open(&archivo,fileName, FA_CREATE_ALWAYS | FA_WRITE)==FR_OK){       
                    f_write(&archivo,encabezado,sizeof(encabezado),&br);     //Escribir encabezado  
                    for (i=0;i<256;i++){      
                        for(j=0; j<512; j++){
                        aP = buffer[j/4]+((j%4)+1)*(buffer[(j/4)+1]-buffer[j/4])/4;
                        j++;
                        nP = buffer[j/4]+((j%4)+1)*(buffer[(j/4)+1]-buffer[j/4])/4;
                        j--; 
                            if((i<=aP&&i>=nP)||(i>=aP&&i<=nP))
                                temp = temp-k;
                            if(k==0){
                                output[j/8] = temp;
                                k=0x80;
                                temp = 0xFF;
                            }                 
                            k=k>>1;                              
                        }
                        if ((i>=10)&(i<=18)){ // Print Frequequency
                                itoa(freq); // Change integer to characters
                                getNum(m); // Obtain character
                                if(m!=0)
                                    output[1]=aNum[18-i];
                                getNum(d);
                                if(m!=0||d!=0)
                                    output[2]=aNum[18-i];
                                getNum(c);
                                if(m!=0||d!=0||c!=0)                             
                                    output[3]=aNum[18-i];
                                getNum(u);
                                output[4]=aNum[18-i];
                                getNum(10);
                                output[5]=aNum[18-i];
                                getNum(11);
                                output[6]=aNum[18-i]; 
                            }
                        f_write(&archivo,output,sizeof(output),&br);
                    }
                    EraseLCD();
                    StringLCD("Done");   
                    f_close(&archivo); 
                    delay_ms(1000);
                }else{
                    EraseLCD();
                    MoveCursor(0,0);
                    StringLCD("File error");
                    delay_ms(1000); 
                }                
            }else{
               EraseLCD();
               MoveCursor(0,0);
               StringLCD("base.bmp error");
               delay_ms(1000);          
            }
            sd_closeDrive();
            EraseLCD();            
        }
    }
}
