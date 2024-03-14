ArrayList<pellet> pellets = new ArrayList<pellet>();
int pltdmg = 3; float friendProb=0.2;
void pelletAtt0(int mils){//falling pellets
        pellets.add(new pellet(new PVector(random(0, battlefield.width), -5), 10, new PVector(0, 2), random(1)<friendProb));
        wait(mils);
}

void pelletAtt1(int mils){//homing pellets
        pellets.add(new pellet(PVector.add(player.pos, PVector.random2D().mult(random(100, 200))), 10, random(1)<friendProb));
        pellets.get(pellets.size()-1).vel=PVector.sub(player.pos, pellets.get(pellets.size()-1).pos).normalize().mult(1);
        wait(mils);
}
int side=0;
void pelletAtt2(int mils){//bullet pellets
        float prob2=random(1); boolean prob1=side%2==0; float h=random(battlefield.height);
        pellets.add(new pellet(new PVector((prob1? -20 : battlefield.width+20), h), 10, prob2<friendProb));
        pellets.get(pellets.size()-1).vel=new PVector((prob1? 1 : -1)*(prob2<0.2?2:random(3, 5)), 0);
        side++;
        wait(mils);
}

void updatePellets(){
  for (int i=0; i<pellets.size(); i++){
      pellet p=pellets.get(i);
      p.update();
      p.display();
      if (!p.friend) p.damage(pltdmg);
      else p.heal(2);
      if (PVector.sub(p.pos, player.pos).mag()>300 || p.collidePlayer()) {pellets.remove(p); i--;}
  }
}


//---------------------------------------------------------------------------------------------------------------------
ArrayList<bone> bones = new ArrayList<bone>();
int bndmg = 3;
void boneAtt0(int mils){//random jumps
        bones.add(new bone(new PVector(battlefield.width+20, battlefield.height), floor(random(3, 8)), new PVector(-2, 0)));
        wait(mils);
}
void boneAtt1(int mils, int between){//wait jump
        bones.add(new bone(new PVector(battlefield.width+20, battlefield.height), 10, new PVector(-5, 0), true));
        wait(between);
        bones.add(new bone(new PVector(battlefield.width+20, battlefield.height), 1, new PVector(-5, 0)));
        wait(mils);
}
void boneAtt2(int mils){//hopping
        int speed=4;
        bones.add(new bone(new PVector(-20, battlefield.height), 1, new PVector(speed, 0)));
        bones.add(new bone(new PVector(battlefield.width+20, battlefield.height), 1, new PVector(-speed, 0)));
        bones.add(new bone(new PVector(-20, 0), -10, new PVector(speed, 0)));
        bones.add(new bone(new PVector(battlefield.width+20, 0), -10, new PVector(-speed, 0)));
        wait(mils);
}

void specialBlueAtt(int mils){
      boolean left = random(1)<0.5, up = random(1)<0.5;
      bones.add(new bone(new PVector((left?-20:battlefield.width+20), (up?0:battlefield.height)), (up?-1:1)*floor(random(3, 15)), new PVector((left?1:-1)*random(1, 5), 0), true));
      wait(mils);
}

void updateBones(){
    for (int i=0; i<bones.size(); i++){
        bone b=bones.get(i);
        b.update();
        b.display();
        b.damage(bndmg);
        if (b.pos.x<-50 || b.pos.x>battlefield.width+50 || (b.collidePlayer()  && (b.cyan?player.isMoving():true))) {bones.remove(b); i--;}
    }
}

//---------------------------------------------------------------------------------------------------------------------

void Attacks(){
  String words;
  wait(1000);
  if (prevScene==scenes.get("Loading")){
  words = "Hello, human!\nI am the great\nPapyrus!";
  paragraph(words, PapyrusEff); wait(1000);
  words = "I am here\nto capture you.";
  paragraph(words, PapyrusEff); wait(1500);
  words = "In doing so, I will\nfinally become a member\nof the Royal Guard.";
  paragraph(words, PapyrusEff); wait(1500);
  words = "After that I..\nI'll be...";
  paragraph(words, PapyrusEff); wait(2000);
  words = "Popular!\nPopular!!\nPOPULAR!!!";
  paragraph(words, PapyrusEff); wait(1500);
  words = "*Ahem*\nWhere were we?";
  paragraph(words, PapyrusEff); wait(1000);
  words = "Ah, yes, fighting,\nnow then...";
  paragraph(words, PapyrusEff); wait(1500);
  words = "Have at thee!";
  paragraph(words, PapyrusEff); wait(1000);
  SpokenText = "";
  }
  play(BattleSong);
  wait(1000);
  for (int i=0; i<30; i++){if (player.health<=0) return; pelletAtt0(400);}
  wait(1000);
  for (int i=0; i<30; i++){if (player.health<=0) return; pelletAtt2(300);}
  wait(1000);
  for (int i=0; i<20; i++){if (player.health<=0) return; pelletAtt1(400);}
  wait(3000);
  words = "You have done well\nso far, human.";
  paragraph(words, PapyrusEff); wait(1000);
  words = "But now be prepared\nfor my special...";
  paragraph(words, PapyrusEff); wait(1500);
  words = "BLUE ATTACK!";
  paragraph(words, PapyrusEff); wait(2000);
  words = "En guarde, human!";
  paragraph(words, PapyrusEff); wait(1000);
  SpokenText = "";
  for (int i=0; i<50; i++){if (player.health<=0) return; specialBlueAtt(100);}
  wait(3000);
  if(player.health>0) {player.setType("blue"); player.pos = new PVector(battlefield.width/2, battlefield.height/2); stop(BattleSong);}
  wait(1000);
  bones.add(new bone(new PVector(battlefield.width+20, battlefield.height), 1, new PVector(-4, 0)));
  wait(1000);
  words = "Now, YOU are blue!";
  paragraph(words, PapyrusEff); wait(2000);
  SpokenText = "";
  if(player.health>0) play(BattleSong);
  wait(1000);
  for (int i=0; i<10; i++){if (player.health<=0) return; boneAtt2(700);}
  wait(1000);
  for (int i=0; i<10; i++){if (player.health<=0) return; boneAtt1(600, 250);}
  wait(1000);
  for (int i=0; i<10; i++){if (player.health<=0) return; boneAtt0(1200);}
  wait(2000);
  stop(BattleSong);
  pellets.clear(); bones.clear();
  finalScore=baseScore+(millis()-startTime)/500;
  FinishEff.play();
  delay(int(FinishEff.duration()*1000)+500);
  cursor(ARROW);
  setScene("Win");
}

void wait(int miliseconds){
  if(player.health>0) delay(miliseconds);
}
