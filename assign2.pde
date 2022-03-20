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

final int LIFE_DEFAULT = 0;
final int LIFE_1 = 1;
final int LIFE_3 = 2;
final int LIFE_0 = 3;


int gameState;
int lifeState;
int piece = 80;
int groundhogCount;

int btnX = 248;
int btnY = 360;
int btnWidth = 144;
int btnHeight = 60;

int cabbageX = floor(random(4))*piece;
int cabbageY = piece*2 + floor(random(4))*piece;

int soldierX;
int soldierY = piece*2 + floor(random(4))*piece;

float groundhogX = piece*4;
float groundhogY = piece;

int lifeX = 10;
int lifeY = 10;
int lifeWidth = 50;
int lifeSpacing = 20;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

boolean  eatCabbage = false;
boolean  meetSoldier = false;

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
  
  gameState = GAME_START;
  lifeState = LIFE_DEFAULT;
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
          if (mousePressed){
            // click
            gameState = GAME_RUN;
          } else{
            // hover
            image(startHovered, btnX, btnY);
          }
       }
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
     
      
      //cabbage
      image(cabbage, cabbageX, cabbageY);
 
    
      //soldier
      soldierX += 2;
      if(soldierX > width){
      soldierX =- piece; //
      }
      image(soldier, soldierX, soldierY); 
      
     
      //groundhog control
      image(groundhogIdle, groundhogX, groundhogY); 
      
      //if(upPressed){
      //  groundhogY -= piece;
      //}
      //if(downPressed){
      //  //image(groundhogDown, groundhogX, groundhogY); 
      //  groundhogY += piece;
      //}
      //if(leftPressed){
      //  //image(groundhogLeft, groundhogX, groundhogY); 
      //  groundhogX -= piece;
      //}
      //if(rightPressed){
      //  //image(groundhogRight, groundhogX, groundhogY); 
      //  groundhogX += piece;
      //}
      

      //boundary detection of the groundhog
      if(groundhogX < 0){
        groundhogX = 0;
      }
      if(groundhogX > width - piece){
        groundhogX = width - piece;
      }
      if(groundhogY < piece){
        groundhogY = piece;
      }
      if(groundhogY > height - piece){
        groundhogY = height - piece;
      }
      
      //groundhog meetSoldier -> turn to initial 
      if (groundhogX < soldierX+piece && groundhogX+piece > soldierX 
      && groundhogY < soldierY+piece && groundhogY+piece > soldierY){
        meetSoldier = true;
        println("meetSoldier");
        groundhogX = piece*4;
        groundhogY = piece;
      }
      
      
      //groundhog eatCabbage -> cabbage gone 
      if (groundhogX < cabbageX+piece && groundhogX+piece > cabbageX 
      && groundhogY < cabbageY+piece && groundhogY+piece > cabbageY){
        eatCabbage = true;
        println("eatCabbage");
        cabbageX = width + piece;
        cabbageY = height + piece;
      }
      
      
            
      //life
      //image(life, lifeX, lifeY);
      //image(life, lifeX+lifeWidth+lifeSpacing, lifeY); //default life == 2 
      
      switch(lifeState){
        case LIFE_DEFAULT:
          image(life, lifeX, lifeY);
          image(life, lifeX+lifeWidth+lifeSpacing, lifeY);
          if(eatCabbage){
            println("life 2-3");
            lifeState = LIFE_3;
            eatCabbage = false;
          }
          else if(meetSoldier){
            println("life 2-1");
            lifeState = LIFE_1;
            meetSoldier = false;
          }
        break;
        
        case LIFE_1:
          image(life, lifeX, lifeY);
          if(eatCabbage){
            println("life 1-2");
            lifeState = LIFE_DEFAULT;
            eatCabbage = false;
          }
          else if(meetSoldier){
            println("life 1-0");
            lifeState = LIFE_0;
            meetSoldier = false;
          }
        break;
        
        case LIFE_3:
          image(life, lifeX, lifeY);
          image(life, lifeX+lifeWidth+lifeSpacing, lifeY);
          image(life, lifeX+lifeWidth*2+lifeSpacing*2, lifeY);
          if(meetSoldier){
            println("life 3-2");
            lifeState = LIFE_DEFAULT;
            meetSoldier = false;
          }
        break;
        
        case LIFE_0:
          //reset the cab & life
          lifeState = LIFE_DEFAULT;
          cabbageX = floor(random(4))*piece;
          cabbageY = piece*2 + floor(random(4))*piece;
          gameState = GAME_OVER;
        break;
      }
      

    break;
    
    case GAME_OVER: // Game Lose
      image(gameover, 0, 0);
      image(restartNormal, btnX, btnY);
        
      //while hovering on the btn, change the btn
      if(mouseX < btnX+btnWidth && mouseX > btnX 
         && mouseY < btnY+btnHeight && mouseY > btnY){
           if (mousePressed){
              // click
              gameState = GAME_RUN;
            } else{
              // hover
              image(restartHovered, btnX, btnY);
            }
       }
    break;
    
  }
}

void keyPressed(){
   if (key == CODED) {
    switch (keyCode) {
      case UP:
        for(groundhogCount = 0; groundhogCount <= 15; groundhogCount++){
          image(groundhogIdle, groundhogX, groundhogY); 
          groundhogY -= piece/15;
        }
        image(groundhogIdle, groundhogX, groundhogY); 
        break;
       
      case DOWN:
        for(groundhogCount = 0; groundhogCount <= 15; groundhogCount++){
          image(groundhogDown, groundhogX, groundhogY); 
          groundhogY += piece/15;
        }
        image(groundhogIdle, groundhogX, groundhogY); 
        break;
        
      case LEFT:
        for(groundhogCount = 0; groundhogCount <= 15; groundhogCount++){
          image(groundhogLeft, groundhogX, groundhogY); 
          groundhogX -= piece/15;
        }
        image(groundhogIdle, groundhogX, groundhogY); 
        break;
        
      case RIGHT:
        for(groundhogCount = 0; groundhogCount <= 15; groundhogCount++){
          image(groundhogRight, groundhogX, groundhogY); 
          groundhogX += piece/15;
        }
        image(groundhogIdle, groundhogX, groundhogY); 
        break;
    }
  }
}

void keyReleased(){
  image(groundhogIdle, groundhogX, groundhogY); 
}

//void keyPressed() {
//  if (key == CODED) { // detect special keys 
//    switch (keyCode) {
//      case UP:
//        upPressed = true;
//        break;
//      case DOWN:
//        downPressed = true;
//        break;
//      case LEFT:
//        leftPressed = true;
//        break;
//      case RIGHT:
//        rightPressed = true;
//        break;
//    }
//  }
//}

//void keyReleased() {
//  image(groundhogIdle, groundhogX, groundhogY); 
//  if (key == CODED) {
//    switch (keyCode) {
//      case UP:
//        upPressed = false;
//        break;
//      case DOWN:
//        downPressed = false;
//        break;
//      case LEFT:
//        leftPressed = false;
//        break;
//      case RIGHT:
//        rightPressed = false;
//        break;
//    }
//  }
//}
