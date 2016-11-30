//Import the video library
import processing.video.*;

//Import Minim library for audio - everything within the library
import ddf.minim.*;

//This list is of Global object and Global variables
//Declare object 'runningMovie' of Movie
Movie runningMovie;
//Declare object 'songBackground' of Minim
Minim songBackground;
//Declare object 'song' of AudioPlayer
AudioPlayer song;
//Declare object
XML polarData;
//Declare an array
XML [] children;
//Declare an array
int [] radius;
//Declare variable 'i' of type int
int j;
//Declare variable 'k' of type int
int k;
//Declare variable 'font' of type PFont
PFont font;
//Declare variable 'fontHeart' of type PFont
PFont fontHeart;
//Declare variable 'muteImg' of type PImage
PImage muteImg;


void setup() 
{
  //set frames per seocnds
  frameRate(10);
  //set the window size
  size (1920,1080);
  //set the background color to black;
  background(0);

  //Load a movie file from data folder and loops
  runningMovie = new Movie (this,"sunset.mp4");
  runningMovie.loop();
  
  //Creating an instance of Minim named songBackground
  songBackground = new Minim(this);
  //Load a sound file from data folder and plays it back in loop, bufferSize
  song = songBackground.loadFile ("Hearbeat_2-Mike_Koenig-143666461.wav", 512);
  song.play();
  song.loop();
  
  //Assign 'mute2' a value which is loading an image from data folder
  muteImg = loadImage("mute2.png");
  
  //loadXML loads the xml from data within in folder, which I initally got from Polar.com
  polarData = loadXML("Stephanie_O+Brien_2016-11-27_16-52-04.xml");
  //Returns the children of the Trackpoint data and storage in the children - working down into the .xml file 
  children = polarData.getChild("Activities").getChild("Activity").getChild("Lap").getChild("Track").getChildren("Trackpoint");
  //create new radius array to storage list of data
  radius = new int[children.length];
  //looping through the children array to get further data from the 
  for (int i=0; i<children.length;i++)
  {
    radius [i] = (children[i].getChild("HeartRateBpm").getChild("Value").getIntContent());
    //println(v);
    //radius = Integer.parseInt(v.trim());
    println(radius[i]);
  }
}


void draw ()
{
  //function image to draw movie name, x position, y position
  image(runningMovie, 0, 0);
  //function image to draw image name, x position, y position
  image(muteImg, 1800, 970);

  //call the function named heartBeat
  heartBeat ();
  
  //call the function named heart
  hearts();

  //loading font from data folder 
  font = loadFont ("bromello-32.vlw");
  //The font set will be used in all subsequent calls and size
  textFont(font, 52);
  //draws all geometry with smooth (anti-aliased) edges
  smooth();
  fill(100, 197, 221);
  //function text displays character within " ", x position, y position 
  text("Stephanie O Brien", width/2-180, height/14);
  fontHeart = loadFont("Garamond-Bold-48.vlw");
  textFont(fontHeart, 36);
  text("Heart Rate Beat per minute: " + radius[k], width/2-250, height/8);
  text("over 5 minutes", width/2-100, height/3+600);
  text("starting at 63 bpm finishing at 138 bpm", width/2-295, height/3+645);
  //the k int inside the arrary to loop, from 0 to the length of the children array
  if (k <= children.length-2)
  {
    k++;
  }
  else
  {
    k=0;
  }
}

//call every time a new frame is available to read
void movieEvent (Movie runningMovie) 
{
  runningMovie.read();
}

void keyPressed ()
{
  //if M or m is pressed the song will loop to see if it is playing and pause or play it
  if  (key == 'm' || key == 'M' )
  {
    if (song.isPlaying () )
    {
      //Pauses the playback of a soundfile
      song.pause ();
      //change the muteImg load image from data folder - music logo off
      muteImg = loadImage("mute1.png");
    }
    else
    {
      //Starts playback from the current position
      song.play();
      //change the muteImg load image from data folder - music logo on
      muteImg = loadImage("mute2.png");
    }
  }
}

void mousePressed ()
{
  //if M or m is pressed the song will loop to see if it is playing and pause or play it
  if  (mousePressed == true)
  {
    if (song.isPlaying () )
    {
      //Pauses the playback of a soundfile
      song.pause ();
      //change the muteImg load image from data folder - music logo off
      muteImg = loadImage("mute1.png");
    }
    else
    {
      //Starts playback from the current position
      song.play();
      //change the muteImg load image from data folder - music logo on
      muteImg = loadImage("mute2.png");
    }
  }
}

