class box{
  PVector pos;
  float w, h, d;
  color col;
  
  box(float x, float y, float z, float w_, float h_, float d_){
    pos = new PVector(x, y, z);
    w = w_;
    h = h_;
    d = d_;
    colorMode(HSB);
    col = color(int(random(0, 256)), 200, 240);
    colorMode(RGB);
  }
}

class sphere{
  PVector pos;
  float r;
  color col;
  
  sphere(float x, float y, float z, float r_){
    pos = new PVector(x, y, z);
    r = r_;
    colorMode(HSB);
    col = color(int(random(0, 256)), 200, 240);
    colorMode(RGB);
  }
}

class coldist{
  color col;
  float dist;
  
  coldist(color col_, float dist_){
    col = col_;
    dist = dist_;
  }
}

class colvec{
  color col;
  PVector vec;
  
  colvec(color col_, PVector vec_){
    col = col_;
    vec = vec_;
  }
}
