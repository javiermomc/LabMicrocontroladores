

int i_game, j_game;
int score, life, level;

int left_wall, right_wall, bottom_wall;
void init_wall(int left, int right, int bottom){
    left_wall = left;
    right_wall = right;
    bottom_wall = bottom;    
}

int collision_wall(int x, int y){
    if(x<=left_wall){
        mandar_sonido(1);
        return 1;
    }
    if(x>=right_wall){ 
        mandar_sonido(1);
        return 2;
    }
    if(y<=-1){         
        mandar_sonido(1);
        return 3;
    }
    if(y>=bottom_wall){
        return 4;
    }
    return 0;
}

int matrix_game[][] = new int[8][8];

void init_matrix(){
    char value = 30;
    for(i_game=0; i_game<3; i_game++){
        for(j_game=0; j_game<8; j_game++){
            matrix_game[j_game][i_game] = value;
            prender_led(j_game, i_game);
        }                        
        value -= 10;
    }
}

int value_empty;
int empty_matrix(){
    value_empty = 0;
    for(i_game=0; i_game<3; i_game++){
        for(j_game=0; j_game<8; j_game++){
            if(matrix_game[j_game][i_game]>0)
              value_empty += 1;
        }                        
    }
    return value_empty;
}

int collision_matrix(int x, int y){
    if(x<0 || y<0 || x>7 || y>7)
        return 0;
    if(matrix_game[x][y]!=0){    
        mandar_sonido(2);
        return matrix_game[x][y];
    } 
    return 0;
}

int bar_position_x, bar_position_y, bar_size;

void init_bar(int x, int y, int size){
    bar_size = size;          
    bar_position_x = x;
    bar_position_y = y;                  
    for(i_game=x; i_game<(size+x); i_game++){
        prender_led(i_game, y);
    }
}

int collision_bar(int x, int y){
    if(x>=bar_position_x && x<=bar_position_x+bar_size-1 && y == bar_position_y){
        mandar_sonido(0);
        return x-bar_position_x+1;                                               
    }
    return 0;
}

void move_bar(int x, int y){
    bar_position_x = x;
    bar_position_y = y; 
    for(i_game=0; i_game<8; i_game++){
        if(i_game>=bar_position_x&&i_game<bar_position_x+bar_size)
            prender_led(i_game, y);
        else
            apagar_led(i_game, y);
    }
}

int ball_position_x, ball_position_y, ball_velocity_x, ball_velocity_y, init_velocity_x, init_velocity_y;

void init_ball(int x, int y, int velocity_x, int velocity_y){
    ball_position_x = x;
    ball_position_y = y;
    ball_velocity_x = velocity_x;
    ball_velocity_y = velocity_y;
    init_velocity_x = velocity_x;
    init_velocity_y = velocity_y;
    
    prender_led(x, y);
}

void setVelocity_ball(int velocity_x, int velocity_y){
    ball_velocity_x = velocity_x;
    ball_velocity_y = velocity_y;
}

void move_ball(int x, int y){
    apagar_led(ball_position_x, ball_position_y);
    ball_position_x = x;
    ball_position_y = y;
    prender_led(x, y);
}

void setup_game(){
    init_wall(-1, 8, 8);
    init_matrix();
    init_bar(3,7,3);
    init_ball(4,6,1,-1); 
    life = 5;
    mandar_pelotas(life);
    level = 0;
}

int next_x, next_y, is_collision_bar, is_collision_wall; 

