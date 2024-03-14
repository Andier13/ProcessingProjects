//Buttons, checkboxes, sliders

class button{
  PVector pos;
  float size;
  String text;
  
  button(float sizet, String message){
      size = sizet;
      text = message;
  }
  
  boolean pressed() {
      PVector v = new PVector(mouseX, mouseY); 
      return v.x>=pos.x && v.x<=pos.x+size && v.y>=pos.y && v.y<=pos.y+size;
  }
  void display(float x, float y){
      pos = new PVector(x, y);
      square(pos.x, pos.y, size);
      textAlign(CENTER); textSize(10); fill(255);
      text(text, pos.x+size/2, pos.y+size+10);
  }
}

//-------------------------------------------------------------------------------------------------------------------------------

class checkbox{
    boolean state;
    PVector pos;
    float size;
    String text;
    
    checkbox(float sizet, boolean defaultState, String message){
        size = sizet;
        state = defaultState;
        text = message;
    }
    
    void pressed() {
        PVector v = new PVector(mouseX, mouseY); 
        if (v.x>=pos.x && v.x<=pos.x+size && v.y>=pos.y && v.y<=pos.y+size) state = !state;
    }

    
    void display(float x, float y){
        pos = new PVector(x, y);
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

//-------------------------------------------------------------------------------------------------------------------------------

class slider{
    float state, maxState, minState, step;
    PVector pos;
    float size;
    String text;
    boolean selected;
    
    slider(float sizet, float minStatet, float maxStatet, float defaultState, float stept, String message){
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
    
    void pressed()      {if (PVector.sub(new PVector(map(state, minState, maxState, pos.x, pos.x+size), pos.y), new PVector(mouseX, mouseY)).mag()<10) selected=true;}
    void unpressed()    {if (selected) selected=false;}

    
    void autoScroll(){
        if (state>=maxState)
          state=minState;
        state+=step;
    }
    
    void display(float x, float y){
        pos = new PVector(x, y);
        PVector v = new PVector(mouseX, mouseY);
        if (selected){
            if (v.x>=pos.x+size)
              state=maxState;
            else if (v.x<=pos.x)
              state=minState;
            else{
            state=map(v.x, pos.x, pos.x+size, minState, maxState);
            state=state-state%step;
            }
        }
        stroke(220); strokeWeight(5);
        line(pos.x, pos.y, pos.x+size, pos.y);
        colorMode(RGB); fill(70, 130, 180); stroke(176, 196, 222); strokeWeight(2);
        circle(map(state, minState, maxState, pos.x, pos.x+size), pos.y, 20);
        textMode(CENTER);
        //textSize(20); fill(255);
        //text(nf(state, ceil(log10(maxState)), -floor(log10(step))), pos.x+size+40, pos.y+10);
        //text(text, pos.x+size+20*(ceil(log10(maxState))-floor(log10(step))+3), pos.y+10);
        fill(255);
        text(nf(state, (ceil(log10(state))<1?1:ceil(log10(state))), -floor(log10(step))), pos.x+size+40, pos.y+5);
        text(text, pos.x+size/2, pos.y+25);
    }
}
float log10(float x)  {return log(x)/log(10);}
