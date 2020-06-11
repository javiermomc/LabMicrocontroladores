import processing.serial.*;
Serial myPort; // Our serial port, creates a serial object form the serial library
//import processing.sound.*;
import ddf.minim.*;

AudioSnippet hit;
AudioSnippet raqueta;
AudioSnippet wall1;
AudioSnippet wall2;
AudioSnippet win;
AudioSnippet lose;
Minim minim; 


int score=0;
int life;
int sonido;
PFont font1;
boolean start=false;
int[] topScores;

float x = 40;
float y = 120;
float w = 120;
float h = 50;

void setup () {  
  //window
  size(440, 220);
  background(0,0,0);
  
  font1=loadFont("Verdana-Bold-48.vlw");
  topScores= int(loadStrings("topScores.txt"));//load text file
  printArray(topScores);
 
 //sounds
  minim= new Minim(this);
  hit= minim.loadSnippet("hit.mp3");
  raqueta= minim.loadSnippet("raqueta.mp3");
  wall1= minim.loadSnippet("wall1.mp3");
  wall2= minim.loadSnippet("wall2.mp3");
  win= minim.loadSnippet("win.mp3");
  lose= minim.loadSnippet("lose.mp3");
  
  //port
  println(Serial.list());// List all the available serial ports
  myPort = new Serial(this, "COM3", 9600);  
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
}


void draw(){
  
  background(0,0,0);
  textFont(font1, 24);
  start_button();
  
  text("Score .....",40,25);
  text(score,180,25);
  text("Lives ......",40,50);
  text(life,180,50); 
  //text("Sonido ...",40,75);
  //text(sonido,180,75);
  
  text("Top Scores",240,25);
  text("1.",240,50);
  text("2.",240,75);
  text("3.",240,100);
  text("4.",240,125);
  text("5.",240,150);
  
  text(topScores[0],270,50);
  text(topScores[1],270,75);
  text(topScores[2],270,100);
  text(topScores[3],270,125);
  text(topScores[4],270,150);
  
    
  get_info(myPort);
}



void get_info(Serial myPort) {  
// get the ASCII string:
String inString = myPort.readStringUntil('\n');
if (inString != null) {
// trim off any whitespace: space, carriage return, and tab
inString = trim(inString);
int[] data = int(split(inString,","));
  
  //sonido
  if(data[0]==1){
    sonido=data[1];
    if(sonido==0){raqueta.rewind();raqueta.play();} //collision bar
    if(sonido==1){wall1.rewind();  wall1.play();}   //collision wall
    if(sonido==2){hit.rewind();    hit.play();}     //collision matrix
    if(sonido==3){lose.rewind();   lose.play();}    //lose
  }
  
  //score
  if(data[0]==2){
    score+=data[1];
  }
  
  //lifes
  if(data[0]==3){
    life=data[1];
  }
  
  //finalizar partida
  if(data[0]==4){
    print("  _GAME OVER_  \n");
    topScore_update(score);
    score=0;
    start=false;
  }
  
 }
}
  

  
//Button function: starts the execution of the game in the microcontroller, it has to be pressed in order to play  
void start_button(){  
if (start==false){ 
  rect(x,y,w,h);
  fill(0);
  text("Start",65,150);
  fill(255);  
  if(mousePressed){
    if(mouseX>x && mouseX <x+w && mouseY>y && mouseY <y+h){
      println("The start button has been pressd");
      myPort.write('H');//send a character to the micro to start the execution
        start=true; 
        win.rewind();
        win.play();
    } 
  }
}
}




void topScore_update(int total_score){
  int i=0;
  int j=0;
  String[] newScores;

 //update the top scores table 
  for (i=0;i<5;i++)
  {
    if (total_score > topScores[i]){
      if (i<4){
        for(j=0;j<4-i;j++){
        topScores[4-j]=topScores[3-j];
        }
        topScores[i]=total_score;
      }else{
        topScores[i]=total_score;
      }
    break;
    }
  }
  //save it as a text file  
  newScores=str(topScores);    
  saveStrings("topScores.txt",newScores);
  printArray(topScores);
}
    
  
  
  
  

  


