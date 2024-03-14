import processing.sound.*;
import java.awt.*;
import java.awt.event.*;

SoundFile BattleSong, GameOverSong, MainMenuSong, WinSong;
SoundFile TakeDamageEff, RestoreHealthEff, HeartBreakEff, BattleEncounterEff, PingEff, FinishEff, PapyrusEff;
PImage Red_heart, Blue_heart, Papyrus;

Robot rob;
boolean debug=false;

void setup(){
  size(800, 600);
  surface.setTitle("MY UNDERTALE");
  frameRate(fps);
  background(0);
  Red_heart = loadImage("sprites/Red heart.png"); surface.setIcon(Red_heart);
  try{rob = new Robot();}catch(Exception e){print("not supported");}
  //Point p = MouseInfo.getPointerInfo().getLocation(); println(p.x, p.y); //rob.mouseMove(0, 0);
  
  setupScenes();
  play = new textButton(20, "PLAY");
  exit = new textButton(20, "Exit");
  if (!debug) MainMenuSong = new SoundFile(this, "Sounds/Start Menu.mp3");
  thread("soundAssets");
  printArray(PFont.list());
}

void keyPressed(){
  if (player!=null) player.move();
  toggleFullscreen();
}

void keyReleased(){
  if (player!=null) player.stop();
}

void mouseClicked(){
  switch (scene){
      case 0: mainmenuMenu(); break;
      case 1:  break;
      case 2: gameoverMenu(); break;
      case 3:  break;
      case 5: wingameMenu(); break;
  }
}
void draw(){
  background(0);
  switch (scene){
      case 0: mainmenu(); break;
      case 1: loading(); break;
      case 2: gameover(); break;
      case 3: game(); break;
      case 5: wingame(); break;
  }
}
