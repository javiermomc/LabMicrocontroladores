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

// Clock
unsigned char H=0,M=0,S=0; // Variables for clock
unsigned char time[16];

// LCD 
void printTime(){ 
    sprintf(time, "%02i:%02i:%02i  %02i.%i%cC", H, M, S, tempInt, tempDec, 223);
    MoveCursor(0,0);
    StringLCDVar(time);
    sprintf(time, "  Alarma %02i:%02i   ", AH, AM);
    MoveCursor(0,1);
    StringLCDVar(time);     
}

// Clock
void updateClock(){
    rtc_get_time(&H, &M, &S);
}


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

while (1)
    {
    // Please write your application code here

    }
}
