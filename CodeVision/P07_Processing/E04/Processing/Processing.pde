import processing.serial.*;
float redValue = 0; // red value
float greenValue = 0; // green value
float blueValue = 0; // blue value
Serial myPort;
void setup() {
size(200, 200);
println(Serial.list());
myPort = new Serial(this, "COM5", 9600);
// don't generate a serialEvent() unless you get a newline character:
myPort.bufferUntil('\n');
}
void draw() {
// set the background color with the color values:
background(redValue, greenValue, blueValue);
}
void serialEvent(Serial myPort) {
// get the ASCII string:
String inString = myPort.readStringUntil('\n');
if (inString != null) {
// trim off any whitespace:
inString = trim(inString);
// split the string on the commas and convert the
// resulting substrings into an integer array:
float[] colors = float(split(inString, ","));
// if the array has at least three elements, you know
// you got the whole thing. Put the numbers in the
// color variables:
if (colors.length >=3) {
// map them to the range 0-255:
redValue = map(colors[0], 0, 1023, 0, 255);
greenValue = map(colors[1], 0, 1023, 0, 255);
blueValue = map(colors[2], 0, 1023, 0, 255);
}
}
}
