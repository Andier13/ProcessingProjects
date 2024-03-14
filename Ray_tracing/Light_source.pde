class light_source{
  int precision=100;
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
    for (int i=0; i<precision; i++){
      float angle = map(i, 0, precision-1, 0, TWO_PI);
      float cosa = cos(angle), sina = sin(angle);
      line ray = new line(sina, -cosa, pos.y*cosa-pos.x*sina);
      
      boundary[] intersectedWalls = new boundary[wall.length];
      int k = intersected_lines(intersectedWalls, ray, pos, angle);
      
      line wall = getClosestWallLine(pos, intersectedWalls, k); //not closest wall, closest distance to a wall ON that path
      PVector p = intersection(ray, wall);
      line(pos.x, pos.y, p.x, p.y);
    }
  }
}

line getClosestWallLine(PVector p, boundary[] v, int k){
  float dmin = pow(10, 10);
  line wallLine = new line(0, 0, 0);
  for (int i=0; i<k; i++){
    float x1 = v[i].p1.x,
          y1 = v[i].p1.y,
          x2 = v[i].p2.x,
          y2 = v[i].p2.y;
    line l = new line(y2-y1, -(x2-x1), y1*x2-y2*x1);
    float d = dist(p, l);
    if (d<dmin){
      dmin = d;
      wallLine = l;
    }
  }
  return wallLine;
}

float dist(PVector p, line l){
  return abs(l.a*p.x+l.b*p.y+l.c)/sqrt(l.a*l.a+l.b*l.b);
}

int intersected_lines(boundary[] v, line l1, PVector p, float angle){
  int k=0;
  for (int i=0; i<wall.length; i++){
    float x1 = wall[i].p1.x,
          y1 = wall[i].p1.y,
          x2 = wall[i].p2.x,
          y2 = wall[i].p2.y;
    line l2 = new line(y2-y1, -(x2-x1), y1*x2-y2*x1);
    if (intersects(l1, l2)){
      PVector c = intersection(l1, l2);
      if ( ( (x1 <= c.x && c.x <= x2) || (x1 >= c.x && c.x >= x2) ) && ( (y1 <= c.y && c.y <= y2) || (y1 >= c.y && c.y >= y2) ) )
        if (equals(atan2(p.y-c.y, p.x-c.x), angle))
          v[k++] = wall[i];
    }
  }
  return k;
}
