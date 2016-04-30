class Score {
    int value;
    int x;
    int y;
    
    void display(){
      String prefix = "";
      
      if (value < 10)
        prefix = "0";
        
      text(prefix+value, this.x, this.y);
    }
    
    void increase() {
      value++;
    }
    
    Score (int x, int y) {
      this.value = 0;
      this.x = x;
      this.y = y;
      
      display();
    }
}

abstract class Player {
  int x;
  int y;
  int width;
  int height;
  Score score;
  
  Player(){
    width=10;
    height=70;
    y=screenY/2;
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
  
  void goal() {
    this.score.increase();
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
    
    score.display();
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
    this.score = new Score(10,30);
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
    this.score = new Score(screenX-40, 30);
  }

  boolean upKeyCodePressed() {
    return (key == 'p');
  }

  boolean downKeyCodePressed() {
    return (key == 'l');
  }
}