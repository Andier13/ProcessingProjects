class light_source{
  int precision=1000;
  PVector pos;
  
  light_source(){
    
  }
  
  void update(){
    pos = new PVector(mouseX, mouseY);
  }
  
  void show(){
    fill(255); noStroke();
    circle(pos.x, pos.y, 5);
  }
  
  void cast(){
    k=0;
    for (int i=0; i<precision; i++){
      float angle = map(i, 0, precision, 0, TWO_PI);
      PVector dir = PVector.fromAngle(angle);
      
      float dmin = 0;
      PVector point = null;
      for (int j=0; j<wall.length; j++){
        float x1 = wall[j].p1.x,
              y1 = wall[j].p1.y,
              x2 = wall[j].p2.x,
              y2 = wall[j].p2.y,
              x3 = pos.x,
              y3 = pos.y,
              x4 = pos.x + dir.x,
              y4 = pos.y + dir.y;
              
        float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
        
        if (den != 0){
          float t = ( (x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4) ) / den;
          float u = ( (x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3) ) / den;
          
          if (0 < t && t < 1 && 0 < u){
            PVector p = new PVector(x1 + t * (x2 - x1), y1 + t * (y2 - y1));
            if (dmin == 0 || distsq(pos, p) < dmin){
              dmin = distsq(pos, p);
              point = p.copy();
            }
          }
        }
      }
      if (dmin != 0 && point != null){
        stroke(255, 0, 0);
        //line(pos.x, pos.y, point.x, point.y);
        points[k++] = point.copy();
      }
    }
  }
}

float distsq(PVector v1, PVector v2){
  return (v2.x-v1.x)*(v2.x-v1.x)+(v2.y-v1.y)*(v2.y-v1.y);
}

PVector[] points = new PVector[1000];
int k;

void shade(){
  fill(255, 255, 0, 100);
  noStroke();
  beginShape();
  
  for (int i=0; i<k; i++)
    vertex(points[i].x, points[i].y);
  
  endShape();
}
