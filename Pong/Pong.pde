Ball b;
Paddle p;
int count = 0;
int whichScreen = 0;
int last = 0;
int winnum = 3;

//variables to make starry background of the game
ArrayList<Stars> starz = new ArrayList<Stars>();
int randSize;
int randX;
int randY;
int randIndex= int(random(0, 100));
Stars star;
int slow;

void setup(){
  //set canvas size and make objects
  size(800, 600);
  p = new Paddle(5,41);
  b = new Ball(25, 48, 40, 5);
  slow = millis();
}


void draw(){
  background(24, 24, 25);
  
  //for loop that creates game background
  //makes stars of random size and position and stores them in arraylist
  for (int i = 0; i < 100; i ++){
    randSize = int(random(1,6));
    randX = int(random(width));
    randY = int(random(height));
    star = new Stars(randSize, randX, randY);
    starz.add(star);
  }
  
  //use the stars arraylist to display all the stars
  for (int i = 0; i < 100; i ++){
    starz.get(i).display();
  }
  
  //make the stars twinkle periodically
  if (millis() - slow >= 3000 && millis() - slow <= 3500){
    starz.get(randIndex).twinkle();
  } 
  
  if (millis() - slow >= 3500){
    randIndex = int(random(0, 100));
    slow = millis();
    
  }
  
  
  //display the appropiate screen
  if (whichScreen == 0){
    startScreen();
    
  } else if (whichScreen == 1){
    gamePlay();
    
  } else if (whichScreen == 2){
    winScreen();
    
  } else if (whichScreen == 3){
    loseScreen();
    
  }
  
  
  
  
  
  
}


  //booleans to test if objects are testing the sides of the screen
  boolean topWall(float value){
    if (value <= 45){
      return true;
      
    }
    return false;
  }
  
  boolean bottomWall(float value){
    if (value >= height-19){
      return true;
      
    }
    return false;
  }
  
  
  boolean rightWall(){
    if (b.x >= width){
      return true;
      
    }
    return false;
    
  }
  
  boolean leftWall(){
    if (b.x <= 0){
      count -= 1;
      return true;
    }
    return false;
  }
  
  boolean rightRect(){
    if (b.x <= p.x + 10 && b.y >= p.y && b.y <= (p.y+80)){
      count += 1;
      return true;
    }
    return false;
    
    
  }
  
  
  

void keyPressed(){
  //conditional to move the paddle
  if (keyCode == UP){
    if (!topWall(p.y))
     p.y -= 30;
     
   } else if(keyCode == DOWN){
     if (!bottomWall(p.y + 90))
     p.y+= 30;  
   }
   
   //press spacebar to restart the screen
   if (key == ' '){
     count = 0;
     whichScreen = 1;
     last = millis();
     b.x = 25;
     b.y = 48;
     b.xvel = 5;
   }
}
  

//method to create the timer
void timer(){
  int time = (millis()-last)/1000;
  noStroke();
  fill(24, 24, 25);
  rect(600, 0, 100, 20);
  fill(255);
  text("time: " + time, 660, 30);
  if (time == 20 && count != winnum){
    whichScreen = 3;
    
  } else if (count == winnum){
    last = millis();
    whichScreen = 2;
    
  }
}


//code for the different screens of the game

  

void gamePlay(){
  p.display();
  //conditional to make the ball object bounce
  if (rightWall() || rightRect() || leftWall()){
    b.xvel *= -1;
  } else if( topWall(b.y)||bottomWall(b.y)){
    b.yvel *= -1;
  }
  b.move();
  b.display();
  textSize(20);
  noStroke();
  fill(24, 24, 25);
  rect(50, 10, 100, 20);
  fill(255);
  text("score: " + count, 100, 30);
  timer(); 
}
  
  
void startScreen(){
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("Galaxy Pong", width/2, 100);
  textSize(30);
  text("Press the spacebar to begin",width/2, height/2);
}


void winScreen(){
  text("You WON!", width/2, height/2);
}


void loseScreen(){
  text("You LOST!", width/2, height/2);
}