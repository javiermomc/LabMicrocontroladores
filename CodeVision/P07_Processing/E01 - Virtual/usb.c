/*
 * usb.c
 *
 * Created: 14/12/2016 04:03:55 p. m.
 * Author: adomingu
 */

#include <io.h>

#include <delay.h>

// USB Device functions
#include <usb_device.h>

// USB CDC Virtual Serial Port functions
#include <usb_cdc.h>

// USB initialization
#include "usb_init.h"

char value;

void main(void)
{

DDRB.7=1;
// USB Controller initialization in Full Speed, Device mode
// Note: This function also initializes the PLL
usb_init_device(&usb_config);

// Globally enable interrupts
#asm("sei")

// Wait for the USB device to be enumerated by the host
while (!usb_enumerated);

// Wait 1.5 seconds for the operating system to
// load any drivers needed by the USB device
delay_ms(1500);

// Wait for the USB host to be ready to receive serial data by
// setting the CDC Virtual Serial Port's RS-232 DTR signal high
//while (usb_cdc_serial.control.dtr==0);

    while (1)
    {      
     value=usb_serial_getchar();
        if(value=='H'){
             PORTB.7=1;
             //PORTD.6=1;
        }
            
        if(value=='L'){
            PORTB.7=0;  
            //PORTD.6=0;
            }


    }
}
