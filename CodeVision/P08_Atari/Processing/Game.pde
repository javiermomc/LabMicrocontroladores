

int i_game, j_game;
int score, life;

int left_wall, right_wall, bottom_wall;
void init_wall(int left, int right, int bottom){
    left_wall = left;
    right_wall = right;
    bottom_wall = bottom;    
}

int collision_wall(int x, int y){
    if(x<=left_wall){
        return 1;
    }
    if(x>=right_wall){
        return 2;
    }
    if(y<=-1){
        return 3;
    }
    if(y>=bottom_wall){
        return 4;
    }
    return 0;
}

int matrix_game[][] = new int[8][8];

void init_matrix(){
    char value = 10;
    for(i_game=0; i_game<3; i_game++){
        for(j_game=0; j_game<8; j_game++){
            matrix_game[j_game][i_game] = value;
            prender_led(j_game, i_game);
        }                        
        value += 10;
    }
}

int collision_matrix(int x, int y){
    if(x<0 || y<0 || x>7 || y>7)
        return 0;
    if(matrix_game[x][y]!=0){
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
}

void play_game(){

    move_bar(potenciometro_posicion*8/255, bar_position_y);
    int next_x = ball_position_x+ball_velocity_x;
    int next_y = ball_position_y+ball_velocity_y;
    int is_collision_bar = 1;
    int is_collision_wall = 1;
    while(is_collision_bar != 0 || is_collision_wall != 0 || score != 0){
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
                setVelocity_ball(init_velocity_x*rand()%2-1, -ball_velocity_y);
                break;
            case 3:
                setVelocity_ball(-ball_velocity_x, -ball_velocity_y);
                break;
        }
        score = collision_matrix(next_x, ball_position_y);
        if(score != 0){
            setVelocity_ball(-ball_velocity_x, ball_velocity_y);
            matrix_game[next_x][ball_position_y] = 0;
            apagar_led(next_x, ball_position_y);
            mandar_puntuacion(score); 
            score = 0;
        }
        score = collision_matrix(ball_position_x, next_y);
        if(score != 0){
            setVelocity_ball(ball_velocity_x, -ball_velocity_y);
            matrix_game[ball_position_x][next_y] = 0;
            apagar_led(ball_position_x, next_y);
            mandar_puntuacion(score); 
            score = 0;
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
                move_ball(5, 4);
                ball_velocity_y = -ball_velocity_y;
                ball_velocity_y = init_velocity_y;
                ball_velocity_x = init_velocity_x;
                mandar_pelotas(life);
                break;
        }
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
    delay(1000);
}
