//Import the video library
import processing.video.*;

//Import Minim library for audio - everything within the library
import ddf.minim.*;

//Declare object
Movie runningMovie;
//Declare object
Minim songBackground;
//Declare object
AudioPlayer song;
//Declare 
XML polarData;
//Declare an array globally (we will create and initialise the array later)
XML [] children;
//Declare an array globally (we will create and initialise the array later)
int [] radius;
//Declare variable 'i' of type int
int j;
//Declare variable 'k' of type int
int k;
//Declare variable 'font' of type PFont
PFont font;
//Declare variable 'mute1' of type PImage
PImage mute1;
//Declare variable 'mute2' of type PImage
PImage mute2;


void setup() 
{
  //set the window size
  size (1920,1080);
  //set the background color to black;
  background(0);

  //Load a movie file from data folder and loops
  runningMovie = new Movie (this,"sunset.mp4");
  runningMovie.loop();
  
  songBackground = new Minim(this);
  //Load a sound file from data folder and plays it back in loop 
  song = songBackground.loadFile ("Hearbeat_2-Mike_Koenig-143666461.wav", 320);
  song.play();
  song.loop();
  
  //Assign 'mute2' a value which is loading an image from data folder
  mute2 = loadImage("mute2.png");
  //Assign 'mute1' a value which is loading an image from data folder
  mute1 = loadImage("mute1.png");
  
  //loadXML loads the xml from data within in folder, which I initally got from Polar.com
  polarData = loadXML("Stephanie_O+Brien_2016-11-27_16-52-04.xml");
  //Get the children of the Trackpoint - working down into the .xml file 
  children = polarData.getChild("Activities").getChild("Activity").getChild("Lap").getChild("Track").getChildren("Trackpoint");
  
  radius = new int[children.length];
  
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
  image(mute2, 1800, 970);

  heartBeat ();
  
  //loading font from data folder 
  font = loadFont ("bromello-32.vlw");
  //The font set will be used in all subsequent calls and size
  textFont(font, 52);
  smooth();
  fill(100, 197, 221);
  //function text displays character within " ", x position, y position 
  text("Stephanie O Brien", width/2-200, height/14);
  text("Heat Rate Bpm " + radius[k], width/2-150, height/8);
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
      song.pause ();
    }
    else
    {
      song.play();
    }
  }
}

void heartBeat () 
{
  //changing the colour its alpha value with the radius array
  fill (100, 197, 221, radius[j]);
  //changing the size of the shape with the radius array
  ellipse (width/2, height/2, radius[j]*5, radius[j]*5);
  noStroke();
  //the j int inside the arrary to loop, from 0 to the length of the children array
  if (j <= children.length-2)
  {
    j++;
  }
  else
  {
    j=0;
  }
}
