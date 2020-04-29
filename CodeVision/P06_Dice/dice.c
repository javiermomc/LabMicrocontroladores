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
#include "Letras.h"

#define DIN PORTC.0
#define LOAD PORTC.1
#define CLK PORTC.2

unsigned int i=0, j=0;

flash int du=262,re= 294, ri=312, mi =330,fa=349, fi=370, sol=391,si=416, la=440, li=467, ti=494;
flash int MarioBros[591]={mi*2,mi*2,1,mi*2,1,du*2,mi*2,1,sol*2,1,1,1,sol,1,1,1,du*2,1,1,sol,1,1,mi,1,1,la,1,ti,1,li,la,1,sol,mi*2,1,sol*2,la*2,1,fa*2,sol*2,
1,mi*2,1,du*2,re*2,ti,1,1,du*2,1,1,sol,1,1,mi,1,1,la,1,ti,1,li,la,1,sol,mi*2,1,sol*2,la*2,1,fa*2,sol*2,1,mi*2,1,du*2,re*2,ti,1,1,1,1,sol*2,fi*2,fa*2,ri*2,1,
mi*2,1,si,la,du*2,1,la,du*2,re*2,1,1,sol*2,fi*2,fa*2,ri*2,1,mi*2,1,du*4,1,du*4,du*4,1,1,1,1,1,sol*2,fi*2,fa*2,ri*2,1,mi*2,1,si,la,du*2,1,la,du*2,re*2,1,1,
ri*2,1,1,re*2,1,1,du*2,1,1,1,1,1,1,1,1,1,sol*2,fi*2,fa*2,ri*2,1,mi*2,1,si,la,du*2,1,la,du*2,re*2,1,1,sol*2,fi*2,fa*2,ri*2,1,mi*2,1,du*4,1,du*4,du*4,1,1,1,
1,1,sol*2,fi*2,fa*2,ri*2,1,mi*2,1,si,la,du*2,1,la,du*2,re*2,1,1,ri*2,1,1,re*2,1,1,du*2,1,1,1,1,1,1,1,du*2,du*2,1,du*2,1,du*2,re*2,1,mi*2,du*2,1,la,sol,1,1,1,
du*2,du*2,1,du*2,1,du*2,re*2,1,1,1,1,1,1,1,1,du*2,du*2,1,du*2,1,du*2,re*2,1,mi*2,du*2,1,la,sol,1,1,1,mi*2,mi*2,1,mi*2,1,du*2,mi*2,1,sol*2,1,1,1,sol,1,1,1,du*2,
1,1,sol,1,1,mi,1,1,la,1,ti,1,li,la,1,sol,mi*2,1,sol*2,la*2,1,fa*2,sol*2,1,mi*2,1,du*2,re*2,ti,1,1,du*2,1,1,sol,1,1,mi,1,1,la,1,ti,1,li,la,1,sol,mi*2,1,sol*2,
la*2,1,fa*2,sol*2,1,mi*2,1,du*2,re*2,ti,1,1,mi*2,du*2,1,sol,1,1,si,1,la,fa*2,1,fa*2,la,1,1,1,ti,la*2,1,la*2,la*2,sol*2,1,fa*2,mi*2,du*2,1,la,sol,1,1,1,mi*2,du*2,
1,sol,1,1,si,1,la,fa*2,1,fa*2,la,1,1,1,ti,fa*2,1,fa*2,fa*2,mi*2,1,re*2,sol,mi,1,mi,du,1,1,1,mi*2,du*2,1,sol,1,1,si,1,la,fa*2,1,fa*2,la,1,1,1,ti,la*2,1,la*2,la*2,
sol*2,1,fa*2,mi*2,du*2,1,la,sol,1,1,1,mi*2,du*2,1,sol,1,1,si,1,la,fa*2,1,fa*2,la,1,1,1,ti,fa*2,1,fa*2,fa*2,mi*2,1,re*2,sol,mi,1,mi,du,1,1,1,du*2,du*2,1,du*2,1,
du*2,re*2,1,mi*2,du*2,1,la,sol,1,1,1,du*2,du*2,1,du*2,1,du*2,re*2,1,1,1,1,1,1,1,1,du*2,du*2,1,du*2,1,du*2,re*2,1,mi*2,du*2,1,la,sol,1,1,1,mi*2,mi*2,1,mi*2,1,du*2,
mi*2,1,sol*2,1,1,1,sol,1,1,1,mi*2,du*2,1,sol,1,1,si,1,la,fa*2,1,fa*2,la,1,1,1,ti,la*2,1,la*2,la*2,sol*2,1,fa*2,mi*2,du*2,1,la,sol,1,1,1,mi*2,du*2,1,sol,1,1,si,1,la,
fa*2,1,fa*2,la,1,1,1,ti,fa*2,1,fa*2,fa*2,mi*2,1,re*2,sol,mi,1,mi,du,1,1,1,0}; 


void noTono(){
    TCCR1B=0x00;
}

void tono(float freq){
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

char str[9] = "Welcome";
// Timer3 overflow interrupt service routine
interrupt [TIM3_OVF] void timer3_ovf_isr(void)
{
// Reinitialize Timer3 value
// Place your code here
    if(MarioBros[i/2]!=1){
        tono(MarioBros[i]);        
    }else
        noTono();
    if(i<590){                
        if(i%10==0){
            if(j<7)
                MandaLetra(str[j]);
            j++; 
        }       
        i++;    
    }else
        i=0;
    if(j<8){
        TCNT3H=0x9E58 >> 8;
        TCNT3L=0x9E58 & 0xff;
    }else{
        noTono();
        clear();
        TIMSK3=0;
    }            
}

char mode, n1, n2, n3, n4;
void main(void)
{
PORTD=0x03;     //init buttons

mode=0;
ConfiguraMax();
DDRC.6=1;

TCCR0B=0x01;    //init timer
DDRB.5=1;       //init speaker output
// init timer 3
TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (1<<CS31) | (0<<CS30);
TCNT3H=0x9E;
TCNT3L=0x58;
OCR3AH=0x30;
OCR3AL=0xD3;
TIMSK3=0x01;
#asm("sei")

while (1){
    if(j>=8)
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
}
