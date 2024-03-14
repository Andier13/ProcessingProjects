float maxA = 3, t;
source[] sound;
int k=1;

void setup(){
  size(600, 600);
  sound = new source[20];
  //change here
  sound[0] = new source(width/2, height/2, 1, 1, 50);
}

void draw(){
  println(frameRate);
  loadPixels();
  t = time();
  float size, t_;
  int x, y, i;
  for (x=0; x<width; x++)
    for (y=0; y<height; y++){
      
      size = 0;
      //maxA = 0;
      for (i=0; i<k; i++)
        if (sound[i]!=null){
          size += sound[i].getSize(new PVector(x, y));
          //maxA += s.A;
        }
      //change here
      size=abs(size);
      t_ = map(size, -maxA, maxA, 0, 1);
      pixels[x+y*width] = lerpColor(color(0), color(255), t_);
    }
  updatePixels();
}

void mousePressed(){
  switch(mouseButton){
    case LEFT:  
      if (k<sound.length)
        sound[k++] = new source(mouseX, mouseY, 1, 1, 20); //change here
    break;
    case RIGHT: 
      if (k>0)
        sound[--k] = null; 
    break;
  }
}

float time(){
  return millis()/1000.;
}
