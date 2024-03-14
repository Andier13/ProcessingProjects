class slider{
    float state, maxState, minState, step;
    Vector2D pos;
    float size;
    String text;
    boolean selected;
    
    slider(Vector2D position, float sizet, float minStatet, float maxStatet, float defaultState, float stept, String message){
        pos = position;
        size = sizet;
        minState = minStatet;
        maxState = maxStatet;
        step = stept;
        state = defaultState;
        text = message;
        selected = false;
    }
    
    boolean inside(Vector2D v)  {return (sub(new Vector2D(map(state, minState, maxState, pos.x, pos.x+size), pos.y), v).mag()<10);}
    void update(Vector2D v){
        if (selected){
            if (v.x>=pos.x+size)
              {state=maxState; return;}
            if (v.x<=pos.x)
              {state=minState; return;}
            state=map(v.x, pos.x, pos.x+size, minState, maxState);
            state=state-state%step;
        }
    } 
    void pressed(Vector2D v)  {if (displaySettings) if (this.inside(v)) selected=true;}
    void unpressed()          {if (selected) selected=false;}
    
    void display(){
        stroke(220); strokeWeight(5);
        line(pos.x, pos.y, pos.x+size, pos.y);
        colorMode(RGB); fill(70, 130, 180); stroke(176, 196, 222); strokeWeight(2);
        circle(map(state, minState, maxState, pos.x, pos.x+size), pos.y, 20);
        textSize(20); fill(255);
        text(nf(state, ceil(log10(maxState)), -floor(log10(step))), pos.x+size+40, pos.y+10);
        text(text, pos.x+size+20*(ceil(log10(maxState))-floor(log10(step))+3), pos.y+10);
    }
}
boolean displaySettings = true;
float log10(float x)  {return log(x)/log(10);}
