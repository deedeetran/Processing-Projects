//ONLY WORKS WITH controlP5 library
//download controlP5 in same directory in "libraries" folder

//Visualizing Hate Crimes in NY counties

import controlP5.*;


//variables for the imported library for dropdowns
ControlP5 cp5;
controlP5.ScrollableList crimesDrop;
controlP5.ScrollableList countyDrop;

//variables to read events from dropdown menus
int crimeIndex;
int countiesIndex;
String crimeParam;
String countyParam;



Table crimes;

TableRow row;
int count = 0;

//variables to make points objects
int pointsIndex = 0;
Points [] pointArray = new Points[2252];

int x = 20;
int y = 0;

//variables for the array of counties
String [] countyArray;
int j = 0;


//variables for yearDivision

//x and y positions of top left corner of each year division
int xPos = 210;
int yPos = 0;
//width and height of each year division
int w = 180;
int h = 580;
//starting year for first year division
int year = 2010;


//appearance variables
PFont font;
PFont font2;


//variables to actually draw the ellipses
int yVal = 310;



YearDivision [] yearArray = new YearDivision [7];





void setup(){

  font = createFont("Roboto-Black", 10);
  font2 = createFont("Raleway-Black", 40);
  
  //Load in the csv data
  crimes = loadTable("hate copy 2.csv", "header");
  
  size (1200, 660);
  
  //create the dropdown objects
  cp5 = new ControlP5(this);
  
  
  
  
  //for loop counts number of unique counties in the csv
  for (int i = 1; i < crimes.getRowCount(); i++){
      if (!crimes.getString(i, 0).equals(crimes.getString(i-1, 0))){
        count += 1;
      }
      
    }
  
  //initialize an empty array using the count from above for loop
  countyArray = new String[count+2];
  
  //for loop isolates unique values in first column of table and puts them in the array
  //extra line handles error where "Albany" did not show in drop down list (strange error)
  j = 1;
  countyArray[0] = crimes.getString(0,0);
  for (int i = 1; i < crimes.getRowCount(); i++){
      if (!crimes.getString(i, 0).equals(crimes.getString(i-1, 0))){
        countyArray[j] = crimes.getString(i,0);
        j+= 1;
      }
    }
   countyArray[count+1] = "ALL";
   
   
   
  //stuff for hate crimes dropdown list
  
  //list is short enough that there was no need to parse it from the csv file-- I just typed it
  String [] hateList1 = {"Anti-Gender Identity", "Anti-Race", "Anti-Ethnicity", "Anti-Sexual Orientation", "Anti-Religion", "ALL"};
  //create dropdown menu for crimes and specify metrics
   crimesDrop = cp5.addScrollableList("Crimes")
    .setPosition (20, 160)
    .setSize(150, 200)
    .setBarHeight(30)
    .setItemHeight(30)
    .addItems(hateList1)
    .setOpen(false)
    .setColorBackground(color(113, 118, 124))
    .setColorForeground(color(255, 25, 33))
    
  ; 
  
  
  //stuff for counties dropdown list
  //list not short enough to type so taken from csv
  //create dropdown menu for counties and specify metrics
  countyDrop = cp5.addScrollableList("Counties")
    .setPosition (20, 110)
    .setSize(150, 200)
    .setBarHeight(30)
    .setItemHeight(30)
    .addItems(countyArray)
    .setOpen(false)
    .setColorBackground(color(113, 118, 124))
    .setColorForeground(color(255, 25, 33)) 
  ; 
  
  
  
  //styling my dropdown menus
  
  crimesDrop.getValueLabel()
    .setFont(font)
    .toUpperCase(false)
    
    ;
    
  crimesDrop.getCaptionLabel()
    .setFont(font)
    .toUpperCase(false)
    
    ;
    
  countyDrop.getValueLabel()
    .setFont(font)
    .toUpperCase(false)
    
    ;
    
  countyDrop.getCaptionLabel()
    .setFont(font)
    .toUpperCase(false)
    ;
    
    
    
  
  
  //CREATING OBJECTS FOR EACH POINT
  //iterate throught columns in CSV and list of hate crime titles
  //if they equal, start iterating through the rows
  //for each number (actual value) in the cells in the rows, create a Points object
  for (int i = 0; i < crimes.getColumnCount(); i++){
    for (int j = 0; j < hateList1.length; j++){
      if (crimes.getColumnTitle(i).equals(hateList1[j])){
        for (int g = 0; g < crimes.getRowCount(); g++){
          for (int objNum = 0; objNum < crimes.getInt(g, i); objNum ++){
            pointArray[pointsIndex] = new Points(crimes.getString(g, 0), crimes.getColumnTitle(i), crimes.getString(g,1));
            pointsIndex += 1;
          }
          
        }
        
      }
      
    }
    
  }
  
 
 //create an array of yeardivisions with parameters
 for (int i = 0; i < 7; i++){
    yearArray[i] = new YearDivision (xPos, yPos, 130, 622, str(year)); 
    xPos += 130;
    year += 1;
  }
  
  
  
  
  
}

