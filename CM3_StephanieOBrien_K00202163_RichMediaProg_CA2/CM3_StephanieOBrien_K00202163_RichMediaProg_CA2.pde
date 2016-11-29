import processing.video.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;


Movie runningMovie;
Minim songBackground;
AudioPlayer song;
XML polarData;
XML [] children;
int [] radius;
int j;
int k;
PFont font;
PImage mute1;
PImage mute2;


void setup() 
{
  size (1920,1080);
  background(0);

  runningMovie = new Movie (this,"sunset.mp4");
  runningMovie.loop();
  
  songBackground = new Minim(this);
  song = songBackground.loadFile ("Hearbeat_2-Mike_Koenig-143666461.wav", 320);
  song.play();
  song.loop();
  
  mute2 = loadImage("mute2.png");
  mute1 = loadImage("mute1.png");
  
  polarData = loadXML("Stephanie_O+Brien_2016-11-27_16-52-04.xml");
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
  image(runningMovie, 0, 0);

  image(mute2, 1800, 970);

  heartBeat ();
  
  font = loadFont ("bromello-32.vlw");
  textFont(font, 52);
  smooth();
  fill(100, 197, 221);
  text("Stephanie O Brien", width/2-200, height/14);
  text("Heat Rate Bpm " + radius[k], width/2-150, height/8);
  
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
  if  (key == 'm' || key == 'M' )
  {
    if (song.isPlaying () )
    {
      song.pause ();
      mute2.resize(0, 1);

    }
    else
    {
      song.play();
    }
  }
}

void heartBeat () 
{
  fill (100, 197, 221, radius[j]);
  ellipse (width/2, height/2, radius[j]*5, radius[j]*5);
  noStroke();
  
  if (j <= children.length-2)
  {
    j++;
  }
  else
  {
    j=0;
  }
}