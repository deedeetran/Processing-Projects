class Ball{
  float x;
  float y;
  float size;
  float xvel = 3;
  float yvel = 1;
  int count = 0;
  color c;
  
  
  Ball(float x, float y, float size, float xvel){
    this.x = x;
    this.y = y;
    this.size = size;
    this.xvel = xvel;
  }
  
  void display(){
    ellipse(x, y, size, size);
  }
  
  //function that moves this object
  void move(){
      x += xvel;
      y += yvel;
      
    
  }
  
  
  
  
}