//method that reads events from dropdowns
void controlEvent(ControlEvent event){
  //conditional checks to make sure the event comes from the dropdown
  if (event.isController()){
    
   
    //event.getController().getName() returns the name of the dropdown list being used
    if (event.getController().getName() == "Crimes"){
      //event.getValue returns float of index of list
      crimeIndex = (int) cp5.get(ScrollableList.class, "Crimes").getValue();
      //must use to String because --- cp5.get(ScrollableList.class, "Crimes").getItem(crimeIndex).get("name")--- returns Object
      crimeParam = cp5.get(ScrollableList.class, "Crimes").getItem(crimeIndex).get("name").toString();
    } 
    
    
    
    if ((event.getController().getName() == "Counties")){
      //.getValue() returns the index of the items in the dropdown list as a float
      countiesIndex = (int) cp5.get(ScrollableList.class, "Counties").getValue();
      //must use to String because --- cp5.get(ScrollableList.class, "Counties").getItem(countiesIndex).get("name")--- returns Object
      countyParam = cp5.get(ScrollableList.class, "Counties").getItem(countiesIndex).get("name").toString();
    }
  }
}


  






void draw(){
  fill(255);
  background(39, 40, 40);
  //background(234);

    //whole conditional describes what data should be shown, when
    if (crimeParam == null && countyParam == null){
      crimeParam = "ALL";
      countyParam = "ALL";
    } 
    else if (crimeParam.equals("ALL") && countyParam.equals ("ALL")){
      //call method to write key
      keyText("*Each bar \n represents \n 24 incidents");
      //draw the ellipses using yearDivision class
      for (int j = 0; j < yearArray.length; j++){
        int count = yearArray[j].display(pointArray, 12);
        text(yearArray[j].year + ":    " + str(count), 30, yVal);
        fill(255);
        displayInfoBox(crimeParam, countyParam);
        
        //displayInfoBox(yearArray[j].year, yVal, count, crimeParam, countyParam);
        yVal += 25;
      }
    } else{
      //draw the ellipses using yearDivision class
      for (int j = 0; j < yearArray.length; j++){
        int count = yearArray[j].displayRestricted(crimeParam, countyParam, 15);
        text(yearArray[j].year + ":    " + str(count), 30, yVal);
        keyText("*Each circle \n represents an \nindividual incident");
        displayInfoBox(crimeParam, countyParam);
        
        
        yVal += 25;
        
      }
      
    }
    
    yVal = 310;
    keyTextTitle();
  }
      

  
  
  //method that displays info in text on left hand side of the screen 
   void displayInfoBox( String crime, String county){
    
    if (crime.equals("ALL")){
      text("All hate crimes in", 30, 250);
      
    } else{
      text(crime , 30, 225);
      text("crimes in", 30, 250);
      
    }
    
    if (county.equals("ALL")){
      text("all counties", 30, 275);
      
    } else{
      text(county, 30, 270);
      
    }
    
       
  } 
    
    
    
    
    
  //method that creates a key on left hand side
  void keyText(String text){
    fill(255);
    text(text, 28, 500);
    
    
  }
  
  void keyTextTitle(){
    textSize(30);
    textAlign(CENTER);
    fill(255);
    text("Hate Crimes in NY Counties By Type", 660, 60);
    textAlign(LEFT);
    textSize(15);
    fill(255);
  }
  
  
  //keyPressed to switch between counties ---- makes it easier to compare between counties
  void keyPressed(){
      
        if (countiesIndex <= 0){
          countiesIndex = 58;
          
          
        } else if (countiesIndex >= 58){
          countiesIndex = 0;
          
        }
        
        if (keyCode == LEFT){
          countyParam = cp5.get(ScrollableList.class, "Counties").getItem(countiesIndex-=1).get("name").toString();
          
        } else if (keyCode == RIGHT){
           countyParam = cp5.get(ScrollableList.class, "Counties").getItem(countiesIndex).get("name").toString();
           countiesIndex += 1; 
      
    }
         
    
  }
    