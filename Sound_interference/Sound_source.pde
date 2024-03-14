class source{
  float A, T, l;
  PVector pos;
  
  source(float x, float y, float A_, float T_, float l_){
    pos = new PVector(x, y);
    A = A_;
    T = T_;
    l = l_;
  }
  
  float getSize(PVector point){
    //float d = PVector.sub(new PVector(point.x, point.y), pos).mag();
    float d = fsqrt((pos.x-point.x)*(pos.x-point.x) + (pos.y-point.y) *(pos.y-point.y));
    return A*sin(TWO_PI*(t/T-d/l));
  }
}
