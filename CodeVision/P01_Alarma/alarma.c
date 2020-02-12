/*
 * alarma.c
 *
 * Created: 11-Feb-20 5:39:55 PM
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

// Alarm

unsigned char alarmFlag; // Alarm flag to turn alarm on and off
eeprom unsigned char AH, AM; // Variables for alarm on EEPROM

unsigned char H=0,M=0,S=0; // Variables for clock
            
unsigned char time[16];

// ADC

// ADC variables
float temperature = 0;

// Voltage Reference: AREF pin
#define ADC_VREF_TYPE ((0<<REFS1) | (0<<REFS0) | (0<<ADLAR))

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


// Update ADC function
void updateADC(){
    // Convert ADC values to temperature
    temperature = (read_adc(7)*256.0)/1024.0; // Agus nos dio esta funcion
    // TEMPORAL print statement for DEV purposes only
    sprintf(time, "Temp: %d      ",read_adc(7));
    MoveCursor(0,0);
    StringLCDVar(time);
}

// Counter

unsigned char i=0, j=0;

// Tone

// Play frequency function
void tono(float freq){
    if(freq == 0)
        TCCR1B=0x00;
    else{
        float cuentas;
        unsigned int cuentasEnt;
        
        cuentas = 500000.0/freq;
        cuentasEnt = cuentas;
        if(cuentas-cuentasEnt>=0.5)
            cuentasEnt++;
        OCR1AH=(cuentasEnt-1)/256;
        OCR1AL=(cuentasEnt-1)%256;  
        TCCR1A=0x40;    // Timer 1 en modo de CTC
        TCCR1B=0x09;    // Timer en CK (sin pre-escalador)
    }
}

int k=0;
char kFlag=0;

// Play tone or song function
void playTone(){
    tono(k);
    if(kFlag==0)
        k+=50;
    else
        k-=50;
    if(k>500)
        kFlag=1;
    else if (k<=50)
        kFlag=0;
}

// LCD 
 
void printTime(){ 
//    sprintf(time, "Hora: %02i:%02i:%02i Temp: %f", H, M, S, temperature);
//    MoveCursor(0,0);
//    StringLCDVar(time);
//    sprintf(time, "Alarma: %02i:%02i   ", AH, AM);
//    MoveCursor(0,1);
//    StringLCDVar(time);
}

// Clock
void updateClock(){
    rtc_get_time(&H, &M, &S);
}

void main(void)
{

// ADC

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AREF pin
// ADC High Speed Mode: On
// Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
// ADC4: On, ADC5: On, ADC6: On, ADC7: On
DIDR0=(0<<ADC7D) | (0<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
ADMUX=ADC_VREF_TYPE;
ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
ADCSRB=(1<<ADHSM);

// LCD

SetupLCD();

// DS1302
rtc_init(0,0,0);

// Tone
DDRB.5=1;

// First actions
printTime();
PORTC = 0x0F;
rtc_get_time(&H, &M, &S);

while (1){
    // Please write your application code here
        // Counter
        delay_ms(50);
        j++;
        
        // ADC 
        updateADC();
        
        // 100 ms delay
        if(j%2==0){ 
           if(alarmFlag==1) {
            playTone();
           }   
           else
            tono(0);
        } 
        // 250 ms delay, add counter
        if(j%5==0)
            i++;
        // 500 ms delay, reset counter
        if(j%10==0)
            j=0;
        // Turns alarm flag on when H, M and S match
        if(S==0 && M==AM && H==AH)
            alarmFlag=1;
                  
        // 1 s delay
        if (i==4)
        {   
            // Update clock
            updateClock();
            // Print values un LCD display
            printTime(); 
        }
        
        // Clock
        
        // If alarm is on, switch will turn alarm off without
        //  changing the default variable 
        if(!PINC.0){
            if(alarmFlag==1)
                alarmFlag = 0;
            else{
                H++;
                rtc_set_time(H, M, S);
            }       
        }
        // If alarm is on, switch will turn alarm off without
        //  changing the default variable
        if(!PINC.1){
            if(alarmFlag==1)
                alarmFlag = 0;
            else{
                M++;
                rtc_set_time(H, M, S);
            }       
        }
        // Verify the correct range on clock time
        if(S>59)
            S=0;
        if(M>59)
            M=0;
        if(H>23)
            H=0;
        if(AM>59)
            AM=0;
        if(AH>23)
            AH=0;
        
        // Alarm
         
        // If alarm is on, switch will turn alarm off without
        //  changing the default variable
        if(!PINC.2){
            if(alarmFlag==1)
                alarmFlag = 0;
            else
                AH++;
        }
        // If alarm is on, switch will turn alarm off without
        //  changing the default variable
        if(!PINC.3){
            if(alarmFlag==1)
                alarmFlag = 0;
            else
                AM++;
        }
        // Verify the correct range on alarm time
        if(AM>59)
            AM=0;
        if(AH>23)
            AH=0;
    }
}
