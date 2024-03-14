import processing.sound.*;

int rows, cols;
int now, prevnow, hour;
int[] ore = new int[6];
SoundFile notification;
int w, h, textSize;

void setup(){
  //fullScreen();
  size(800, 600);
  surface.setResizable(true);
  rows=orar.length; cols=orar[0].length;
  hour = durataOra + durataPauza;
  for (int i=1, inceputulOrei=inceputulOrelor; i<rows; inceputulOrei+=hour, i++){
      orar[i][0]=digitalTime(inceputulOrei)+" - "+digitalTime(inceputulOrei+durataOra);
      ore[i-1]=inceputulOrei;
  }
  notification = new SoundFile(this, "slow-spring-board-longer-tail.mp3");
  //printArray(PFont.list());
}
/*
void keyPressed(){
  switch (keyCode){
    case LEFT:  now-=1; break;
    case RIGHT: now+=1; break;
  }
}
*/

void draw(){
  now = time(hour(), minute());
  ring2();
  boolean pauza = false, acasa = false, found = false;
  int ci, cj;
  for (ci=0; ci<rows-1 && !found; ci++)
      if(ore[ci]<=now && now<ore[ci]+hour){
        pauza = !(now<ore[ci]+durataOra);
        found = true;
      }
  if (!found) {acasa=true; ci++;}
  cj = weekday();
  w = width/8;
  h = height/10;
  textSize = h/5;
  background(Background);
  textAlign(CENTER, CENTER); textFont(createFont("Yu Gothic UI Semibold", textSize*3));
  text("Orar", width/2, 75);
  for(int i=0; i<rows; i++)
      for(int j=0; j<cols; j++){
          int xoff=(width-cols*w)/2+j*w;
          int yoff=150+i*h;
          
          if (i==ci && j==cj && !pauza && cj!=0)
              fill(CurrentCell);
          else if (i==ci+1 && j==cj && cj!=0 && pauza)
              fill(NextCell);
          else
              fill(DefaultCell);
          if (now>=ore[0]-hour && now<ore[0] && i==1 && j==cj) fill(NextCell);
          if (i==0) fill(HeaderCell);
          stroke(0); strokeWeight(1);
          rect(xoff, yoff, w, h); //Cell
          
          textFont(createFont((i==0?"Verdana Bold":"Verdana"), textSize)); textLeading(textSize+textSize/3); fill(0);
          if (orar[i][j] != null)
              text(orar[i][j], xoff+w/2, yoff+h/2);
      }
  stroke(0); strokeWeight(3); noFill();
  rect((width-cols*w)/2, 150, cols*w, rows*h); //Border
  
  textSize(textSize); textAlign(RIGHT); textLeading(textSize+textSize/3);
  text("Data: "+nf(day(), 2)+"/"+nf(month(), 2)+"/"+year()+"\n"+digitalTime(now), width-40, 50);
  if (pauza)      text("Pauză", width-40, 50+2*(textSize+textSize/3));
  else if (acasa) text("Acasă", width-40, 50+2*(textSize+textSize/3));
  else            text("În oră", width-40, 50+2*(textSize+textSize/3));
  prevnow = now;
}
