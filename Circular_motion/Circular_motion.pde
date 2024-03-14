//import peasy.*;

//PeasyCam cam;

particle[] p;

void setup(){
  size(900, 900);
  //cam = new PeasyCam(this, 300);
  frameRate(150);
  p = new particle[200];
  for (int i=0; i<p.length; i++)
    //p[i] = new particle(random(50, 200), random(TWO_PI), (random(1)<0.5?1:-1)*random(HALF_PI, PI));
    p[i] = new particle(map(i, 0, p.length, 50, 400), 0, map(i, 0, p.length, 0, PI));
}

void draw(){
  //background(255, 10);
  fill(255, 10);
  noStroke();
  rect(0, 0, width, height);
  
  for (int i=0; i<p.length; i++){
    p[i].update();
    p[i].show();
  }
}
