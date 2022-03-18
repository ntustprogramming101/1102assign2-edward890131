PImage title;
PImage startNormal;
PImage startHovered;
PImage restartNormal;
PImage restartHovered;
PImage gameover;

PImage sky;
PImage soil;
PImage life;
PImage cabbage;
PImage soldier;
PImage groundhogIdle;
PImage groundhogLeft;
PImage groundhogRight;
PImage groundhogDown;


//set up the state of game
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

int gameState;
int piece = 80;

int cabbageX = floor(random(4))*piece;
int cabbageY = piece*2 + floor(random(4))*piece;

int soldierX;
int soldierY = piece*2 + floor(random(4))*piece;

int btnX = 248;
int btnY = 360;
int btnWidth = 144;
int btnHeight = 60;

void setup() {
	size(640, 480, P2D);
  
  title = loadImage("img/title.jpg"); 
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  gameover = loadImage("img/gameover.jpg");

  sky = loadImage("img/bg.jpg"); 
  soil = loadImage("img/soil.png"); 
  life = loadImage("img/life.png");
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  groundhogIdle = loadImage("img/groundhogIdle.png"); 
  groundhogLeft = loadImage("img/groundhogLeft.png"); 
  groundhogRight = loadImage("img/groundhogRight.png"); 
  groundhogDown = loadImage("img/groundhogDown.png"); 
  
  
}

void draw() {
	// Switch Game State
  switch(gameState){
    
    case GAME_START: // Game Start
      
      //place the img & btn
      image(title, 0, 0);
      image(startNormal, btnX, btnY);
      
      //while hovering on the btn, change the btn
      if(mouseX < btnX+btnWidth && mouseX > btnX 
        && mouseY < btnY+btnHeight && mouseY > btnY){
          image(startHovered, btnX, btnY);
       }
      
      //if press the hoverbtn, go to state2 (GAME_RUN)
      
    break;
    
    case GAME_RUN: // Game Run
      //set up the bg
      image(sky, 0, 0);
      image(soil, 0, piece*2);//bg
      noStroke();
      fill(124, 204, 25);
      rect(0, 145, 640, 15);  //gress
      fill(255, 255, 0);
      noStroke();
      ellipse(590, 50, 130, 130);
      fill(253, 184, 19);
      noStroke();
      ellipse(590, 50, 120, 120); //sun
      
      
      image(groundhogIdle, piece*4, 80); 
      image(life, 10, 10);
      image(life, 80, 10); //default life *2 
    
      image(cabbage, cabbageX, cabbageY);
    
      soldierX += 2;
      if(soldierX > width){
      soldierX =- piece; //
      }
      image(soldier, soldierX, soldierY); //soldier
      
    break;
    
    case GAME_OVER: // Game Lose
    break;
    
  }
}

void keyPressed(){
}

void keyReleased(){
}
