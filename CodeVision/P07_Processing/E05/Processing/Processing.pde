/*
  Author: Javier Mondragon Martin del Campo
  Organization: ITESM Qro.
  Date: 05/May/2020
*/

import processing.serial.*;
Serial port;

LED[][] m = new LED[8][8];
char[] line = new char[8];

void setup(){
    size(160, 160);
    background(255,255,255);
    println("Available serial ports:");
    println(Serial.list());
    port = new Serial(this, "COM5", 9600); 
    text("Loading...", 80, 80);
    
    for(char i=0; i<8; i++){
      for(char j=0; j<8; j++){
        m[i][j] = new LED(20*i+10, 20*j+10, 10);
        m[i][j].setColorHover(183, 193, 78);
        m[i][j].setColorOn(81, 79, 224);
      }
      line[i]=0;
    }
}

void draw(){
  for(char i=0; i<8; i++){
    for(char j=0; j<8; j++){
      m[i][j].onMouseHover();
    }
  } 
}

void mouseClicked(){
  for(char i=0; i<8; i++){
    line[i]=0;
    for(char j=8; j>0; j--){
      m[i][j-1].onMouseClick();
      if(m[i][j-1].getState())
        line[i] = (char)(line[i] | 1 << 8-j);
    }
    System.out.printf("%d/%03d:", (int)i, (int)line[i]);
    //port.write(line[i]);
  }
  println();
  
  
}

class Circle{
  int x, y, radius, r, g, b;
  float hyp;
  
  Circle(int x, int y, int radius){
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.hyp = pow((float)radius, 2);
    createCircle(); 
  }
  
  Circle(int x, int y, int radius, int r, int g, int b){
    this.x = x;
    this.y = y;
    this.radius = radius;
    fill(r, g, b);
    createCircle();
  }
  
  private void createCircle(){
    ellipseMode(RADIUS);
    ellipse(this.x, this.y, this.radius, this.radius);
  }
  
  public boolean hover(int x, int y){
    float hyp = pow((float)(x-this.x), 2) + pow((float)(y-this.y), 2);
    return (this.hyp>hyp) ? true : false;
  }
  
  public void fillCircle(int r, int g, int b){
    fill(r, g, b);
    createCircle();
  }  
}

class LED extends Circle{
  
  boolean state = false;
  boolean hoverState = true;

  int[] hover = {255, 255, 255}, 
          off = {255, 255, 255}, 
          on  = {255, 255, 255};
          
  public LED(int x, int y, int radius){
    super(x, y, radius);
  }
  
  public LED(int x, int y, int radius, int r, int g, int b){
    super(x, y, radius, r, g, b);
  }
  
  public void setState(){
    if(state)
      fillCircle(on[0], on[1], on[2]);
    else
      fillCircle(off[0], off[1], off[2]);
  }
  
  public boolean getState(){
    return state;
  }
  
  public void setHover(){
    fillCircle(hover[0], hover[1], hover[2]);
  }
  
  public void setColorHover(int r, int g, int b){
    this.hover[0] = r;
    this.hover[1] = g;
    this.hover[2] = b;
  }
  
  public void setColorOn(int r, int g, int b){
    this.on[0] = r;
    this.on[1] = g;
    this.on[2] = b;
  }
  
  public void setColorOff(int r, int g, int b){
    this.off[0] = r;
    this.off[1] = g;
    this.off[2] = b;
  }
  
  public void onMouseClick(){
    if(hover(mouseX, mouseY))
      if(state)
        state = false;
       else
         state = true;
    hoverState = false;
    setState();
  }
  
  public void onMouseHover(){
    if (hover(mouseX, mouseY)){
      if (hoverState){
        setHover();
      }
    } else {
      setState();
      hoverState = true;
    }  
  }  
}
