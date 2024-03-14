void res_graph(float x, float y, float w, float h){
  
  stroke(255);
  strokeWeight(2);
  
  //lines
  line(x, y, x, y+h);
  line(x, y+h/2, x+w, y+h/2);
  
  //arrows
  float l = 20;
  float sqrt3 = sqrt(3);
  fill(255);
  triangle(x+w, y+h/2-l/3, x+w, y+h/2+l/3, x+w+l*sqrt3/2, y+h/2);
  triangle(x-l/3, y, x+l/3, y, x, y-l*sqrt3/2);
  
  //segments
  float unit = 75;
  for (int i=0; i<w/unit; i++)
    if (i>0){
      line(x+i*unit, y+h/2-5, x+i*unit, y+h/2+5);
      textAlign(CENTER, TOP);
      textSize(20);
      text(i, x+i*unit, y+h/2+10);
      }
      
  for (int i=0; i<=4; i++){
    line(x-5, y+h-i*h/4, x+5, y+h-i*h/4);
    textAlign(RIGHT, CENTER);
    textSize(20);
    text(nf(map(i, 0, 4, -1, 1), 0, 1), x-10, y+h-i*h/4);
    }
  
  //wave
  stroke(255, 0, 0);
  strokeWeight(2);
  noFill();
  
  push();
  translate(x, y+h/2);
  
  beginShape();
  
  for (int i=0; i<k; i++){
    curveVertex(fourier[i].x*unit, map(fourier[i].y, -1, 1, -h/2, h/2));
  }
  
  endShape();
  
  pop();
}
