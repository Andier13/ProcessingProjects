//Buttons, checkboxes, sliders

class button{
  PVector pos;
  float size;
  String text;
  
  button(PVector position, float sizet, String message){
      pos = position;
      size = sizet;
      text = message;
  }
  
  boolean pressed(PVector v){return (displaySettings && (v.x>=pos.x && v.x<=pos.x+size && v.y>=pos.y && v.y<=pos.y+size));}
  boolean pressed(){return pressed(new PVector(mouseX, mouseY));}
  void display(){
      square(pos.x, pos.y, size);
      textAlign(LEFT); textSize(10); fill(255);
      text(text, pos.x+size/2, pos.y+size+10);
  }
}

//-------------------------------------------------------------------------------------------------------------------------------

class checkbox{
    boolean state;
    PVector pos;
    float size;
    String text;
    
    checkbox(PVector position, float sizet, boolean defaultState, String message){
        pos = position;
        size = sizet;
        state = defaultState;
        text = message;
    }
    
    boolean inside(PVector v)  {return (v.x>=pos.x && v.x<=pos.x+size && v.y>=pos.y && v.y<=pos.y+size);}
    void pressed(PVector v) {if (displaySettings) if (this.inside(v)) state = !state;}
    void pressed(){pressed(new PVector(mouseX, mouseY));}
    
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
        fill(255); //textSize(size);
        text(text, pos.x+size*2, pos.y+size);
    }
}

//-------------------------------------------------------------------------------------------------------------------------------

class slider{
    float state, maxState, minState, step;
    PVector pos;
    float size;
    String text;
    boolean selected;
    
    slider(PVector position, float sizet, float minStatet, float maxStatet, float defaultState, float stept, String message){
        pos = position;
        size = sizet;
        minState = minStatet;
        maxState = maxStatet;
        step = stept;
        state = defaultState;
        text = message;
        selected = false;
        if ((maxState-minState)/step>size){
            println("Slider", text, "may have decreased accuracy for step of size", step);
            println("Recomended minimum step is", (maxState-minState)/size);
        }
    }
    
    boolean inside(PVector v)  {return (PVector.sub(new PVector(map(state, minState, maxState, pos.x, pos.x+size), pos.y), v).mag()<10);}
    void update(PVector v){
        if (selected){
            if (v.x>=pos.x+size)
              {state=maxState; return;}
            if (v.x<=pos.x)
              {state=minState; return;}
            state=map(v.x, pos.x, pos.x+size, minState, maxState);
            state=state-state%step;
        }
    } 
    void pressed(PVector v)  {if (displaySettings) if (this.inside(v)) selected=true;}
    void unpressed()         {if (selected) selected=false;}
    
    void pressed() {pressed(new PVector(mouseX, mouseY));}
    void update()  {update(new PVector(mouseX, mouseY));}
    
    void autoScroll(){
        if (state>=maxState)
          state=minState;
        state+=step;
    }
    
    void display(){
        stroke(220); strokeWeight(5);
        line(pos.x, pos.y, pos.x+size, pos.y);
        colorMode(RGB); fill(70, 130, 180); stroke(176, 196, 222); strokeWeight(2);
        circle(map(state, minState, maxState, pos.x, pos.x+size), pos.y, 20);
        //textSize(20); fill(255);
        //text(nf(state, ceil(log10(maxState)), -floor(log10(step))), pos.x+size+40, pos.y+10);
        //text(text, pos.x+size+20*(ceil(log10(maxState))-floor(log10(step))+3), pos.y+10);
        fill(255); textAlign(CENTER);
        text(nf(state, (ceil(log10(state))<1?1:ceil(log10(state))), -floor(log10(step))), pos.x+size+40, pos.y+5);
        text(text, pos.x+size/2, pos.y+25);
    }
}
boolean displaySettings = true;
float log10(float x)  {return log(x)/log(10);}
