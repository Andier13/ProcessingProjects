
class particle{
  
  float m, r;
  PVector pos, vel, acc, ppos, colloff;
  color col;
  int nrcoll;
  
  particle(float x, float y, color c, float r_, float v){
    ppos = pos = new PVector(x, y);
    vel = PVector.random2D().mult(v);
    acc = new PVector(0, 0);
    r = r_;
    m = (r/20) * (r/20);
    col = c;
    colloff = new PVector(0, 0);
    nrcoll=0;
  }
  
  void applyForce(PVector force){
    acc.add(force.mult(1/m));
  }
  
  void update(){
    ppos = pos.copy();
    vel.add(PVector.mult(acc,dt()));
    pos.add(PVector.mult(vel,dt()));
    acc.mult(0);
    //vel.mult(0.99);
  }
  
  void edges(box b){
    if ((pos.x-r <= b.left) || (pos.x+r >= b.right))
      vel.x = -vel.x;
    if ((pos.y-r <= b.top) || (pos.y+r >= b.bottom))
      vel.y = -vel.y;
      
    if (pos.x-r <= b.left)
      pos.x = (b.left + r) + ((b.left + r) - pos.x);
    if (pos.x+r >= b.right)
      pos.x = (b.right - r) - (pos.x - (b.right - r));
    if(pos.y-r <= b.top)
      pos.y = (b.top + r) + ((b.top + r) - pos.y);
    if (pos.y+r >= b.bottom)
      pos.y = (b.bottom - r) - (pos.y - (b.bottom - r));
  }
  
  void collide(particle p){
    if ( (p.pos.x-pos.x)*(p.pos.x-pos.x) + (p.pos.y-pos.y)*(p.pos.y-pos.y) <= (p.r+r)*(p.r+r) ){
      nrcoll++;
      p.nrcoll++;
      
      PVector n = new PVector(p.pos.x-pos.x, p.pos.y-pos.y);
      PVector un = n.normalize();
      PVector ut = new PVector(-un.y, un.x);
      PVector v1 = vel, v2 = p.vel;
      float m1 = m, m2 = p.m;
      
      float v1n = PVector.dot(un, v1),
            v1t = PVector.dot(ut, v1),
            v2n = PVector.dot(un, v2),
            v2t = PVector.dot(ut, v2);
      float v1t_ = v1t, 
            v2t_ = v2t;
      float v1n_ = (v1n*(m1-m2) + 2*m2*v2n)/(m1+m2),
            v2n_ = (v2n*(m2-m1) + 2*m1*v1n)/(m1+m2);
      PVector v1_ = PVector.add(PVector.mult(un, v1n_), PVector.mult(ut, v1t_)),
              v2_ = PVector.add(PVector.mult(un, v2n_), PVector.mult(ut, v2t_));
      vel = v1_;
      p.vel = v2_;
      
      float c1 = pos.x - ppos.x,
            c1_ = ppos.x,
            c2 = p.pos.x - p.ppos.x,
            c2_ = p.ppos.x,
            c3 = c2 - c1,
            c3_ = c2_ - c1_,
            c4 = pos.y - ppos.y,
            c4_ = ppos.y,
            c5 = p.pos.y - p.ppos.y,
            c5_ = p.ppos.y,
            c6 = c5 - c4,
            c6_ = c5_ - c4_,
            a = c6*c6 + c3*c3,
            b = 2 * (c6*c6_ + c3*c3_),
            c = c6_*c6_ + c3_*c3_ - (r + p.r)*(r + p.r),
            delta = b*b - 4*a*c,
            tc = (-b-sqrt(delta))/(2*a);
      //println(c1, c1_, c2, c2_, c3, c3_, c4, c4_, c5, c5_, c6, c6_, a, b, c, tc);
      totalCollisions++;
      if (tc<0 || tc>1)
          badCollisions++;
      println(nf(float(badCollisions)/totalCollisions*100, 0, 2)+"%");
            
      PVector d1 = new PVector(pos.x - ppos.x, pos.y - ppos.y),
              d2 = new PVector(p.pos.x - p.ppos.x, p.pos.y - p.ppos.y);
      float d1n = PVector.dot(un, d1),
            d1t = PVector.dot(ut, d1),
            d2n = PVector.dot(un, d2),
            d2t = PVector.dot(ut, d2);
      float part1 = lerp(0, d1n, tc),
            part2 = d1n - part1,
            d1n_ = part1 - part2;
            part1 = lerp(0, d2n, tc);
            part2 = d2n - part1;
      float d2n_ = part1 - part2;
      float d1t_ = d1t,
            d2t_ = d2t;
      PVector d1_ = PVector.add(PVector.mult(un, d1n_), PVector.mult(ut, d1t_)),
              d2_ = PVector.add(PVector.mult(un, d2n_), PVector.mult(ut, d2t_));
              
      //pos = PVector.add(ppos, d1_);
      //p.pos = PVector.add(p.ppos, d2_);
      colloff.add(d1_);
      p.colloff.add(d2_);
    }
  }
  void applyCollisionOffset(){
    if (nrcoll>0){
      pos = PVector.add(ppos, colloff.mult(1./nrcoll));
      colloff = new PVector(0, 0);
      nrcoll = 0;
    }
  }
  
  void show(){
    fill(col);
    noStroke();
    circle(pos.x, pos.y, 2*r);
  }
  
}

int totalCollisions = 0, badCollisions = 0;
