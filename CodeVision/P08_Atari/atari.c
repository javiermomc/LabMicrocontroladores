/*
 * atari.c
 *
 * Created: 26-May-20 5:13:31 PM
 * Author: javie
 */
                 
#define DIN PORTC.0
#define LOAD PORTC.1
#define CLK PORTC.2
 
#include <io.h>
#include <stdlib.h>
#include <delay.h>
#include "processing.c"
#include "matrix.c"
#include "game.c"

void main(void)
{

PORTD=0x07;     //seteo de botones

// ADC initialization
// ADC Clock frequency: 125.000 kHz
// ADC Voltage Reference: AVCC pin
// ADC High Speed Mode: Off
// Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
// ADC4: On, ADC5: On, ADC6: On, ADC7: Off
DIDR0=(1<<ADC7D) | (0<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
ADMUX=ADC_VREF_TYPE;
ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
ADCSRB=(1<<ADHSM);

ConfiguraMax();
IniciaColumnas();
IniciaFilas();

prender_led(0,0);
prender_led(0,1);  
       
prender_led(1,0);
prender_led(1,1);     
                                  
delay_ms(1000);
       
apagar_led(0,0);
apagar_led(1,1);


while (1)
    {   
        ControlRaqueta();
        if(processing_confirm==1){
            play_game();
        }
    }
}