void play_game(){

    move_bar(potenciometro_posicion*8/255, bar_position_y);
    next_x = ball_position_x+ball_velocity_x;
    next_y = ball_position_y+ball_velocity_y;
    is_collision_bar = 1;
    is_collision_wall = 1;
    while(is_collision_bar != 0 || is_collision_wall != 0){
        next_x = ball_position_x+ball_velocity_x;
        next_y = ball_position_y+ball_velocity_y;
        is_collision_bar = collision_bar(ball_position_x, next_y);
        switch(is_collision_bar){
            case 0:
                break;
            case 1:
                setVelocity_ball(ball_velocity_x, -ball_velocity_y);
                break;
            case 2:
                srand(TCNT0);
                setVelocity_ball(init_velocity_x*rand()%2-1, -ball_velocity_y);
                break;
            case 3:
                setVelocity_ball(ball_velocity_x, -ball_velocity_y);
                break;
        }
        next_x = ball_position_x+ball_velocity_x;
        next_y = ball_position_y+ball_velocity_y;
        is_collision_bar = collision_bar(next_x, next_y);
        switch(is_collision_bar){
            case 0:
                break;
            case 1:
                setVelocity_ball(-ball_velocity_x, -ball_velocity_y);
                break;
            case 2:
                srand(TCNT0);
                setVelocity_ball(init_velocity_x*rand()%2-1, -ball_velocity_y);
                break;
            case 3:
                setVelocity_ball(-ball_velocity_x, -ball_velocity_y);
                break;
        }
        next_x = ball_position_x+ball_velocity_x;
        next_y = ball_position_y+ball_velocity_y;                               
        is_collision_wall = collision_wall(next_x, next_y);
        switch(is_collision_wall){
            case 1:
                setVelocity_ball(-ball_velocity_x, ball_velocity_y);
                break;
            case 2:
                setVelocity_ball(-ball_velocity_x, ball_velocity_y);
                break;
            case 3:
                setVelocity_ball(ball_velocity_x, -ball_velocity_y);
                break;
            case 4:
                life -= 1;           
                if(life>0){
                    move_ball(5, 4);
                    ball_velocity_y = -ball_velocity_y;
                    ball_velocity_y = init_velocity_y;
                    ball_velocity_x = init_velocity_x;
                    mandar_pelotas(life);
                }else{
                    mandar_sonido(3);
                    mandar_fin();
                    setup_game();
                }
                break;
        }
        score = collision_matrix(next_x, ball_position_y);
        if(score != 0){
            setVelocity_ball(-ball_velocity_x, ball_velocity_y);
            matrix_game[next_x][ball_position_y] = 0;
            apagar_led(next_x, ball_position_y);
            mandar_puntuacion(score); 
        }
        next_x = ball_position_x+ball_velocity_x;
        next_y = ball_position_y+ball_velocity_y;
        score = collision_matrix(ball_position_x, next_y);
        if(score != 0){
            setVelocity_ball(ball_velocity_x, -ball_velocity_y);
            matrix_game[ball_position_x][next_y] = 0;
            apagar_led(ball_position_x, next_y);
            mandar_puntuacion(score); 
        }
        
        if(score == 0){
            score = collision_matrix(next_x, next_y);
            if(score!=0){
                setVelocity_ball(-ball_velocity_x, -ball_velocity_y);
                matrix_game[next_x][next_y] = 0;
                apagar_led(next_x, next_y);
                mandar_puntuacion(score);
                score = 0;
            } 
        } 
       next_x = ball_position_x+ball_velocity_x;
        next_y = ball_position_y+ball_velocity_y; 
        is_collision_bar = collision_bar(next_x, next_y);
        is_collision_wall = collision_wall(next_x, next_y);
    }
    if(ball_velocity_x>1)
      ball_velocity_x = 1;
    if(ball_velocity_x<-1)
      ball_velocity_x = -1;
    if(ball_velocity_y>1)
      ball_velocity_y = 1;
    if(ball_velocity_y<-1)
      ball_velocity_y = -1;
    move_ball(ball_position_x+ball_velocity_x, ball_position_y+ball_velocity_y);
    if(empty_matrix()==0){
      move_ball(5, 4);
      ball_velocity_y = -ball_velocity_y;
      ball_velocity_y = init_velocity_y;
      ball_velocity_x = init_velocity_x;
      init_matrix();
      level += 200;
    }
    delay_ms(potenciometro_velocidad*4-level);
}
