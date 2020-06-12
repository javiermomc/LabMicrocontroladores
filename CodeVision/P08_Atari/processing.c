// Processing

// Variables
char processing_value;    //variable que almacena los characteres mandados de procesing
char processing_confirm=0; //variable global para el funcionamiento del boton start

//	Functions

void start(){
  if (processing_confirm==0){
    do{ 
    processing_value=getchar();
    }while(processing_value!='H'); 
  processing_confirm=1;
  }
}

//valor entre 0 y 3, corresponden a cada sonido
void mandar_sonido(int sonido){
    printf("1,%d\n\r",sonido);
}

//valor numerico puntuacion
void mandar_puntuacion(int score){
    printf("2,%d\n\r",score);
}

//valor entre 0 y 5
void mandar_pelotas(int life){
    printf("3,%d\n\r",life);   
}

//finalizar partida
void mandar_fin(){
    printf("4,0\n\r");
    processing_confirm=0;
}
