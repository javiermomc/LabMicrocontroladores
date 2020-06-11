/*
 * Matriz_Tenis.c
 *
 * Created: 26/05/2020 05:15:22 p. m.
 * Author: Chucho López Ortega
 */
#include <io.h>
#include <stdio.h>
#include <delay.h>

#define DIN PORTC.0
#define LOAD PORTC.1
#define CLK PORTC.2

// Voltage Reference: AVCC pin
#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))

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

unsigned char columnas[8];
unsigned char filas[8];
unsigned short estado[8];

void IniciaColumnas()
{
    unsigned char i;
    for (i=0;i<8;i++)
        columnas[i]=8-i;
}

void IniciaFilas()
{
    unsigned char i,j=1;
    for (i=0;i<8;i++)
    {             
        filas[7-i]=j;
        j = j*2;
    }    
}

void MandaMax7219 (unsigned int dato)
{
    unsigned char i;        //Contador para 16b
    CLK=0;                  //Valores de inicializacion
    LOAD=0;                 //Valores de inicializacion
    for (i=0;i<16;i++)
    {
        if ((dato&0x8000)==0)
            DIN=0;
        else 
            DIN=1;
        CLK=1;
        CLK=0;                
        dato=dato<<1;         //El siguiente bit pasa a ser el mas significativo
    }    
    LOAD=1;
    LOAD=0;
}

void ConfiguraMax(void)
{
    DDRC=0x07;              //Salidas en PC0,PC1,PC2
    MandaMax7219(0x0900);    //Mando a 0x09 un 0x00 (Decode Mode)
    MandaMax7219(0x0A08);    //Mando a 0x0A un 0x08 (Decode Mode)
    MandaMax7219(0x0B07);    //Mando a 0x0B un 0x07 (Decode Mode)
    MandaMax7219(0x0C01);    //Mando a 0x01 un 0x01 (Decode Mode)
    MandaMax7219(0x0F00);    //Mando a 0x0F un 0x00 (Decode Mode)
}


void EnciendeLED(unsigned char x,unsigned char y)
{           
    //Actualización del estado de la matriz
    estado[x]= columnas[x]<<8 | (estado[x] | filas[y]);  
    //Encendido de LED
    MandaMax7219(estado[x]);
}

void ApagaLED(unsigned char x,unsigned char y)
{
    //Actualización del estado de la matriz
    estado[x]= columnas[x]<<8 | (estado[x] ^ filas[y]);
    //Apagado de LED
    MandaMax7219(estado[x]);
}
 
void ControlRaqueta()
{
    unsigned char pos;
    pos = read_adc(7) * 1.4 / 204.6;   //Mapeo del valor de ADC (0-1023 adc to 0-5 volts to 0-7 bits)
    
    if (pos==0)                        //Acondicionamiento de bits a tamaño de la raqueta
        pos=1; 
        
    if (pos==7)
        pos=6;
                                       
    EnciendeLED(pos,7);                //Dibujado de la raqueta
    EnciendeLED(pos+1,7);
    EnciendeLED(pos-1,7);
    
    ApagaLED(pos,7);                   //Apagado necesario para reposicionar la raqueta
    ApagaLED(pos+1,7);
    ApagaLED(pos-1,7);                          
}

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

EnciendeLED(0,0);
EnciendeLED(0,1);  
       
EnciendeLED(1,0);
EnciendeLED(1,1);     
                                  
delay_ms(1000);
       
ApagaLED(0,0);
ApagaLED(1,1);


while (1)
    {     
        ControlRaqueta();
    }
}
