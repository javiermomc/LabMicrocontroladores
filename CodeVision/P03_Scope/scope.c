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

char buffer[128];

void frequency(){
    
}

// Fills the array to sample the scope shot
void scope(){
    for (i=0;i<128;i++){
        buffer[i] = read_adc(7);
        delay_us(39);
    }
}

// Trigger for scope shot
PORTD.7 = 1;

void main(void) {

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

    while (1) {
    // Please write your application code here
        if (PIND.7 == 0){
            scope();
        }
    }
}
