final int screenX = 1000;
final int screenY = 600;
int ballX = screenX/2;
int ballY = screenY-200;
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
  textSize(25);
  
  player1 = new Player1();
  player2 = new Player2();
}

void moveBallX(){
  int limit = screenX - 10;
  if (movingLeft)
    ballX-=5;
  else
    ballX+=5;
  
  if(movingLeft && ballX < 10) {
    movingLeft = false;
    player2.goal();
  }
    
  if (!movingLeft && ballX > limit) {
    movingLeft = true;
    player1.goal();
  }
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

void draw() {
  background(0, 100, 0);
  strokeWeight(1);

  //players
  player1.display();
  player2.display();
  
  //text("0", screenX-27, 30);
  
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