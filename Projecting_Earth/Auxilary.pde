float distSq(PVector p1, PVector p2){
  return (p2.x-p1.x)*(p2.x-p1.x) + (p2.y-p1.y)*(p2.y-p1.y);
}

PVector fromTo(PVector p1, PVector p2){
  return PVector.sub(p2, p1);
}

boolean valid(int i, int j){
  return (0<=i && i<width) && (0<=j && j<height);
}

float modulof(float x, float y){
  x = x%y;
  return (x<0?x+y:x);
}

int modulo(int x, int y){
  x = x%y;
  return (x<0?x+y:x);
}

void tracker(){
  image(earth.texture, 0, 0, width/5, height/5);
  earth.testPoint(mouseX, mouseY);
  noFill(); stroke(255, 0, 0); strokeWeight(2);
  circle(mouseX, mouseY, 10);
}

void displayFPS(){
  textAlign(RIGHT, TOP);
  textSize(30);
  fill(255);
  text(nf(frameRate, 0, 2), width-1, 0);
}

float hours = 1./24;
float s = frameRate/TWO_PI;
