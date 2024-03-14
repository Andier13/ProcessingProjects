class Circle
{
  float r, dens, m;
  Vector2D pos, vel, acc, R;
  
  Circle(){}
  Circle(float rt, Vector2D post, Vector2D velt, Vector2D acct)  {r=rt; dens=1; m=PI*r*r*dens; pos=post; vel=velt; acc=acct; R=O;}
  
  void applyForces()          {acc=dot(R, 1./m);}
  void updatePos()            {vel.add(dot(acc, dt)); pos.add(dot(vel, dt));}
  void bounceEdges(float miu){
      if (pos.y+r>=height)    {vel.y=-(1-miu)*vel.y; pos.y=height-r;}
      if (pos.y-r<=0)         {vel.y=-(1-miu)*vel.y; pos.y=r;}
      if (pos.x+r>=width)     {vel.x=-(1-miu)*vel.x; pos.x=width-r;}
      if (pos.x-r<=0)         {vel.x=-(1-miu)*vel.x; pos.x=r;}
  }
  void calculateForces(){
      Vector2D G=O, N=O, Fr=O, Fd=O; R=O; 
      if (applyGravity)                      {G = dot(m, g);                                                            }
      if (applyGravity) if (pos.y+r>=height) {N = dot(-1, G);                                                           }
      if (applyFriction)                     {Fr = dot(-miu * N.mag(), versor(vel));                                    }
      if (applyAirResistance)                {Fd = dot(-0.5 * rho_air * Cd * (r * PI) * pow(vel.mag(), 2), versor(vel));}
      R=add(N, G); R.add(Fr); R.add(Fd);
  }
  void update(){
          this.calculateForces();
          this.applyForces();   
          this.bounceEdges(miu);
          if (applyColisions)
              for (j=0; j<n; j++)
                  if (i!=j) if (distance(objects[i], objects[j])<=0)
                      bounce(objects[i], objects[j], 0.0);
          this.updatePos(); 
  }
  void showVel(float scale)   {arrow(pos, dot(vel, scale), color(255, 220, 0), 5);}
  void showAcc(float scale)   {arrow(pos, dot(acc, scale), color(255, 0, 0), 5);}
  void show()                 {noFill(); stroke(255); strokeWeight(2); ellipse(pos.x, pos.y, r*2, r*2);
                              if (showAcceleration) objects[i].showAcc(20);
                              if (showVelocity)     objects[i].showVel(5);}
}

float distance(Circle C1, Circle C2)    {return sqrt((C2.pos.x-C1.pos.x)*(C2.pos.x-C1.pos.x)+(C2.pos.y-C1.pos.y)*(C2.pos.y-C1.pos.y))-(C1.r+C2.r);}
void bounce(Circle C1, Circle C2, float miu){
      float m1=C1.m, m2=C2.m, pushDist=-distance(C1, C2)/2;
      Vector2D v1=C1.vel, v2=C2.vel, vp, versorPush=versor(sub(C1.pos, C2.pos));
      vp=dot(1/(m1+m2), add(dot(m1, v1), dot(m2, v2)));
      C1.vel=sub(dot(2*(1-miu), vp), v1);
      C1.pos.add(dot(pushDist, versorPush));
      C2.vel=sub(dot(2*(1-miu), vp), v2);
      C2.pos.add(dot(-pushDist, versorPush));
}
