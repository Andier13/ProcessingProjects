
void setup(){
    size(1000, 800);
}

void draw(){
    background(0);
    stroke(255);
    strokeWeight(5);
    noFill();
    strokeJoin(ROUND);
    
    beginShape();
    for(int i=0; i<1000; i++){
        PVector center = new PVector(width/2, height/2);
        float angle = map(i, 0, 1000, 0, TWO_PI);
        float maxRadius = height/2;
        float minRadius = 0;//maxRadius/2;
        float radius = map(f(angle), 0, 1, minRadius, maxRadius);
        PVector p = PVector.fromAngle(angle).mult(radius);
        vertex(center.x+p.x, center.y+p.y);  
    }
    endShape(CLOSE);
}

float f(float x){
    float numberOfPetals = millis()/1000.;
    float frequency = numberOfPetals;
    //return sin(frequency*x-HALF_PI); //elice
    //return abs(sin(frequency*x)); //floarea soarelui
    //return x*x*frequency%1; //chainsaw
    //return sqrt(x)*frequency%1; //different chainsaw
    //return floor(x)*frequency%1; //towers
    //return abs(asin(map(x*frequency, 0, TWO_PI, 0, 1)%1)); //toy windmill
    return abs(asin(map(x*frequency+TWO_PI, 0, TWO_PI, 0, 1)%2-1)); //pointy petals
}
