float hudw=240, coff=100;
color bg=color(52), hudc=color(80), bp=color(70), bd=color(220);
Vector2D pmouse, mouse, startm;
Vector2D corner1, corner2, sel1, sel2;
colorWheel selector;
button bgClear, save, addCol, pencil, pen, spray, uspray, select, copy, cut, paste;
slider weight, density, alpha;
int l=3, c=8;
colorButton[] prevcol = new colorButton[l*c];
drawMode mode = drawMode.PENCIL, prevm=mode;
selectMode selm = selectMode.PREDRAW;
PGraphics canvas;

void setup(){
  fullScreen();
  background(bg);
  frameRate(144);
  colorMode(HSB);
  corner1 = new Vector2D(coff, coff);
  corner2 = new Vector2D(width-hudw-coff, height-coff);
  coff--;
  canvas = createGraphics(int(corner2.x-corner1.x)-1, int(corner2.y-corner1.y)-1);
  canvas.beginDraw();
  canvas.background(255);    
  canvas.endDraw();
  selector = new colorWheel(new Vector2D(width-200-20, 20), 200);
  addCol =   new button(new Vector2D(width-220, 280), 20, "Add color");
  bgClear =  new button(new Vector2D(width-220, 340), 20, "Clear");
  save  =    new button(new Vector2D(width-180, 340), 20, "Save");
  pencil =   new button(new Vector2D(width-220, 380), 20, "Pencil");
  pen =      new button(new Vector2D(width-180, 380), 20, "Pen");
  spray =    new button(new Vector2D(width-140, 380), 20, "Spray");
  uspray =   new button(new Vector2D(width-100, 380), 20, "Graffiti");
  //select =   new button(new Vector2D(width-60,  380), 20, "Select");
  weight =   new slider(new Vector2D(width-220, 440), 150, 1, 100, 5, 1, "Thickness");
  //alpha =    new slider(new Vector2D(width-220, 610), 150, 0, 100, 0, 1, "Transparency");
  density =  new slider(new Vector2D(width-220, 490), 150, 1, 100, 50, 1, "Spray density");
  for (int i=0; i<l; i++)
      for (int j=0; j<c; j++)
          prevcol[i*c+j] = new colorButton(new Vector2D(width-180+j*20, 260+i*20), 20, color(255));
}

void mousePressed(){
  startm = new Vector2D(mouseX, mouseY);
  selector.pressed(mouse);
  weight.pressed(mouse);
  //alpha.pressed(mouse);
  density.pressed(mouse);
  if (bgClear.pressed(mouse)) {canvas.beginDraw(); canvas.background(255); canvas.endDraw();}
  if (save.pressed(mouse)) canvas.save(savePath("Saves/save"+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2)+'-'+nf(day(), 2)+nf(month(), 2)+nf(year(), 2)+".png"));
  if (addCol.pressed(mouse)) {
      for (int i=l*c-1; i>0; i--)
          prevcol[i].state=prevcol[i-1].state;
      prevcol[0].state = selector.state();
  }
  prevm=mode;
  if (pencil.pressed(mouse)){mode=drawMode.PENCIL;}
  if (spray.pressed(mouse)){mode=drawMode.SPRAY;}
  if (pen.pressed(mouse)){mode=drawMode.PEN;}
  if (uspray.pressed(mouse)){mode=drawMode.USPRAY;}
  /*
  if (select.pressed(mouse)){mode=drawMode.SELECT;loadCanvas();}
  if (prevm==drawMode.SELECT && mode!=drawMode.SELECT)
      image(canvas, coff+1, coff+1);
  if (selm==selectMode.POSTDRAW)
      if (!insideSelect(mouse))
          selm=selectMode.PREDRAW;
  if (mode!=drawMode.SELECT) selm=selectMode.PREDRAW;
  if (mode==drawMode.SELECT && selm==selectMode.PREDRAW && insideCanvas(startm))
      {sel1=new Vector2D(mouseX, mouseY); selm=selectMode.DRAW;}
  */
  for (int i=0; i<l; i++)
      for (int j=0; j<c; j++)
          prevcol[i*c+j].pressed(mouse, selector);
  if (insideCanvas(mouse) && mouseButton==RIGHT){
      loadPixels();
      selector.setState(pixels[mouseY*width+mouseX]);
  }
}
void mouseReleased(){
  selector.unpressed();
  weight.unpressed();
  //alpha.unpressed();
  density.unpressed();
  if (selm==selectMode.DRAW)
      selm=selectMode.POSTDRAW;
}
void mouseDragged(){
  if (insideCanvas(startm) && mouseButton==LEFT){
      canvas.beginDraw();
      canvas.stroke(selector.state()/*, map(alpha.state, 0, 100, 255, 0)*/); canvas.strokeWeight(weight.state);
      switch(mode){
          case PENCIL:
              {canvas.line(pmouseX-coff, pmouseY-coff, mouseX-coff, mouseY-coff); break;}
              
          case PEN:
              {float w=map(dist(pmouseX, pmouseY, mouseX, mouseY), 0, 20, 0, weight.state/2); if(w>weight.state) w=weight.state;
              canvas.strokeWeight(w); canvas.line(pmouseX-coff, pmouseY-coff, mouseX-coff, mouseY-coff); break;}
              
          case SPRAY:
              {for (float i=mouseX-weight.state; i<=mouseX+weight.state; i++)
                   for (float j=mouseY-weight.state; j<=mouseY+weight.state; j++)
                       if(dist(mouseX, mouseY, i, j)<=weight.state/2)
                           if (random(weight.state)<=density.state/100*2)
                                 {canvas.strokeWeight(1); canvas.point(i-coff, j-coff);}
               break;}
               
          case USPRAY:
              {for (float r=0; r<=weight.state/2; r+=2)
                  {canvas.stroke(selector.state(), map(r, 0, weight.state/2, 255, 0)); canvas.strokeWeight(2); if(r>2) canvas.noFill(); else canvas.fill(selector.state()); 
                    canvas.circle(mouseX-coff, mouseY-coff, 2*r);} break;}
      }
      canvas.endDraw();
  }
}

