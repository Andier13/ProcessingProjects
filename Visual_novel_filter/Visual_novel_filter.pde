boolean done = false, settings = true;
PGraphics base;
slider size = new slider(200, 1, 50, 20, 1, "Scale");
final float half_sqrt2 = sqrt(2)/2;

void setup(){
  size(700, 700);
  selectInput("Please select a photo", "makebase");
}

void draw(){
  background(0);
  if (done){
    float scale = size.state;
    int cols = floor(width/scale),
        rows = floor(height/scale);
    //image(base, 0, 0);
    base.loadPixels();
    for (int i=0; i<rows; i++)
      for (int j=0; j<cols; j++){
        int x = floor(j*scale + scale/2),
            y = floor(i*scale + scale/2),
            index;
        float bright = 0;
        int hfscl = floor(scale/2);
        for (int ci=-hfscl; ci<hfscl; ci++)
          for (int cj=-hfscl; cj<hfscl; cj++)
            if (ci*ci+cj*cj<=scale*scale){
              index = x+cj+(y+ci)*base.width;
              bright += brightness(base.pixels[index]);
          }
        bright/=scale*scale*PI/4;
        bright*=0.9;
        float r = map(bright, 0, 255, 1, scale*half_sqrt2+2);
        fill(255); noStroke();
        circle(x, y, 2*r);
    }
    if (settings){
      fill(0);
      rect(0, 0, 300, 100);
      size.display(30, 50);
    }
  }
  //println(done);
}

void keyPressed(){
  if (key=='e')
    settings=!settings;
}

void mousePressed(){
  size.pressed();
}

void mouseReleased(){
  size.unpressed();
}

void makebase(File f){
  String[] ext = {".jpg", ".jpeg", ".png"};
  if (f != null)
    if(checkExtension(f, ext)){
      PImage img = loadImage(f.getAbsolutePath());
      base = createGraphics(width, height);
      base.beginDraw();
      base.image(img, 0, 0, base.width, base.height);
      base.endDraw();
      done = true;
    }
    else{
      selectInput("Please select a photo", "makebase");
    }
}

boolean checkExtension(File f, String[] ext){
  boolean g = false;
  for (int i=0; i<ext.length && !g; i++)
    if (f.getName().endsWith(ext[i]))
      g = true;
  return g;
}
