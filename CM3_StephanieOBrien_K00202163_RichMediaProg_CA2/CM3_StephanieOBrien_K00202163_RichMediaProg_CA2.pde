import processing.video.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;


Movie runningMovie;
Minim songBackground;
AudioPlayer song;
XML polarData;


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
}


void draw ()
{
  image(runningMovie, 0, 0);
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