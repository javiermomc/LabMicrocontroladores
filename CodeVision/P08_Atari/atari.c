/*
 * atari.c
 *
 * Created: 26-May-20 5:13:31 PM
 * Author: javie
 */

#include <io.h>
#include <stdlib.h>
#include <delay.h>
#include "game.c"

void main(void)
{

setup_game();

while (1)
    {
        play_game();
    }
}