void draw(){
  background(bg);
  mouse = new Vector2D(mouseX, mouseY);
  pmouse = new Vector2D(pmouseX, pmouseY);
  selector.update(mouse);
  weight.update(mouse);
  //alpha.update(mouse);
  if (mode==drawMode.SPRAY) density.update(mouse);
  
  if (insideCanvas(mouse))
      cursor(CROSS);
  //else if(mouseX>width-hudw)
  //    cursor(HAND);
  else
      cursor(ARROW);
  
  //Canvas
  /*
  if (mode==drawMode.SELECT){
      image(canvas, coff+1, coff+1);
      if((selm==selectMode.DRAW || selm==selectMode.POSTDRAW)) 
          {if(selm==selectMode.DRAW && insideCanvas(mouse)) sel2=new Vector2D(mouseX, mouseY); 
          strokeWeight(2); stroke(0); noFill(); rect(sel1, sel2);}
  }
  */
  image(canvas, coff+1, coff+1);
  
  //HUD
  fill(hudc); stroke(255); strokeWeight(5);             //hud bg
  rect(width-hudw, 0, hudw, height);
  selector.display();                             //colour wheel
  if(cbp) cbp=false;
  stroke(255); strokeWeight(5);
  line(width-hudw, 240, width, 240);
  fill(selector.state()); stroke(0); strokeWeight(3); //current colour
  square(width-230, 10, 30);
  fill(bd); strokeWeight(2);                         //buttons
  addCol.display();
  stroke(0);                                          //color select board
  for (int i=0; i<l; i++)
      for (int j=0; j<c; j++)
          prevcol[i*c+j].display();
  textSize(12);
  fill(bd); bgClear.display();
  fill(bd); save.display();
  fill((mode==drawMode.PENCIL?bp:bd)); pencil.display();
  fill((mode==drawMode.PEN?bp:bd)); pen.display();
  fill((mode==drawMode.SPRAY?bp:bd)); spray.display();
  fill((mode==drawMode.USPRAY?bp:bd)); uspray.display();
  //fill((mode==drawMode.SELECT?70:255)); select.display();
  weight.display();
  //alpha.display();
  if (mode==drawMode.SPRAY) density.display();
  text("Right click to pick color off canvas", width-hudw/2, height-40);
  text(nf(frameRate, 2, 2), 20, 12); text("FPS", 60, 12);
}
