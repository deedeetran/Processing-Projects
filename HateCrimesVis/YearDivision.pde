

class YearDivision {
  
  //variables for sound
  int xPos;
  int yPos;
  int w;
  int h;
  Points [] myObjects;
  String year;
  Points [] pointsInYear;
  
  
  int yVal = 350;
  
  
  //empty constructor
  YearDivision(){
    
    
  }
  
  //constructor with parameters
  YearDivision(int xPos, int yPos, int w, int h, String year){
    this.xPos = xPos;
    this.yPos = yPos;
    this.w = w;
    this.h = h;
    this.year = year;
    
  }
  
  
  //method that displays the year divisions and the points without restrictions
  int display(Points[] l, int size){
    int countPoints = 0;
    myObjects = l;
    
    
    
    //variables for the boundaries 
    int x = xPos;
    int y = h-20;
    
    //for loop draws points
    for (int i = 0; i < myObjects.length; i++){
      
      //rectangle/mouse collison detection-- changes color if hover
      if (mouseX > xPos && mouseX < xPos + w-10 && mouseY > yPos+150 && mouseY < yPos+150 + h-170){
        myObjects[i].hit = true;
        
        
        } else{
        myObjects[i].hit = false;
      }
        
        
      if (myObjects[i].year.equals(this.year)){
        myObjects[i].display(x,y, color(255), size);
        countPoints += 1;
        x+= 5;
        
      }

      
      
      //make sure ellipses don't past boundaries of year divisions
      if (x >= (w+xPos)-10){
          x = xPos;
          y -= 20;
        }
        
        
       
        
    }
    
    //method that labels each year division with a year
    drawText(year, xPos + (w/2 -25), h+10);
    
    
    
    //returns the number of incidents in each year division
    return countPoints;
 
  }
  

  
 
 

  //method that displays the data with restrictions
  int displayRestricted(String crime, String county, int size){
    int countPoints = 0;
    int xparam = xPos + w;
    
    //randomly generate the x and y values of the year divisions within boundaries
    for (int i = 0; i < myObjects.length; i++){
      int x = (int) random(xPos + 55,xparam-30);
      int y = (int) random(120,h-80);
      
        //rectangle/mouse collison detection
      if (mouseX > xPos && mouseX < xPos + w-10 && mouseY > yPos+150 && mouseY < yPos+150 + h-170){
         myObjects[i].hit = true;
  
         } else{
         myObjects[i].hit = false;
        }
        
        
    
      //display ellipses based on what is filtered
      if (myObjects[i].crime.equals(crime) && myObjects[i].county.equals(county) && myObjects[i].year.equals(this.year)){
    
        myObjects[i].display(x,y, color(255), size); 
        countPoints += 1;

      } else if (crime.equals("ALL") && myObjects[i].county.equals(county) && myObjects[i].year.equals(this.year)){

        myObjects[i].display(x,y, color(255), size);
        countPoints += 1;

      } else if (county.equals("ALL") && myObjects[i].crime.equals(crime) && myObjects[i].year.equals(this.year)){
        myObjects[i].display(x,y, color(255), size);
        countPoints += 1;

      }
      
      //draws the labels for each year division
      drawText(year, xPos + (w/2)-10, h+10);
      
      
        
      
    } 
    
    //returns the number of incidents in each year division
    return countPoints;
     
    
  }
  
  
  //method that labels each year division with year
  void drawText(String year, float x, float y){
    
      text(year, x, y);
      
    }
    
    
 
  


 
  }
  