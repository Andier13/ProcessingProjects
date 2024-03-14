class vector
{
  float x, y;
  
  vector (float tempx, float tempy)
  {x=tempx; y=tempy;}
  
  void addv(vector v)
  {vector w = new vector(v.x+x, v.y+y);  
   x=w.x; y=w.y;
 }
  
  float magn()
  {return sqrt(x*x+y*y);}
  
  float angle()
  {if(x>=0)
      return atan(y/x);
   else
       return PI+atan(y/x);
   }
  
}
  vector polarVector(float r, float a)
  {
    vector v = new vector(r*cos(a), r*sin(a));
    return v;
  }
  
  vector multv(float scalar, vector v)
  {
    vector w = new vector(v.x*scalar, v.y*scalar);
    return w;
  }
  
  vector addv(vector u, vector v)
    {
       vector w = new vector(u.x+v.x, u.y+v.y);
       return w;
    }
    
  vector subv(vector u, vector v)
    {
       vector w = new vector(u.x-v.x, u.y-v.y);
       return w;
    }
    
  vector randomVector(float mag)
  {
    float angle=random(0, TWO_PI);
    vector v = new vector(mag*cos(angle), mag*sin(angle));
    return v;
  }

  vector versor(vector v)
  {
    return multv(1/v.magn(), v);
  }
  
    void eqqTriangle(vector pos, float l, float rot, color c)
  {
    fill(c);
    beginShape();
    vertex(pos.x, pos.y);
    vector v1 = addv(pos, polarVector(l, PI+PI/6-rot));
    vertex(v1.x, v1.y);
    vector v2 = addv(pos, polarVector(l, PI-PI/6-rot));
    vertex(v2.x, v2.y);
    endShape(CLOSE);
  }
  
  void arrow(vector pos, vector v, color c, int stroke)
  {
    float r=log(v.magn());
    vector vf = addv(pos, v);
    stroke(c);
    strokeWeight(stroke);
    line(pos.x, pos.y, vf.x, vf.y);
    if (v.magn()>1)
        eqqTriangle(vf, r, -v.angle(), c);
    else
        point(pos.x, pos.y);
  }
  
  float upLimit(float x, float limit)
  {
    if (x>limit)
        return limit;
    else 
        return x;
  }
