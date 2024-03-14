
class spring{
  particle ni, nf;
  float k, l0;
  
  spring(particle ni_, particle nf_, float k_, float l0_){
    ni = ni_;
    nf = nf_;
    k = k_;
    l0 = l0_ + ni.r + nf.r;
  }
  
  PVector getForce(int dir){
    PVector v = PVector.sub(ni.pos, nf.pos).mult(dir).normalize();
    float f = (PVector.sub(ni.pos, nf.pos).mag() - l0) * k;
    return v.mult(f);
  }
  
  float getEnergy(){
    float x = PVector.sub(ni.pos, nf.pos).mag() - l0;
    return k * x * x * 0.5;
  }
  
  void show(){
    if (PVector.sub(ni.pos, nf.pos).mag() - l0 > 0)
      stroke(0, 255, 255);
    else
      stroke(255);
    strokeWeight(3);
    line(ni.pos.x, ni.pos.y, nf.pos.x, nf.pos.y);
  }
}
