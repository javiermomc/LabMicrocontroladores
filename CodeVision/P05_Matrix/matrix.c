/*
 * Matriz_LEDS.c
 *
 * Created: 21/04/2020 05:36:03 p. m.
 * Author: Chucho López Ortega
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
    letra=letra-32;          //offset de la tabla (espacio es el primer caracter)
    MandaMax7219(0x0100);    //elimino las columnas que no ocupo
    MandaMax7219(0x0200);    //elimino las columnas que no ocupo
    MandaMax7219(0x0800);    //elimino las columnas que no ocupo
    
    //    Unimos la columna y el valor de cada renglon
    MandaMax7219(0x0300|Letras[letra][4]);       
    MandaMax7219(0x0400|Letras[letra][3]);
    MandaMax7219(0x0500|Letras[letra][2]);
    MandaMax7219(0x0600|Letras[letra][1]);
    MandaMax7219(0x0700|Letras[letra][0]);
}

void clear(){
    MandaMax7219(0x0100);
    MandaMax7219(0x0200);
    MandaMax7219(0x0300);
    MandaMax7219(0x0400);
    MandaMax7219(0x0500);
    MandaMax7219(0x0600);
    MandaMax7219(0x0700);
    MandaMax7219(0x0800);
}


int l1, l2, l3, l4, l5, l6, l7, l8, lsize;
void MensajeCorrido(char *str, char size){
    char i=0, j=0;
    clear();
    lsize = (size-1)*5;
    for(i=0; i<lsize+8; i++){
        l8 = l7;
        l7 = l6;
        l6 = l5;
        l5 = l4;
        l4 = l3;
        l3 = l2;
        l2 = l1;
        if(i<lsize)
            l1 = Letras[str[j]-32][i%5];
        else
            l1 = 0;
        if(i%5==4)
            j++;
        MandaMax7219(0x0100|l1);
        MandaMax7219(0x0200|l2);
        MandaMax7219(0x0300|l3);
        MandaMax7219(0x0400|l4);
        MandaMax7219(0x0500|l5);
        MandaMax7219(0x0600|l6);
        MandaMax7219(0x0700|l7);
        MandaMax7219(0x0800|l8);
        delay_ms(250);    
    }
    
}

void main(void)
{

PORTD=0x07;     //seteo de botones
ConfiguraMax();
while (1)
    {
    // Please write your application code here
        if(!PIND.0){
            MandaLetra('F'); 
            delay_ms(1000);
            MandaLetra('U');
            delay_ms(1000);
            MandaLetra('N');
            delay_ms(1000);
            MandaLetra('C');
            delay_ms(1000);
            MandaLetra('I');
            delay_ms(1000);
            MandaLetra('O');
            delay_ms(1000);
            MandaLetra('N');
            delay_ms(1000);
            MandaLetra('A');
            delay_ms(1000);
            MandaLetra('N');
            delay_ms(1000);
            MandaLetra('D');
            delay_ms(1000);
            MandaLetra('O');
            delay_ms(1000);
        }else if(!PIND.1){
            char str[] = "Inserte mensaje aqui..."; 
            MensajeCorrido(str, sizeof(str));
        }else 
            clear();
    }
}