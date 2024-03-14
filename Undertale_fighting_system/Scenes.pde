boolean once = true, once2=true;
int scene=0, prevScene=0;
IntDict scenes;
void setupScenes(){
  scenes = new IntDict();
  scenes.set("Main menu", 0);
  scenes.set("Loading", 1);
  scenes.set("Game over", 2);
  scenes.set("Level01", 3);
  scenes.set("Level02", 4);
  scenes.set("Level03", 5);
  scenes.set("Win", 5);
}
void setScene(String txt){
    int temp = scene;
    switch (txt){
      case "Next": scene++; break;
      case "Previous": scene = prevScene; break;
      default: scene = scenes.get(txt);
    }
    prevScene = temp; 
    once = true; once2 = true;
}

//---------------------------------------------------------------------------------------------------------------------
textButton play, exit;
void mainmenu(){
  if (once){
      play(MainMenuSong);
      once = false;
  }
  fill(255); stroke(255); textSize(80); textAlign(CENTER, CENTER); text("SOMETALE", width/2, height/2-100);
  play.display(width/2, height/2+140);
  exit.display(width/2, height/2+180);
}

void mainmenuMenu(){
  if (play.pressed()) {setScene("Loading"); stop(MainMenuSong);}
  if (exit.pressed()) exit();
}

//---------------------------------------------------------------------------------------------------------------------
String dots = "";
void loading(){
  if (frame(60, 0))  dots = "...";
  if (frame(60, 15)) dots = "..";
  if (frame(60, 30)) dots = ".";
  if (frame(60, 45)) dots = "";
  fill(255); stroke(255); textSize(40); textAlign(CENTER, CENTER); text("Loading"+dots, width/2, height/2);
  if (assetsLoaded) setScene("Level01");
}

//---------------------------------------------------------------------------------------------------------------------
heart player;
rectangle boundary;
PGraphics battlefield;
healthbar health;
int baseScore=0, finalScore, startTime=0;
void game(){
      if (once){
          pellets.clear();
          bones.clear();
          player = new heart(battlefield.width/2, battlefield.height/2, "red");
          health = new healthbar(width/2-70, boundary.y2+20, 50, 20, player);
          //player.invs=millis();
          //player.invincible=true;
          //baseScore = 0;
          //startTime = millis();
          noCursor();
          thread("Attacks");
          //thread("Speech");
          once = false;
      }
      if (player.health>0){
          float scale=3;
          textFont(createFont("Arial", 15));
          textAlign(LEFT);
          //text(nf(frameRate, ceil(log(frameRate)/log(10)), 2) + " FPS", 0, 15);
          //int score = (baseScore+(millis()-startTime)/500);
          //text(score + " Score", width-100, 15);
          textFont(createFont("Bookman Old Style", 15));
          textLeading(15+5);
          text(SpokenText, width/2+Papyrus.width/scale/2+30, boundary.y1-Papyrus.height/scale-50+50);
          battlefield.beginDraw();
          battlefield.background(0);
          player.update();
          
          updatePellets();
          updateBones();
          
          player.display();
          image(Papyrus, width/2-Papyrus.width/scale/2, boundary.y1-Papyrus.height/scale-50, Papyrus.width/scale, Papyrus.height/scale);
          stroke(255); strokeWeight(3);
          boundary.display(width/2, height/2+100);
          textFont(createFont("Arial", 15));
          health.display(width/2-70, boundary.y2+20);
          battlefield.endDraw();
          image(battlefield, boundary.x1, boundary.y1);
      }else{
          if (once2){
              player.invincible = false;
              finalScore=baseScore+(millis()-startTime)/500;
              stop(BattleSong);
              TakeDamageEff.stop();
              HeartBreakEff.play();
              thread("die");
              once2 = false;
          }
          battlefield.beginDraw();
          battlefield.background(0);
          //player.update();
          player.display();
          battlefield.endDraw();
          image(battlefield, boundary.x1, boundary.y1);
      }
}

void die(){
  delay(floor(HeartBreakEff.duration()*1000)+500);
  setScene("Game over");
  cursor(ARROW);
}

//---------------------------------------------------------------------------------------------------------------------
textButton reset, mainmenu;
void gameover(){
      if (once){
          play(GameOverSong);
          once = false;
      }
      fill(255); stroke(255); textSize(80); textAlign(CENTER, CENTER); text("GAME\nOVER", width/2, height/2-100);
      reset.display(width/2, height/2+140);
      mainmenu.display(width/2, height/2+180);
      textSize(15); textAlign(LEFT); //text(finalScore + " Highscore", width-150, 15);
      textAlign(CENTER); fill(255, 100); text("you died lol", width/2, height/2+100);
}

void gameoverMenu(){
  if (reset.pressed() /*&& pellets.size()==0 && bones.size()==0*/)    setScene("Previous");
  if (mainmenu.pressed()) setScene("Main menu");
  
  if (reset.pressed() || mainmenu.pressed())
      stop(GameOverSong);
}

//---------------------------------------------------------------------------------------------------------------------

void wingame(){
  if (once){
      play(WinSong);
      once=false;
  }
  fill(255); stroke(255); textSize(80); textAlign(CENTER, CENTER); text("YOU\nWON", width/2, height/2-100);
  mainmenu.display(width/2, height/2+180);
  textSize(15); textAlign(LEFT); //text(finalScore + " Highscore", width-150, 15);
}

void wingameMenu(){
  if (mainmenu.pressed()) {setScene("Main menu"); stop(WinSong);}
}
