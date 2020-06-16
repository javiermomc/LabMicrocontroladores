
unsigned char columnas[8];
unsigned char filas[8];
unsigned short estado[8];
unsigned char potenciometro_posicion;
unsigned char potenciometro_velocidad;

//ADC
// Voltage Reference: Int., cap. on AREF
#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (1<<ADLAR))

// Read the 8 most significant bits
// of the AD conversion result
unsigned char read_adc(unsigned char adc_input)
{
ADMUX=adc_input | ADC_VREF_TYPE;
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=(1<<ADSC);
// Wait for the AD conversion to complete
while ((ADCSRA & (1<<ADIF))==0);
ADCSRA|=(1<<ADIF);
return ADCH;
}

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

void IniciaEstado()
{
    unsigned char i;
    for (i=0;i<8;i++)
        estado[i]=columnas[i]<<8 | 0x00;
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


void prender_led(unsigned char x,unsigned char y)
{           
    //Actualización del estado de la matriz
    estado[x]= columnas[x]<<8 | (estado[x] | filas[y]);  
    //Encendido de LED
    MandaMax7219(estado[x]);
}

void apagar_led(unsigned char x,unsigned char y)
{
    //Actualización del estado de la matriz
    if ((estado[x] & (columnas[x]<<8 | filas[y])) != (columnas[x]<<8 | 0x00))
        estado[x]= columnas[x]<<8 | (estado[x] ^ filas[y]);
        
    //Apagado de LED
    MandaMax7219(estado[x]);
}
 
void updateADC()
{
    potenciometro_posicion = read_adc(7); 
	potenciometro_velocidad = read_adc(6);
}