void heartBeat () 
{
  noStroke();
  //changing the colour its alpha value with the radius array
  fill (100, 197, 221, radius[j]);
  //changing the size of the shape with the radius array
  ellipse (width/2, height/2, radius[j]*5, radius[j]*5);
  //the j int inside the array to loop, from 0 to the length of the children array
  if (j <= children.length-2)
  {
    j++;
  }
  else
  {
    j=0;
  }
}

void hearts ()
{
  //North - heart 
  //changing the colour its alpha value with the radius array
  fill (255, 170, 17, radius[j]);
  //beginShape and endShape functions allow creating more complex forms
  beginShape();
  //vertex coordinates for points, lines, triangles, quads, and polygons, used exclusively within the beginShape() and endShape() 
  vertex(width/2, 480); 
  //defines the position of two control points and one anchor point of a Bezier curve, adding a new segment to a line or shape
  bezierVertex(width/2, 450, width/2+90, 460, width/2, 550);
  //vertex coordinates for points, lines, triangles, quads, and polygons, used exclusively within the beginShape() and endShape()   
  vertex(width/2, 480); 
  //defines the position of two control points and one anchor point of a Bezier curve, adding a new segment to a line or shape
  bezierVertex(width/2, 450, width/2-90, 460, width/2, 550);
  endShape();
  
  //East - heart 
  //changing the colour its alpha value with the radius array
  fill (255, 170, 17, radius[j]+20);
  //beginShape and endShape functions allow creating more complex forms
  beginShape();
  //vertex coordinates for points, lines, triangles, quads, and polygons, used exclusively within the beginShape() and endShape()   
  vertex(1030, height/2+10); 
  //defines the position of two control points and one anchor point of a Bezier curve, adding a new segment to a line or shape
  bezierVertex(1060, height/2+10, 1050, height/2+90+10, 960, height/2+10);
  //vertex coordinates for points, lines, triangles, quads, and polygons, used exclusively within the beginShape() and endShape() 
  vertex(1030, height/2+10); 
  //defines the position of two control points and one anchor point of a Bezier curve, adding a new segment to a line or shape
  bezierVertex(1060, height/2+10, 1050, height/2-90+10, 960, height/2+10);
  endShape();
  
  //South - heart 
  //changing the colour its alpha value with the radius array
  fill (255, 170, 17, radius[j]+40);
  //beginShape and endShape functions allow creating more complex forms
  beginShape();
  //vertex coordinates for points, lines, triangles, quads, and polygons, used exclusively within the beginShape() and endShape()   
  vertex(width/2, 620); 
  //defines the position of two control points and one anchor point of a Bezier curve, adding a new segment to a line or shape
  bezierVertex(width/2, 650, width/2-90, 640, width/2, 550);
  //vertex coordinates for points, lines, triangles, quads, and polygons, used exclusively within the beginShape() and endShape()   
  vertex(width/2, 620); 
  //defines the position of two control points and one anchor point of a Bezier curve, adding a new segment to a line or shape
  bezierVertex(width/2, 650, width/2+90, 640, width/2, 550);
  endShape();
  
  //West - heart 
  //changing the colour its alpha value with the radius array
  fill (255, 170, 17, radius[j]+60);
  //beginShape and endShape functions allow creating more complex forms
  beginShape();
  //vertex coordinates for points, lines, triangles, quads, and polygons, used exclusively within the beginShape() and endShape() 
  vertex(890, height/2+10); 
  //defines the position of two control points and one anchor point of a Bezier curve, adding a new segment to a line or shape
  bezierVertex(860, height/2+10, 870, height/2+90+10, 960, height/2+10);
  //vertex coordinates for points, lines, triangles, quads, and polygons, used exclusively within the beginShape() and endShape() 
  vertex(890, height/2+10); 
  //defines the position of two control points and one anchor point of a Bezier curve, adding a new segment to a line or shape
  bezierVertex(860, height/2+10, 870, height/2-90+10, 960, height/2+10);
  endShape();  
  
  //Transformations such as translate(), rotate(), and scale() do not work within beginShape()
  //tried to change the hearts to the radius array, can't due to beginShape()
  //Probably could have imported as jpeg and scaled that to the radius array but wanted to draw the hearts within sketch
  //possible could have also used cos(), sin() for the heart but i couldn't understand them
}