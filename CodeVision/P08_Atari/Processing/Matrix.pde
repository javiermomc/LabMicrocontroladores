
void prender_led(int x, int y){
  m[x][y].turnOn();
}

void apagar_led(int x, int y){
  m[x][y].turnOff();
}

void mandar_puntuacion(int p){
  points += p;
}

int rand(){
  return (int)(round(random(1)*2-1));
}

void mandar_pelotas(int p){
  lifes = p;
}

int potenciometro_posicion;
