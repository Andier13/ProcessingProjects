class checkbox{
    boolean state;
    Vector2D pos;
    float size;
    String text;
    
    checkbox(Vector2D position, float sizet, boolean defaultState, String message){
        pos = position;
        size = sizet;
        state = defaultState;
        text = message;
    }
    
    boolean inside(Vector2D v)  {return (v.x>=pos.x && v.x<=pos.x+size && v.y>=pos.y && v.y<=pos.y+size);}
    void change(Vector2D v) {if (displaySettings) if (this.inside(v)) state = !state;}
    
    void display(){
        stroke(60); fill(60); strokeWeight(2);
        square(pos.x, pos.y, size);
        colorMode(RGB); stroke(70, 130, 180);
        if (state){
            line(pos.x,      pos.y, pos.x+size, pos.y+size);
            line(pos.x+size, pos.y, pos.x,      pos.y+size);
        }
        stroke(255); noFill();
        square(pos.x, pos.y, size);
        textSize(size); fill(255);
        text(text, pos.x+size*2, pos.y+size);
    }
}
