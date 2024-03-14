void cos_wave(float x, float y, float w, float h){
  
  tlen = w;
  
  stroke(255);
  strokeWeight(2);
  
  //lines
  line(x, y, x, y+h);
  line(x, y+h, x+w, y+h);
  
  //arrows
  float l = 20;
  float sqrt3 = sqrt(3);
  fill(255);
  triangle(x+w, y+h-l/3, x+w, y+h+l/3, x+w+l*sqrt3/2, y+h);
  triangle(x-l/3, y, x+l/3, y, x, y-l*sqrt3/2);
  
  //segments
  line(x-5, y+h/2, x+5, y+h/2);
  
  float unit = 200;
  int parts = 4;
  for (int i=0; i<w/(unit/parts); i++){
    if (i%parts==0){
      line(x+i*unit/parts, y+h-10, x+i*unit/parts, y+h+10);
      textAlign(CENTER, TOP);
      textSize(20);
      text(i/4, x+i*unit/parts, y+h+15);
    }else{
      line(x+i*unit/parts, y+h-5, x+i*unit/parts, y+h+5);
    }
  }
  
  //wave
  stroke(255, 255, 0);
  strokeWeight(2);
  noFill();
  

  beginShape();
  for (int i=0; i<w; i+=2){
    float val = 0;
    for (int j=0; j<p.length; j++)
      val += p[j].val(unit, i);
    val*=h/2 / p.length;
    curveVertex(x+i, y+h-val);
  }
  endShape();
  
}
