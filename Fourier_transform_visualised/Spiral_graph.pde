void polar_coord_graph(float x, float y, float w, float h){
  
  //stroke(255);
  //strokeWeight(2);
  //rect(x, y, w, h);
  
  //cartesian plane
  float unit = 70;
  int tw = floor(w/unit);
  int th = floor(h/unit);
  
  strokeWeight(1);
  color c = color(0, 127, 255);
  int blend = 80;
  
  for (int i=0; i<=tw; i++){
    
    stroke(c);
    line(x+(w-tw*unit)/2+i*unit, y, x+(w-tw*unit)/2+i*unit, y+h);
    
    if (i<tw){
      stroke(c, blend);
      line(x+(w-tw*unit)/2+i*unit+unit/2, y, x+(w-tw*unit)/2+i*unit+unit/2, y+h);
    }
  }
  for (int i=0; i<=th; i++){
    
    stroke(c);
    line(x, y+(h-th*unit)/2+i*unit, x+w, y+(h-th*unit)/2+i*unit);
    
    if (i<th){
      stroke(c, blend);
      line(x, y+(h-th*unit)/2+i*unit+unit/2, x+w, y+(h-th*unit)/2+i*unit+unit/2);
    }
  }
  
  stroke(255);
  strokeWeight(2);
  
  line(x+w/2, y, x+w/2, y+h);
  line(x, y+h/2, x+w, y+h/2);
  
  //spirograph
  push();
  translate(x+w/2, y+h/2);
  
  float ceva = map((millis() - startTime)/1000., 0, 10,  0, TWO_PI/200);
  PVector s = new PVector();
  if (millis()<startTime)
    ceva=0;
  
  stroke(255, 255, 0);
  strokeWeight(2);
  noFill();
  
  beginShape();
  //curveVertex(unit, 0);
  for (int i=0; i<tlen; i++){
    float val = 0;
    for (int j=0; j<p.length; j++)
      val += p[j].val(200, i);
    val*=unit / p.length;
    PVector v = PVector.fromAngle(i*ceva).mult(val);
    s.add(v);
    
    curveVertex(v.x, v.y);
  }
  
  endShape();
  
  //center of mass
  s.mult(1./tlen);
  fill(255, 0, 0);
  noStroke();
  circle(s.x, s.y, 10);
  
  if (k<fourier.length && frameCount%10==0 && ceva>0 && ceva*32<=maxFourierRange)
    fourier[k++] = new PVector(ceva*32, -map(s.x, -unit, unit, -1, 1));
  
  pop();
}
