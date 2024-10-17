
import oscP5.*;
import codeanticode.syphon.*;
import processing.video.*;

SyphonServer syphonServer;
Movie movie;
PGraphics canvas;
OscP5 oscP5;
boolean isPlaying = false;

void setup()
{
  size(1080, 1920, P3D);
  movie = new Movie(this, "glass.mp4");
  movie.volume(1.0);
  
  oscP5 = new OscP5(this, 55555);
  
  syphonServer = new SyphonServer(this, "Movie Output");
  canvas = createGraphics(1080, 1920, P3D);
}

void draw()
{
  canvas.beginDraw();
  canvas.background(0);
  if (isPlaying) {
    canvas.image(movie, 0, 0, canvas.width, canvas.height);
  }
  canvas.endDraw();
  
  println(movie.time());
  
  if (movie.time() >= 21) {
    isPlaying = false;
  }
    
  syphonServer.sendImage(canvas);
}

void movieEvent(Movie m) {
  if (m.available())
  {
    m.read();
  }
}

void oscEvent(OscMessage theOscMessage)
{
  println(theOscMessage.addrPattern());
  movie.jump(0);
  movie.play();
  isPlaying = true;
}
