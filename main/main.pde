final int screenX = 1000;
final int screenY = 600;
int ballX = screenX;
int ballY = 500;
int ballSize = 10;

final int playerWidth = 10;
final int playerHeight = 70;
int leftPlayerY = screenY/2 - playerHeight/2;
int leftPlayerX = 100;

int playerPadding = 100;

boolean movingLeft = true;

Player1 player1;
Player player2;

void setup() {
  frameRate(100);
  pixelDensity(2);
  size(1000, 600);
  
  player1 = new Player1();
  player2 = new Player2();
}

void moveBallX(){
  int limit = screenX - 10;
  if (movingLeft)
    ballX-=5;
  else
    ballX+=5;
  
  if(movingLeft && ballX < 10)
    movingLeft = false;
    
  if (!movingLeft && ballX > limit)
    movingLeft = true;
}

boolean isMovingUP = true;
void moveBallY() {
  
  if (isMovingUP)
    ballY--;
  else
    ballY++;
  
  if (isMovingUP && ballY < (ballSize/2))
    isMovingUP = false;
  
  if (!isMovingUP && ballY > (screenY-ballSize/2))
    isMovingUP = true;
}

void invertBallDirectionY () {
  movingLeft = !movingLeft;
}

abstract class Player {
  int x;
  int y;
  int width;
  int height;
  
  Player(){
    width=10;
    height=70;
  }

  abstract boolean upKeyCodePressed();
  abstract boolean downKeyCodePressed();
  
  int getTopY () {
    return (y - height/2);
  }
  
  int getBottomY () {
    return (y + height/2);
  }
  
  void moveUP() {
    y -= 5;
  }
  
  void moveDown() {
    y += 5;
  }
  
  void detectControl() {
    if (keyPressed == true) {
      if (upKeyCodePressed() && getTopY() > 0) {
        moveUP();
      }
     
      if (downKeyCodePressed() && getBottomY() < screenY) {
        moveDown();
      }
    }
  }
  
  void display() {
    rectMode(CENTER);
    rect(x, y, width, height);
    
    detectControl();
    
    if (detectCollision()) {
      invertBallDirectionY();
    }
  }
  
  boolean detectCollision() {
    return (ballX <= (x + width/2) 
            && ballX > (x - width/2)
            && ballY - (ballSize/2) > getTopY() 
            && ballY + (ballSize/2) < getBottomY() );
  }
}

class Player1 extends Player {
  Player1() {
    super();
    x = playerPadding;
  }
  
  boolean upKeyCodePressed() {
    return (key == 'q');
  }
  
  boolean downKeyCodePressed() {
    return (key == 'a');
  }
}

class Player2 extends Player {
  Player2() {
    super();
    x = screenX-playerPadding;
  }
  
  boolean upKeyCodePressed() {
    return (key == 'p');
  }
  
  boolean downKeyCodePressed() {
    return (key == 'l');
  }
}

void draw() {
  background(0, 100, 0);
  strokeWeight(1);
  
  //players
  player1.display();
  player2.display();
  
  //ball
  moveBallX();
  moveBallY();
  rectMode(CENTER);
  rect(ballX, ballY, ballSize, ballSize);
  
  //line
  strokeWeight(4);
  line(screenX/2,0,screenX/2,screenY);
  stroke(255);
}