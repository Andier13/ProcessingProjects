float scale=1; static float sqrt2=sqrt(2); 

void setup(){
  size(600, 600);
  frameRate(60);
  surface.setResizable(true);
  surface.setTitle("Pretty primes");
}

void mousePressed(){redraw();}

void draw(){
  background(0);
  translate(width/2, height/2);
  PVector p; float lmax=(width>height?width:height)/2.*sqrt2*scale;
  stroke(75, 255, 200); strokeWeight(constrain(10/log(scale), 1, 10));
  for (int i=0; i<lmax; i++)
      if (prime(i)){
          p = PVector.fromAngle(i).mult(i).mult(1/scale);
          if (p.x>=-width/2 && p.x<=width/2 && p.y>=-height/2 && p.y<=height/2)
              point(p.x, p.y);
      }
  scale+=0.02*scale;
  if (frameRate<5 && millis()>2000)noLoop();
}

boolean prime(int n){
  if (n<=3) return n>1;
  if (n%2==0 || n%3==0) return false;
  for (int i=5; i*i<=n; i+=6)
      if (n%i==0 || n%(i+2)==0)
          return false;
  return true;
}
