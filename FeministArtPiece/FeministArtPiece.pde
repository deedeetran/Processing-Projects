
//Deanna Tran Midterm Project 10/23 (Art piece)

PImage [] image = new PImage [10];
PImage [] image2 = new PImage [10];
PImage guerilla;

int i = 1;
int timer = 0;
//declaring variable for my custom font
PFont myFont;
int value = 1;

int show = 1;
boolean truth = false;

String input = "";
int pause = 50;
float stopTime;


void setup(){
  //frameRate(4);
  size(800, 800);
  for (int i =1; i < 8; i++){
    image[i] = loadImage("pic" + i + ".png");   
  }
  
  for (int b = 1; b < 8; b++){
    image2[b] = loadImage("pic" + b + "b.png");
    
  }
  
  guerilla = loadImage("guerilla.png");

  
}

void draw(){
  
  background(255);
  
 if (value % 2 != 0){
  //this conditional causes a slideshow effect
  if (stopTime > frameCount) {
    if (truth){
      //nested loop to make background of words
      for (int z = 0; z < width; z += 250){
        for (int j = 0; j < height; j += 100){
        fill(0,0,0);
        drawText("Futura Std Bold Condensed Oblique.otf", "CONFORM", 60, z, j);
        }
      }
         image2[i].resize(200, 0);
         image(image2[i], 400, 400);
         stopTime= frameCount + pause;
         } else{
           
            image[i].resize(200, 0);
            imageMode(CENTER);
            //makes it blurry at 0,600
            //image[i].resize(0, 600);
            image (image[i], 400, 400);
       
         }   
      }else{
        stopTime= frameCount + pause;
        
        i += 1; 
        
        
        //keeps slideshow from going over index
        if (i > 7){
          i = 1;          
          
          
        } 
       println ("Press the spacebar");
       println("If you've had enough, type 'enough'");
        
      }
     
     
     
     
//close outer if      
 } else{
   background(247, 241, 59);
   for (int u = 0; u < width; u += 190){
        for (int k = 0; k < height; k += 250){
          //guerilla.resize(200, 0);
          image(guerilla, u, k);
          
        }
        
   }
   textAlign(CENTER);
   fill(247, 241, 59);
   drawText("Futura Condensed Extra Bold.otf", "WE DON'T NEED", 100, width/2, 300);
   drawText("Futura Condensed Extra Bold.otf", "YOUR", 100, width/2, 400);
   drawText("Futura Condensed Extra Bold.otf", "RULES", 100, width/2, 500);
   
   
   
 }
      

   

      


//close draw loop
}
   
 
  
  
//can't use for loop because it executes all at once in each frame

//custom function to create text using custom fonts
void drawText (String fname, String text, int size, int placex, int placey){
  
  myFont = createFont(fname, size);
  textFont(myFont);
  text(text, placex, placey);
  
  
}

//tried boolean keyPressed in draw-- too sensitive and made pics flicker, better seperate
void keyPressed (){
  if (key == ' '){
    show += 1;
      if (show % 2 == 0){
        truth = true;
        
      }else{
        truth = false;
      }
  }else{
    //if user types 'enough', change screen
      input += key;
      if (input.equals("enough")){
        value += 1;
        
      } else if (key == 'x'){
        input = "";
        
      }
      
  }
  }
  