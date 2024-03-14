
void setup(){
  size(900, 900);
  //frameRate(144);
}

void draw(){
  background(0);
  cantor(0, width, 0);
  noLoop();
}
int n=5;
void cantor(float st, float dr, float h){
  if ((dr-st)/n>1){
    
    stroke(255); strokeWeight(1);
    line(st, height/2-h, st+(dr-st)*(int(n/2))/n, height/2-h);
    line(st+(dr-st)*(int(n/2)+1)/n, height/2-h, dr, height/2-h);
    
    cantor(st, st+(dr-st)*(int(n/2))/n, h+10);
    cantor(st+(dr-st)*(int(n/2)+1)/n, dr, h+10);
  }
}
