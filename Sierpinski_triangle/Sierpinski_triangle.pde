PVector[] points;
int index=0;

void setup(){
  size(800, 800);
  points = new PVector[3];
}

void draw(){
  background(0);
  if (index<3){
    stroke(255);
    strokeWeight(10);
    for (int i=0; i<index; i++)
      point(points[i].x, points[i].y);
  }
  else{
    stroke(255);
    strokeWeight(1);
    line(points[0], points[1]);
    line(points[1], points[2]);
    line(points[0], points[2]);
    Sierpinski(points[0], points[1], points[2]);
  }
}

void mousePressed(){
  if (index<3)
    points[index++] = new PVector(mouseX, mouseY);
  else
    index = 0;
}

void Sierpinski(PVector A, PVector B, PVector C){
  if (PVector.sub(A, B).mag()>=1){
  
  PVector M = new PVector((A.x+B.x)/2, (A.y+B.y)/2),
          N = new PVector((B.x+C.x)/2, (B.y+C.y)/2),
          P = new PVector((A.x+C.x)/2, (A.y+C.y)/2);
  
  line(M, N);
  line(N, P);
  line(M, P);
  
  Sierpinski(A,M,P);
  Sierpinski(B,M,N);
  Sierpinski(C,N,P);
  }
}

void line(PVector A, PVector B){
  line(A.x, A.y, B.x, B.y);
}
