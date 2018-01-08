class Stars{
  int size;
  int x;
  int y;
  
  
  Stars(int size, int x, int y){
    this.size = size;
    this.x = x;
    this.y = y;
    
    
    
  }
  
  
  void display(){
    fill(255);
    ellipse(x, y, size, size);

  }
  
  //this function draws a cross on the ellipses to make a twinkling effect
  void twinkle(){
    stroke(255);
    line(x, y, x, y+8);
    line(x, y, x, y-8);
    line(x, y, x+8, y);
    line(x, y, x-8, y); 
  }
  
  
  
  
  
}