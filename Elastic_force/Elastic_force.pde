
particle[] particles;
spring springs[];
box window;
final PVector g = new PVector(0, 500);

void setup(){
  size(1000, 900);
  frameRate(150);
  colorMode(HSB);
  
  particles = new particle[10];
  for (int i=0; i<particles.length; i++)
    particles[i] = new particle(random(width), random(height), color(int(random(0, 256)), 200, 240), 30, 0);
    
    
  //springs = new spring[(particles.length-1)*particles.length/2];
  //int k=0;
  //for (int i=0; i<particles.length; i++)
  //  for (int j=i+1; j<particles.length; j++)
  //    springs[k++] = new spring(particles[i], particles[j], 1000, 200);
      
  springs = new spring[particles.length-1];
  for (int i=0; i<springs.length; i++)
      springs[i] = new spring(particles[i], particles[i+1], 1000, 100);
      
  //springs = new spring[particles.length];
  //for (int i=0; i<springs.length-1; i++)
  //    springs[i] = new spring(particles[i], particles[i+1], 1000, 200);
  //springs[springs.length-1] = new spring(particles[particles.length-1], particles[0], 1000, 100);
      
  window = new box(0, 0, width, height);
}

void draw(){
  background(0);
  
  //for (int i=0; i<particles.length; i++)
  //  particles[i].applyForce(PVector.mult(g, particles[i].m));
  
  for (int i=0; i<springs.length; i++){
    springs[i].ni.applyForce(springs[i].getForce(-1));
    springs[i].nf.applyForce(springs[i].getForce(1));
  }
  
  for (int i=0; i<particles.length; i++){
    if (particles[i].pressed){
      particles[i].pos = new PVector(mouseX, mouseY);
      particles[i].vel = new PVector(0, 0);
    }
    else
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
  
  for (int i=0; i<springs.length; i++)
    springs[i].show();
  for (int i=0; i<particles.length; i++)
    particles[i].show();
  
  //conservationOfEnergy();
    
  textSize(20); fill(255);
  text(int(frameRate-0.1)/*nf(frameRate, 0, 2)*/, 0, 20);
  
}

void mousePressed(){
  if (!selected)
    for (int i=0; i<particles.length; i++)
      particles[i].pressed();
}

void mouseReleased(){
  if (selected)
    for (int i=0; i<particles.length; i++)
      particles[i].unpressed();
}
