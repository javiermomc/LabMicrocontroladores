flash char Animacion[38][8] = 
{
	//Welcome
	{24,24,0,2,2,0,24,24},      // ._.        1
    {8,16,8,2,2,8,16,8},        // ^-^        2
	{24,24,0,2,2,0,24,24},      // ._.        3
    {8,16,8,2,2,8,16,8},        // ^-^        4
    {8,16,10,3,3,10,16,8},      // ^o^        5
    {8,16,8,2,2,8,16,8},        // ^-^        6
    {8,16,10,3,3,10,16,8},      // ^o^        7
	{0,254,16,16,16,254,0,0},   // H          8
    {0,0,34,190,2,0,0,0},       // i          9
    {0,0,0,242,0,0,0,0},        // !          10
	//Game Over
	{8,8,17,2,2,17,8,8},        // unu        11
    {8,8,16,3,3,16,8,8},        // uou        12
    {8,8,17,2,2,17,8,8},        // unu        13
    {8,8,16,3,3,16,8,8},        // uou        14    
	{0,124,130,146,146,92,0,0}, // G		  15
	{0,4,42,42,42,30,0,0},      // a		  16
	{0,62,32,24,32,30,0,0},     // m          17    
	{0,28,42,42,42,24,0,0},     // e          18
	{0,124,130,130,130,124,0,0},// O          19
	{0,56,4,2,4,56,0,0},        // v          20 
	{0,28,42,42,42,24,0,0},     // e          21 
	{0,62,16,32,32,16,0,0},     // r          22
    {0,0,0,242,0,0,0,0},        // !          23
};

char i_animation, j_animation;

void startAnimation(){
    //Aquí se pone la animación de "Welcome" y se resetean los parámetros del juego
    for (j_animation=0;j_animation<10;j_animation++)
    {
        for (i_animation=1;i_animation<9;i_animation++)
        {	                                          
            MandaMax7219((i_animation<<8)|Animacion[j_animation][8-i_animation]);    
        }  
        delay_ms(400);
    }
}

void endAnimation(){
    //Aquí se pone la animación de "Welcome" y se resetean los parámetros del juego
    for (j_animation=10;j_animation<24;j_animation++)
    {
        for (i_animation=1;i_animation<9;i_animation++)
        {	                                          
            MandaMax7219((i_animation<<8)|Animacion[j_animation][8-i_animation]);    
        }  
        delay_ms(400);
    }
}