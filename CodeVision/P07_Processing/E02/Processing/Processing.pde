// Processing code for this example
// Dimmer - sends bytes over a serial port
// by David A. Mellis
//This example code is in the public domain.
import processing.serial.*;
Serial port;
void setup() {
size(256, 150);
println("Available serial ports:");
println(Serial.list());
port = new Serial(this, "COM5", 9600);
}
void draw() {
// draw a gradient from black to white
for (int i = 0; i < 256; i++) {
stroke(i);
line(i, 0, i, 150);
}
// write the current X-position of the mouse to the serial port as
// a single byte
port.write(mouseX);
}
