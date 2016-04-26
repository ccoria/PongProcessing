
int leftPlayerY = 100;
int leftPlayerX = 100;
final int playerWidth = 10;
final int playerHeight = 70;

final int screenX = 1000;
final int screenY = 600;
int ballX = screenX;
int ballY = 500;
int ballSize = 10;

boolean isAttacking = true;


void setup() {
  frameRate(100);
  pixelDensity(2);
  size(1000, 600);
}

void moveBallX(){
  int limit = screenX - 10;
  if (isAttacking)
    ballX-=5;
  else
    ballX+=5;
  
  if(isAttacking && ballX < 10)
    isAttacking = false;
    
  if (!isAttacking && ballX > limit)
    isAttacking = true;
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

void detectCollision() {
  if (ballX <= (leftPlayerX + playerWidth/2)
      && ballX > (leftPlayerX - playerWidth/2)
      && ballY - (ballSize/2) < (leftPlayerY+ playerHeight/2)
      && ballY + (ballSize/2) > (leftPlayerY - playerHeight/2)) {
    isAttacking = false;
  }
}

void draw() {
  
  background(0, 100, 0);
  strokeWeight(1);
  
  //player
  rectMode(CENTER);
  rect(100, leftPlayerY, 10, 70);
  
  //ball
  moveBallX();
  moveBallY();
  detectCollision();
  rectMode(CENTER);
  rect(ballX, ballY, ballSize, ballSize);
  
  strokeWeight(4);
  line(screenX/2,0,screenX/2,screenY);
  stroke(255);
  
  if (keyPressed == true) {
     if (keyCode == UP && leftPlayerY > 0) {
       leftPlayerY-=5;
     }
     
     if (keyCode == DOWN && leftPlayerY < screenY) {
      leftPlayerY+=5;
    }
  }
}