String SpokenText = "";

void paragraph(String words, SoundFile chara){
  if (player.health<=0 || scene==scenes.get("Win")) return;
  chara.amp(1);
  chara.loop();
  for (int i=1; i<=words.length(); i++){
    if (player.health<=0 || scene==scenes.get("Win")) {chara.stop(); return;}
    SpokenText = words.substring(0, i);
    wait(50);
  }
  chara.stop();
}
