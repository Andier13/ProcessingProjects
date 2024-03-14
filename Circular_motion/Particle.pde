class particle{
  float a, avel, r;
  PVector pos, ppos;
  float hue = 0;
  
  particle(float r_, float a_, float avel_){
    r = r_;
    a = a_;
    avel = avel_;
    pos = new PVector(width/2+r*cos(a), height/2+r*sin(a));
    ppos = pos.copy();
  }
  
  void update(){
    a+=avel*dt();
    ppos = pos.copy();
    pos = new PVector(width/2+r*cos(a), height/2+r*sin(a));
    hue+=255/10*dt();
  }
  
  void show(){
    colorMode(HSB);
    stroke(hue%256, 200, 200);
    strokeWeight(10);
    line(ppos.x, ppos.y, pos.x, pos.y);
    colorMode(RGB);
  }
}

float dt(){
  return 1/frameRate;
}
