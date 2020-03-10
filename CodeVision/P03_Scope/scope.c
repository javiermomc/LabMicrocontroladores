/*
 * scope.c
 *
 * Created: 08/03/2020 06:58:19 p. m.
 * Author: Chucho López Ortega
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

// Voltage Reference: Int., cap. on AREF
#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (0<<ADLAR))


// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | ADC_VREF_TYPE;
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=(1<<ADSC);
// Wait for the AD conversion to complete
while ((ADCSRA & (1<<ADIF))==0);
ADCSRA|=(1<<ADIF);
return ADCW;
}

int buffer[128];

<<<<<<< Updated upstream
void frequency(){
    
=======
int frequency(){
    char i=0, max, iMax, freq;
    max = buffer[0];
    iMax = i;
    for ( i=1;i<128;i++){
        if(max == buffer[i]){
            freq = 1/(((float)(i - iMax))*0.000039);
            iMax = i; 
        }               
        if(max<buffer[i]){
            max = buffer[i];
            iMax = i;
        }
    }    
    return (int)freq;
>>>>>>> Stashed changes
}

// Fills the array to sample the scope shot
void scope(){
    int i;
    for (i=0;i<128;i++){
        buffer[i] = read_adc(7);
        delay_us(39);
    }
}

<<<<<<< Updated upstream
// Trigger for scope shot
PORTD.7 = 1;

void main(void) {
=======
int freq;


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
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
=======
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

char j;
int i;
char encabezado[62];


char output[64];

void main(void) {
    SetupLCD();  
    // ADC initialization
    // ADC Clock frequency: 1000.000 kHz
    // ADC Voltage Reference: Int., cap. on AREF
    // ADC High Speed Mode: On
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
    
    // Código para hacer una interrupción periódica cada 10ms
    
    TCCR1B=0x0A;             //  CK/8
    OCR1AH=19999/256;
    OCR1AL=19999%256;
    TIMSK1=0x02;
    StringLCD("...");
    #asm("sei")
    disk_initialize(0);
    delay_ms(200);
    
>>>>>>> Stashed changes
    while (1) {
    // Please write your application code here  
    StringLCD("Welcome");
        if (PIND.7 == 0){
            EraseLCD();
            StringLCD("Starting     ");
            scope();
            freq = frequency(); 
            sd_openDrive();
            if(f_open(&archivo,"0:BASE.BMP", FA_OPEN_EXISTING | FA_READ)==FR_OK){
                f_read(&archivo, encabezado, 64, &br);
                f_close(&archivo); 
                if (f_open(&archivo,fileName, FA_CREATE_ALWAYS | FA_WRITE)==FR_OK){       
                    f_write(&archivo,encabezado,sizeof(encabezado),&br);     //Escribir encabezado  
                    for (i=0;i<256;i++){
                        for(j=0; j<128; j++){ 
                            output[j/2] = 0xFF;
                            if(buffer[j]*256/1024==i){
                                if((j+1)%2==1){
                                    output[j/2] = output[j/2] - 0xF0;
                                }else{
                                    output[j/2] = output[j/2] - 0x0F;
                                }
                            }
                            if ((i>=10)&(i<=18)){
                             output[1]=Letra0[18-i];
                             output[2]=Letra1[18-i];
                             output[3]=LetraH[18-i];
                             output[4]=LetraZ[18-i]; 
                            }                   
                        }
                        f_write(&archivo,output,sizeof(output),&br);
                    }
                    EraseLCD();
                    StringLCD("Listo      ");   
                    f_close(&archivo); 
                    delay_ms(2000);
                }else{
                    EraseLCD();
                    MoveCursor(0,0);
                    StringLCD("File error"); 
                }                
            }else{
               EraseLCD();
               MoveCursor(0,0);
               StringLCD("base.bmp error");          
            }
            sd_closeDrive();            
        }
    }
}
