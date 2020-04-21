/*
 * Matriz_LEDS.c
 *
 * Created: 21/04/2020 05:36:03 p. m.
 * Author: Chucho L�pez Ortega
 */

#include <io.h>
#include <delay.h>
#include "Letras.h"

#define DIN PORTC.0
#define LOAD PORTC.1
#define CLK PORTC.2

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

void MandaLetra(char letra)
{
    unsigned char i;
    letra=letra-32;          //offset de la tabla (espacio es el primer caracter)
    MandaMax7219(0x0100);    //elimino las columnas que no ocupo
    MandaMax7219(0x0200);    //elimino las columnas que no ocupo
    MandaMax7219(0x0800);    //elimino las columnas que no ocupo
    
    for (i=3;i<8;i++)
        MandaMax7219((i<<8)|Letras[letra][7-i]);
                                             
//    Unimos la columna y el valor de cada renglon
//    MandaMax7219(0x0300|Letras[letra][4]);       
//    MandaMax7219(0x0400|Letras[letra][3]);
//    MandaMax7219(0x0500|Letras[letra][2]);
//    MandaMax7219(0x0600|Letras[letra][1]);
//    MandaMax7219(0x0700|Letras[letra][0]);
}

void main(void)
{

PORTD=0x07;     //seteo de botones
ConfiguraMax();
while (1)
    {
    // Please write your application code here
        MandaMax7219(0x01FF); 
        MandaMax7219(0x02FF);
        MandaMax7219(0x03FF);
        MandaMax7219(0x04FF);
        MandaMax7219(0x05FF);
        MandaMax7219(0x06FF);
        MandaMax7219(0x07FF);
        MandaMax7219(0x08FF);   
        delay_ms(2000);
        MandaLetra('F');
        delay_ms(2000);
    }
}
