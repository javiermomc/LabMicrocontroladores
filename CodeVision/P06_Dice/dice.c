/*
 * dice.c
 *
 * Created: 28-Apr-20 4:26:07 PM
 * Author: javie
 */

#include <io.h>
#include <stdlib.h>
#include <delay.h>
#include "MatrixDice.h"

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

void Dice1(char n)
{    
    //    Enviamos la columna y el valor de cada renglon
    MandaMax7219(0x0100|Dice[n-1][7]);       
    MandaMax7219(0x0200|Dice[n-1][6]);
    MandaMax7219(0x0300|Dice[n-1][5]);
    MandaMax7219(0x0400|Dice[n-1][4]);
    MandaMax7219(0x0500|Dice[n-1][3]);
    MandaMax7219(0x0600|Dice[n-1][2]);
    MandaMax7219(0x0700|Dice[n-1][1]);
    MandaMax7219(0x0800|Dice[n-1][0]);
}

void Dice2(char n1, char n2)
{    
    //    Enviamos la columna y el valor de cada renglon
    MandaMax7219(0x0100|SmallDice[n2-1][2]);
    MandaMax7219(0x0200|SmallDice[n2-1][1]);
    MandaMax7219(0x0300|SmallDice[n2-1][0]);
    MandaMax7219(0x0600|(SmallDice[n1-1][2]<<5));       
    MandaMax7219(0x0700|(SmallDice[n1-1][1]<<5));
    MandaMax7219(0x0800|(SmallDice[n1-1][0]<<5));
}

void Dice3(char n1, char n2, char n3)
{    
    //    Enviamos la columna y el valor de cada renglon
    MandaMax7219(0x0100|SmallDice[n2-1][2]);
    MandaMax7219(0x0200|SmallDice[n2-1][1]);
    MandaMax7219(0x0300|SmallDice[n2-1][0]);
    MandaMax7219(0x0600|SmallDice[n3-1][2]|(SmallDice[n1-1][2]<<5));       
    MandaMax7219(0x0700|SmallDice[n3-1][1]|(SmallDice[n1-1][1]<<5));
    MandaMax7219(0x0800|SmallDice[n3-1][0]|(SmallDice[n1-1][0]<<5));
}

void Dice4(char n1, char n2, char n3, char n4)
{    
    //    Enviamos la columna y el valor de cada renglon
    MandaMax7219(0x0100|SmallDice[n2-1][2]|(SmallDice[n4-1][2]<<5));
    MandaMax7219(0x0200|SmallDice[n2-1][1]|(SmallDice[n4-1][1]<<5));
    MandaMax7219(0x0300|SmallDice[n2-1][0]|(SmallDice[n4-1][0]<<5));
    MandaMax7219(0x0600|SmallDice[n3-1][2]|(SmallDice[n1-1][2]<<5));       
    MandaMax7219(0x0700|SmallDice[n3-1][1]|(SmallDice[n1-1][1]<<5));
    MandaMax7219(0x0800|SmallDice[n3-1][0]|(SmallDice[n1-1][0]<<5));
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

char mode, n1, n2, n3, n4;
void main(void)
{
PORTD=0x03;     //init buttons
TCCR0B=0x01;    //init timer
mode=0;
ConfiguraMax();
clear();
while (1)
    {
    // Please write your application code here
        if(!PIND.0){ // 1 Dice 
            clear();                                   
            if(mode==0){
                srand(TCNT0);
                n1 = rand()%6+1;
                Dice1(n1);
            }else if(mode==1){
                srand(TCNT0);
                n1 = rand()%6+1;
                srand(TCNT0);
                n2 = rand()%6+1;
                Dice2(n1, n2);
            }else if(mode==2){
                n1 = rand()%6+1;
                srand(TCNT0);
                n2 = rand()%6+1;
                srand(TCNT0);
                n3 = rand()%6+1;
                Dice3(n1, n2, n3);
            }else if(mode==3){
                srand(TCNT0);
                n1 = rand()%6+1;
                srand(TCNT0);
                n2 = rand()%6+1;
                srand(TCNT0);
                n3 = rand()%6+1;
                srand(TCNT0);
                n4 = rand()%6+1;
                Dice4(n1, n2, n3, n4);
            }
            delay_ms(100);
        }if(!PIND.1){
            mode++;
            if(mode>3)
                mode=0;
            delay_ms(100);   
        }

    }
}
