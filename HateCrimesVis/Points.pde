
//every point has a position (x, y), color, size
class Points{
    //variables used to actually draw things
    int xPos;
    int yPos;
    color c;
    int size;
    
    //variables used to label points
    String county;
    String crime;
    String year;

    boolean hit = false;

    
    //empty constructor
    Points(){
      
      
    }
    
    //constructor with parameters
    Points(String county, String crime, String year){
      this.county = county;
      this.crime = crime;
      this.year = year;
      
    }
    
    //method that draws the actual points
     void display(int x, int y, color c, int size){
      xPos = x;
      yPos = y;
      this.c = c;
      this.size = size;
      if (hit){
        fill(255, 25, 33);
        println(hit);
        
        
      } else{

        fill(c);
      
      }
      noStroke();
      ellipse(xPos, yPos, size, size); 

      
    }
    
    
    //making sure the point array works
    String checker (){
      return county;
    }
    
   
    
    
    
    
}