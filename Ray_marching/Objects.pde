class rectangle{
  PVector pos;
  float w, h;
  
  rectangle(float x, float y, float w_, float h_){
    pos = new PVector(x, y);
    w = w_;
    h = h_;
  }
  
  void show(){
    fill(255, 100);
    stroke(255, 150);
    strokeWeight(3);
    rect(pos.x - w/2, pos.y - h/2, w, h);
  }
}

class circle{
  PVector pos;
  float r;
  
  circle(float x, float y, float r_){
    pos = new PVector(x, y);
    r = r_;
  }
  
  void show(){
    fill(255, 100);
    stroke(255, 150);
    strokeWeight(3);
    circle(pos.x, pos.y, 2*r);
  }
}
