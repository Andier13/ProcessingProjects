
particle[] particles;
box window;

void setup(){
  size(800, 600);
  frameRate(144);
  colorMode(HSB);
  particles = new particle[20];
  for (int i=0; i<particles.length; i++)
    particles[i] = new particle(random(width), random(height), color(int(random(0, 256)), 200, 240), 30, 100);
  window = new box(0, 0, width, height);
}

void draw(){
  background(0);
  
  for (int i=0; i<particles.length; i++)
    particles[i].applyForce(PVector.mult(new PVector(0, 500), particles[i].m));
  
  for (int i=0; i<particles.length; i++){
    particles[i].update();
    particles[i].edges(window);
  }
  for (int n=0; n<3; n++){
    for (int i=0; i<particles.length-1; i++)
      for (int j=i+1; j<particles.length; j++)
        particles[i].collide(particles[j]);
    
    for (int i=0; i<particles.length; i++)
        particles[i].applyCollisionOffset();
  }
      
  for (int i=0; i<particles.length; i++)
    particles[i].show();
    
  textSize(20); fill(255);
  text(int(frameRate-0.1)/*nf(frameRate, 0, 2)*/, 0, 20);
  
}
