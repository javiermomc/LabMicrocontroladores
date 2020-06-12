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
#include "animacion.h"
#include "processing.c"
#include "matrix.c"
#include "game.c"



void main(void)
{

// USART1 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART1 Receiver: On
// USART1 Transmitter: On
// USART1 Mode: Asynchronous
// USART1 Baud Rate: 9600
UCSR1A=(0<<RXC1) | (0<<TXC1) | (0<<UDRE1) | (0<<FE1) | (0<<DOR1) | (0<<UPE1) | (0<<U2X1) | (0<<MPCM1);
UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (1<<RXEN1) | (1<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
UCSR1C=(0<<UMSEL11) | (0<<UMSEL10) | (0<<UPM11) | (0<<UPM10) | (0<<USBS1) | (1<<UCSZ11) | (1<<UCSZ10) | (0<<UCPOL1);
UBRR1H=0x00;
UBRR1L=0x0C;

// ADC initialization
// ADC Clock frequency: 125.000 kHz
// ADC Voltage Reference: Int., cap. on AREF
// ADC High Speed Mode: Off
// Only the 8 most significant bits of
// the AD conversion result are used
// Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
// ADC4: On, ADC5: On, ADC6: Off, ADC7: Off
DIDR0=(1<<ADC7D) | (1<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
ADMUX=ADC_VREF_TYPE;
ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
ADCSRB=(1<<ADHSM);
  
  
PORTD=0x07;     //seteo de botones


ConfiguraMax();
IniciaColumnas();
IniciaFilas();

//Aquí se despliega la animación de "Bienvenida" ... solamente se corre la primera vez que se juega
unsigned char i,j;
for (j=0;j<10;j++)
{
	for (i=1;i<9;i++)
    {                                          
        MandaMax7219((i<<8)|Animacion[j][8-i]);    
    }  
    delay_ms(400);
}

prender_led(0,0);
prender_led(0,1);  
       
prender_led(1,0);
prender_led(1,1);     
                                  
delay_ms(1000);
       
apagar_led(0,0);
apagar_led(1,1);


while (1)
    {   
         //start();
         ControlRaqueta();
         play_game();
       
    }
}
