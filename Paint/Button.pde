class button{
  Vector2D pos;
  float size;
  String text;
  
  button(Vector2D position, float sizet, String message){
      pos = position;
      size = sizet;
      text = message;
  }
  
  boolean pressed(Vector2D v){return (v.x>=pos.x && v.x<=pos.x+size && v.y>=pos.y && v.y<=pos.y+size);}
  void display(){
      square(pos.x, pos.y, size);
      textAlign(CENTER); textSize(10); fill(255);
      text(text, pos.x+size/2, pos.y+size+10);
  }
}

boolean insideCanvas(Vector2D v) {return (v.x>corner1.x && v.x<corner2.x && v.y>corner1.y && v.y<corner2.y);}
boolean insideSelect(Vector2D v) {return (v.x>sel1.x && v.x<sel2.x && v.y>sel1.y && v.y<sel2.y);}

class colorButton{
  Vector2D pos;
  float size;
  color state;
  
  colorButton(Vector2D position, float sizet, color col){
      pos = position;
      size = sizet;
      state = col;
  }
  
  void pressed(Vector2D v, colorWheel cw){if (v.x>=pos.x && v.x<=pos.x+size && v.y>=pos.y && v.y<=pos.y+size) {cw.setState(state); cbp=true;}}
  void display(){
      fill(state);
      square(pos.x, pos.y, size);
  }
}boolean cbp=false;
enum drawMode {
    PENCIL, SPRAY, PEN, USPRAY; //SELECT;
  }
enum selectMode {
  PREDRAW, DRAW, POSTDRAW;
}
