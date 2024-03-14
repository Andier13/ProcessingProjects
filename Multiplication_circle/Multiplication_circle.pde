float r;
Vector2D mouse;
slider Total = new slider(new Vector2D(50, 50), 100, 0, 500, 10, 1, "Points");
slider Factor = new slider(new Vector2D(50, 100), 100, 0, 100, 2, 0.01, "Factor");
checkbox TotalScroller = new checkbox(new Vector2D(50, 150), 20, false, "Auto scroll through all points");
checkbox FactorScroller = new checkbox(new Vector2D(50, 200), 20, false, "Auto scroll through all factors");

void setup(){
  //size(800, 600);
  fullScreen();
  r = height/3;
}

void mouseClicked(){
  TotalScroller.change(mouse);
  FactorScroller.change(mouse);
}

void mousePressed(){
  Total.pressed(mouse);
  Factor.pressed(mouse);
}

void mouseReleased(){
  Total.unpressed();
  Factor.unpressed();
}

void draw(){
  background(0);
  mouse = new Vector2D(mouseX, mouseY);
  Total.update(mouse);
  Total.display();
  Factor.update(mouse);
  Factor.display();
  TotalScroller.display();
  FactorScroller.display();
  
  translate(width/2, height/2);
  colorMode(HSB);
  stroke((millis()/100)%255, 255, 255); strokeWeight(3); noFill();
  circle(0, 0, 2*r);
  strokeWeight(1);
  for (float i=0; i<Total.state; i++)
      line2(polarVector2D(r, PI+map(i, 0, Total.state, 0, TWO_PI)),                         //starting position
      polarVector2D(r, PI+map((i*Factor.state)%Total.state, 0, Total.state, 0, TWO_PI)));   //final position
      
  if (TotalScroller.state)   Total.autoScroll();
  if (FactorScroller.state)  Factor.autoScroll();
}
