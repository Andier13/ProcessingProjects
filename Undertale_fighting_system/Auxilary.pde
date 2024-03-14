class rectangle{
  float x1, y1, x2, y2, w, h;
  rectangle(float cx, float cy, float wt, float ht){
      w=wt; h=ht;
      x1=cx-w/2;
      x2=x1+w;
      y1=cy-h/2;
      y2=y1+h;
  }
  
  void display(float cx, float cy){
      x1=cx-w/2;
      x2=x1+w;
      y1=cy-h/2;
      y2=y1+h;
      noFill();
      rect(x1-2, y1-2, w+3, h+3);
  }
}

class healthbar{
  float x, y, w, h;
  heart player;
  healthbar(float xt, float yt, float wt, float ht, heart playert){
      x=xt; y=yt; w=wt; h=ht; player=playert;
  }
  
  void display(float xt, float yt){
    x=xt; y=yt;
    strokeWeight(0); fill(255, 0, 0);
    rect(x, y, w, h);
    fill(255, 255, 0);
    rect(x, y, map(player.health, 0, player.maxHealth, 0, w), h);
    textAlign(LEFT); textSize(h); fill(255);
    text(player.health+"/"+player.maxHealth+" HP", x+w+h, y+h);
  }
}

class textButton{
  float x, y, w, h;
  String text;
  textButton(float ht, String message){
      h=ht; text=message; w=0.8*h*text.length();
  }
  
  boolean pressed() {return (mouseX>=x-w/2 && mouseX<=x+w/2 && mouseY>=y-h/2 && mouseY<=y+h/2);}
  
  void display(float xt, float yt){
      x=xt; y=yt;
      if (pressed())
          textSize(h+5);
      else
          textSize(h);
      fill(255);
      text(text, x, y);
  }
}

boolean assetsLoaded;
void soundAssets(){
  assetsLoaded = false;
  Blue_heart = loadImage("sprites/Blue heart.png");
  Papyrus = loadImage("sprites/Papyrus.png");
  if (!debug){
  BattleSong = new SoundFile(this, "Sounds/Bonetrousle.mp3");
  GameOverSong = new SoundFile(this, "Sounds/Determination.mp3");
  WinSong = new SoundFile(this, "Sounds/It's Showtime!.mp3");
  }
  TakeDamageEff = new SoundFile(this, "Sounds/Taking Damage.mp3");
  RestoreHealthEff = new SoundFile(this, "Sounds/Restoring Health.mp3");
  HeartBreakEff = new SoundFile(this, "Sounds/Heartbreaking.mp3");
  BattleEncounterEff = new SoundFile(this, "Sounds/Battle Encounter.mp3");
  PingEff = new SoundFile(this, "Sounds/Ping.mp3");
  FinishEff = new SoundFile(this, "Sounds/Finishing Puzzle.mp3");
  PapyrusEff = new SoundFile(this, "Sounds/Papyrus.mp3");
  boundary = new rectangle (width/2, height/2+100, 200, 150);
  battlefield = createGraphics(int(boundary.w), int(boundary.h));
  reset = new textButton(20, "Try again");
  mainmenu = new textButton(20, "Main menu");
  assetsLoaded = true;
}

void play(SoundFile s){
  try{
  s.amp(0.25);
  s.loop();
  }catch (NullPointerException e){}
}

void stop(SoundFile s){
  try{
  s.stop();
  }catch (NullPointerException e){}
}

float fps=100, fixedFps=60;
float dt()                       {if(millis()>1000)return fixedFps/frameRate; return 0;}
int pv1, pv2;
boolean frame(int n, int delay)  {int v=floor(frameCount/fps*fixedFps)+delay; boolean r = v%n==0 && v!=pv1; pv1=v; return r;}
boolean frame(int n)             {int v=floor(frameCount/fps*fixedFps); boolean r = v%n==0 && v!=pv2; pv2=v; return r;}

boolean fullscr=false;
void toggleFullscreen(){
  if (key=='f'){
    fullscr=!fullscr;
    if (fullscr)
        {surface.setSize(displayWidth, displayHeight); surface.setLocation(-3, -30);}
    else
        {surface.setSize(800, 600); surface.setLocation(displayWidth/2-width/2, displayHeight/2-height/2);}
  }
}
