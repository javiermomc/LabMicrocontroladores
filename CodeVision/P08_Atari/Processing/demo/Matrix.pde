
void prender_led(int x, int y){
  m[x][y].turnOn();
}

void apagar_led(int x, int y){
  m[x][y].turnOff();
}

void mandar_puntuacion(int p){
  points += p;
}

void mandar_pelotas(int p){
  lifes = p;
}

void mandar_sonido(int s){}

void mandar_fin(){}

int potenciometro_posicion;
int potenciometro_velocidad;

// CodeVision

int TCNT0 = 0;

int rand(){
  return (int)(round(random(1)*2-1));
}

void srand(int p){
}

void delay_ms(int value){
  delay(value);
}

void startAnimation(){}
void endAnimation(){}
