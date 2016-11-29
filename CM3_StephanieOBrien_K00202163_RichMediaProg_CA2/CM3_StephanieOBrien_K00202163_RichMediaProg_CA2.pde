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
  heartBeat ();
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
    }
    else
    {
      song.play();
    }
  }
}

void heartBeat () 
{
  ellipse (width/2, height/2, radius[j], radius[j]);
  fill (255);
  noStroke();
  
  if (j <= children.length-1)
  {
    j++;
  }
  else
  {
    j=0;
  }
}