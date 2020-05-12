// Graphing sketch
// This program takes ASCII-encoded strings
// from the serial port at 9600 baud and graphs them. It expects values in the
// range 0 to 1023, followed by a newline, or newline and carriage return
// Created 20 Apr 2005, updated 18 Jan 2008
// by Tom Igoe

import processing.serial.*;
Serial myPort; // The serial port
int xPos = 1; // horizontal position of the graph
void setup () {
// set the window size:
size(400, 300);
 // List all the available serial ports
println(Serial.list());
myPort = new Serial(this, "COM5", 9600);
// don't generate a serialEvent() unless you get a newline character:
myPort.bufferUntil(13);
// set inital background:
background(0);
}
void draw () {
// everything happens in the serialEvent()
}
void serialEvent (Serial myPort) {
// get the ASCII string:
String inString = myPort.readStringUntil(13);
if (inString != null) {
// trim off any whitespace:
inString = trim(inString);
// convert to an int and map to the screen height:
float inByte = float(inString);
inByte = map(inByte, 0, 1023, 0, height);
// draw the line:
stroke(127,34,255);
line(xPos, height, xPos, height - inByte);
// at the edge of the screen, go back to the beginning:
if (xPos >= width) {
xPos = 0;
background(0);
}
else {
// increment the horizontal position:
xPos++;
}
}
}
