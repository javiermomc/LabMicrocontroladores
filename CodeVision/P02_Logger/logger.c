/*
 * logger.c
 *
 * Created: 25-Feb-20 4:46:27 PM
 * Author: javie
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

// DS1302 config
#asm
	.equ __ds1302_port=0x0B
	.equ __ds1302_io=2
	.equ __ds1302_sclk=1
	.equ __ds1302_rst=0
#endasm
 
#include <90usb1286.h>
#include <ds1302.h>
#include <display.h>
#include <delay.h>
#include <stdio.h>
#include <ff.h>

// ADC

// ADC variables


// Voltage Reference: Int., cap. on AREF
#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (0<<ADLAR))


// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
    ADMUX=adc_input | ADC_VREF_TYPE;
    // Start the AD conversion
    ADCSRA|=(1<<ADSC);
    // Wait for the AD conversion to complete
    while ((ADCSRA & (1<<ADIF))==0);
    ADCSRA|=(1<<ADIF);
    return ADCW;
}

float v1, v2;
int v1I, v1D, v2I, v2D;

void updateADC(){
    v1 = read_adc(7);
    v2 = read_adc(6);
    v1I = (int)v1;
    v1D = (int)((v1 - (float)v1I)*10.0);
    v2I = (int)v2;
    v2D = (int)((v2 - (float)v2I)*10.0);
}

// SD
char fileName[]  = "0:muestra.txt";

interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
disk_timerproc();
/* MMC/SD/SD HC card access low level timing function */
}

// Open SD

void sd(char NombreArchivo[], char *TextoEscritura){

    unsigned int br;
    char buffer[100];
    
    /* FAT function result */
    FRESULT res;
    
    /* will hold the information for logical drive 0: */
    FATFS drive;
    FIL archivo; // file objects
    
    /* mount logical drive 0: */
    if ((res=f_mount(0,&drive))==FR_OK){
        
        /*Lectura de Archivo*/
        res = f_open(&archivo, NombreArchivo, FA_OPEN_ALWAYS | FA_WRITE | FA_READ);
        if (res==FR_OK){
            
            f_read(&archivo, buffer, 10,&br); //leer archivo en buffer
           
            f_lseek(&archivo,archivo.fsize);
            
            buffer[0] = 0x0D;                //Carriage return   
            buffer[1] = 0x0A;                //Line Feed
            f_write(&archivo,buffer,2,&br);
            /*Escribiendo el Texto*/            
            f_write(&archivo,TextoEscritura,sizeof(TextoEscritura),&br);   // Write of TextoEscritura
            f_close(&archivo);             
        }              
        else{
            StringLCD("Archivo NO Encontrado");
        }
    }
    else{
         StringLCD("Drive NO Detectado");
    }
    f_mount(0, 0); //Cerrar drive de SD
}

// Clock
unsigned char H=0,M=0,S=0, D=0,Mes=0,A=0; // Variables for clock

unsigned char time[16];

void updateClock(){
    rtc_get_time(&H, &M, &S);
    rtc_get_date(&D, &Mes, &A);
}

// LCD 
void printTime(){ 
    sprintf(time, "%02i:%02i:%02i V1: %i.%i", H, M, S, v1I, v1D);
    MoveCursor(0,0);
    StringLCDVar(time);
    sprintf(time, "%02i:%02i:%02i V2: %i.%i", D, Mes, A, v2I, v2D);
    MoveCursor(0,1);
    StringLCDVar(time);     
}
void eraseLCD(){
    MoveCursor(0,0);
    StringLCD("                ");
    MoveCursor(0,1);
    StringLCD("                ");
}



void main(void)
{

// ADC

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: Int., cap. on AREF
// ADC High Speed Mode: On
// Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
// ADC4: On, ADC5: On, ADC6: On, ADC7: Off
DIDR0=(1<<ADC7D) | (1<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
ADMUX=ADC_VREF_TYPE;
ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
ADCSRB=(1<<ADHSM);

// LCD

SetupLCD();

// DS1302
rtc_init(0,0,0);

// SD
// Código para hacer una interrupción periódica cada 10ms
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 1000.000 kHz
// Mode: CTC top=OCR1A
// Compare A Match Interrupt: On
TCCR1B=0x09;
OCR1AH=19999/256;
OCR1AL=19999%256;   //20000cuentas a 0.5us por cuenta=10mseg
TIMSK1=0x02;
SetupLCD();
#asm("sei")
/* Inicia el puerto SPI para la SD */
disk_initialize(0);
delay_ms(200);

// First actions
PORTC = 0xFF;

while (1)
    {
    // Please write your application code here
        // Verify the correct range on clock time
        
        // ADC
        updateADC();
        
        // Clock 
        
        updateClock();
        printTime();
        
        // If alarm is on, switch will turn alarm off without
        //  changing the default variable 
        if(!PINC.0){
            H++;
            rtc_set_time(H, M, S);
        }
        if(!PINC.1){
            M++;
            rtc_set_time(H, M, S);      
        }
        if(!PINC.2){
            S=0;
            rtc_set_time(H, M, S);      
        }
        if(!PINC.3){
            D++;
            rtc_set_date(D, Mes, A);      
        }
        if(!PINC.3){
            Mes++;
            rtc_set_date(D, Mes, A);      
        }
        if(!PINC.3){
            A++;
            rtc_set_date(D, Mes, A);      
        }
        if(S>59){
            S=0;
            rtc_set_time(H, M, S); 
        }
        if(M>59){
            M=0;
            rtc_set_time(H, M, S);
        }
        if(H>23){
            H=0;
            rtc_set_time(H, M, S);  
        }
        if(D>31){
            D=0;
            rtc_set_date(D, Mes, A); 
        }
        if(Mes>12){
            Mes=0;
            rtc_set_date(D, Mes, A); 
        }
        if(A>25){
            A=00;
            rtc_set_date(D, Mes, A); 
        }
    }
}
