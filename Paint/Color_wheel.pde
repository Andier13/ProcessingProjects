class colorWheel{
    float hue, sat, bri;
    Vector2D pos, center;
    float size, sqside;
    float minw, maxw, minh, maxh;
    boolean selectedHue, selectedBri;
    PImage square;
    PGraphics hueCircle;
    
    colorWheel(Vector2D position, float sizet){
        pos = position;
        size = sizet;
        center = new Vector2D(pos.x+size/2, pos.y+size/2);
        sqside = (size*4/5-size/5/2)/sqrt(2)-6;
        minw = center.x - sqside/2; maxw = minw + sqside;
        minh = center.y - sqside/2; maxh = minh + sqside;
        selectedHue = false;
        selectedBri = false;
        hue = 0; sat = 255; bri = 255;
        
        float c=size/2+3;
        hueCircle = createGraphics(int(size)+6, int(size)+6);
        hueCircle.beginDraw();
        hueCircle.colorMode(HSB);
        for(int i=0; i<256; i++){
            hueCircle.fill(i, 255, 255); hueCircle.strokeWeight(3); hueCircle.stroke(i, 255, 255);
            hueCircle.arc(c, c, size, size, i*TAU/256, (i+1)*TAU/256, PIE);
        }
        hueCircle.fill(hudc); hueCircle.stroke(0); hueCircle.circle(c, c, size*4/5-4);
        hueCircle.noFill(); hueCircle.stroke(0);  hueCircle.circle(c, c, size+3);
        hueCircle.endDraw();
        
        square = new PImage(int(sqside), int(sqside));
        for (int i=0; i<square.height; i++)
            for (int j=0; j<square.width; j++)
                {square.pixels[j*square.height+i]=color(hue, map(i, 0, sqside, 0, 255), map(j, 0, sqside, 255, 0));}
    }
    color state() {colorMode(HSB); return color(hue, sat, bri);}
    void setState(color col) {
        hue=hue(col); sat=saturation(col); bri=brightness(col);
        colorMode(HSB);
        for (int i=0; i<square.height; i++)
            for (int j=0; j<square.width; j++)
                {square.pixels[j*square.height+i]=color(hue, map(i, 0, sqside, 0, 255), map(j, 0, sqside, 255, 0));} 
            square.updatePixels();}
    
    boolean insideHue(Vector2D v) {return (sub(center, v).mag()<=size/2 && sub(center, v).mag()>=size/2-size/5/2);}
    boolean insideBri(Vector2D v) {return (v.x>=minw && v.x<=maxw && v.y>=minh && v.y<=maxh) || sub(v, new Vector2D(map(sat, 0, 255, minw, maxw), map(bri, 255, 0, minh, maxh))).mag()<=size/5/2;}
    void update(Vector2D v){
        if (selectedHue)
            {hue = map(sub(center, v).angle()+PI, 0, TAU, 0, 255);
            colorMode(HSB);
            for (int i=0; i<square.height; i++)
                for (int j=0; j<square.width; j++)
                    {square.pixels[j*square.height+i]=color(hue, map(i, 0, sqside, 0, 255), map(j, 0, sqside, 255, 0));} 
            square.updatePixels();
            }
        if (selectedBri){
            sat = map(v.x, minw, maxw, 0, 255);
            if (v.x<=minw) sat = 0;
            if (v.x>=maxw) sat = 255;
            bri = map(v.y, minh, maxh, 255, 0);
            if (v.y<=minh) bri = 255;
            if (v.y>=maxh) bri = 0;
        }
    } 
    void pressed(Vector2D v)  {if (displaySettings){if (this.insideHue(v)) selectedHue=true; if(this.insideBri(v)) selectedBri=true;}}
    void unpressed()          {if (selectedHue) selectedHue=false; if (selectedBri) selectedBri=false;}

    void display(){
        colorMode(HSB);
        
        //HUE
        image(hueCircle, pos.x-3, pos.y-3);
        
        //HUE Button
        Vector2D huesel = add(center, polarVector2D(size*9/10/2, map(hue, 0, 255, 0, TAU)));
        fill(hue, 255, 255); stroke(0); strokeWeight(2);
        circle(huesel.x, huesel.y, size/5/2);
    
        //Brightnes Square
        image(square, minw, minh);
        
        //Square Button
        fill(hue, sat, bri); stroke(0); strokeWeight(2);
        circle(map(sat, 0, 255, minw, maxw), map(bri, 255, 0, minh, maxh), size/5/2);
        
    }
}
