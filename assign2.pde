int X=80;

PImage bg;
PImage soil;
PImage hog;
PImage life;
PImage soldier;
PImage cabbage;
PImage title;
PImage startNormal;
PImage startHovered;
PImage restartNormal;
PImage restartHovered;
PImage gameOver;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 360+60;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 248+144;

int soldierX = 80;
int soldierWidth = 80;
int hogWidth = 80;
int startX = 248;
int startY = 360;
int hogX ;
int hogY ;
int lifeNum = 2;

//soldier random move
float soldierY = X*floor(random(2,5.99));

//cabbage random move
float cabbageX = X*floor(random(0,7.99));
float cabbageY = X*floor(random(2,5.99));

int soldierSpeed = 5;
int grass = 15;
int lifeWidth = 50;


void setup() {
	size(640, 480, P2D);
  title=loadImage("img/title.jpg");
  image(title, 0, 0);
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  gameOver=loadImage("img/gameover.jpg");
  
  
  hogX = X*4;
  hogY = X;

}

void draw() {
  
	// Switch Game State

  switch(gameState){
    
		// Game Start

    case GAME_START:
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHovered, startX, startY);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal, startX, startY);
      }
    break;
		// Game Run
    case GAME_RUN:
      //background
      bg = loadImage("img/bg.jpg");
      image(bg, 0, 0, 640, 480);
       
      //grass
      fill(124,204,25);
      noStroke();
      rect(0,X*2-grass,X*8,grass);
      
      //life
      life = loadImage("img/life.png");
      for (int x = 0; x < lifeNum; x++) {
      image(life, 10 + x*70, 10);
      }
      
      //big sun
      fill(255,255,0);
      ellipse(640-50,50,120+5*2,120+5*2);
      
      //small sun
      fill(253,184,19);
      ellipse(640-50,50,120,120);
      
      //soil
      soil = loadImage("img/soil.png");
      image(soil, 0, X*2, X*8, X*4);
      
      //groundhog
      hog = loadImage("img/groundhogIdle.png");
      image(hog, hogX, hogY);
      
      //soldier
      soldier = loadImage("img/soldier.png");
      image(soldier, soldierX-soldierWidth, soldierY);  
  
      //soldier move to right
      soldierX+=soldierSpeed;
      soldierX%=640+soldierWidth;
      
      //cabbage
      cabbage = loadImage("img/cabbage.png");
      image(cabbage, cabbageX, cabbageY); 
      
      //hit soldier
      
      if(soldierY-hogY<80 && soldierY>hogY-1 ){
      if(hogX+80>soldierX-80 && hogX<soldierX){
      hogX=X*4;
      hogY=X;
      lifeNum --;
      if (lifeNum == 0) {
        gameState = GAME_OVER;
        }
       }
      }
      
      //hit cabbage

      if (
      hogX < cabbageX+X && 
      hogX+X > cabbageX &&
      hogY < cabbageY+X &&
      hogY+X > cabbageY) {
      lifeNum ++;
      cabbageX = -100;
      cabbageY = -100;
    }
            
    break;
    
		// Game Lose
    case GAME_OVER:
      image(gameOver, 0, 0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered, startX, startY);
        if(mousePressed){
          gameState = GAME_RUN;
          lifeNum = 2;
        }
      }else{
        image(restartNormal, startX, startY);
      }
      break;
  }
}

void keyPressed(){
  

    if (key == CODED) { // detect special keys 
      switch (keyCode) {

      case DOWN:

        hogY += X;
        if(hogY + hogWidth > height) hogY = height - hogWidth;
        
        break;
      case LEFT:
        hogX -= X;
        if(hogX < 0) hogX = 0;
        
        break;
      case RIGHT:
        hogX += X;
        while(hogX + hogWidth > width) hogX = width - hogWidth;
        
        break;
    }
  }
}
