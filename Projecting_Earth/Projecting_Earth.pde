planet earth;

void setup(){
  size(1200, 800);
  earth = new planet(width/2, height/2, height/3, "Earth.jpg", 0, 0, 1, 0);//radians(23.43647)
}

void draw(){
  background(0);
  
  earth.show();
  
  //tracker();
  
  displayFPS();
}
