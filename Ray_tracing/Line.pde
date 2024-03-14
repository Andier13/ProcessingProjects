class line{
  float a, b, c;
  
  line(float a_, float b_, float c_){
    a = a_;
    b = b_;
    c = c_;
  }
}

PVector intersection(line l1, line l2){
  //if (intersects(l1, l2))
  //{
    float a = l1.b*l2.c-l2.b*l1.c,
          b = l1.c*l2.a-l2.c*l1.a,
          c = l1.a*l2.b-l2.a*l1.b;
      return new PVector(a/c, b/c);
  //}
  //return new PVector();
}

boolean intersects(line l1, line l2){
  return !(equals(l1.a, l2.a) && equals(l1.b, l2.b) && equals(l1.c, l2.c)) && !equals(l1.a*l2.b-l2.a*l1.b, 0);
}

boolean equals(float a, float b){
  float precision = 0.001;
  return b - precision <= a && a <= b + precision; 
}
