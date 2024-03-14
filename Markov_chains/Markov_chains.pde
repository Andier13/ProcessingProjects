
String text, result;
boolean done = false;
float offset = 0;
int order = 6;

void setup(){
  size(800, 800);
  selectInput("Select a file:", "processFile");
}

void draw(){
  background(0);
  if (done){
    fill(255);
    textSize(15);
    textLeading(20);
    text(text, 0, offset, width, height);
  }
  //println(done);
}

void mouseWheel(MouseEvent event){
  //println(event.getCount(), event.getButton(), event.getX(), event.getY(), event.WHEEL);
  offset+=event.getCount()*-40;
  if (offset>0) offset=0;
}

void processFile(File f){
  String[] lines = loadStrings(f);
  text = lines[0];
  for (int i=1; i<lines.length; i++)
    text+=lines[i]+'\n';
  StringDict chain = new StringDict();
  for (int i=0; i<text.length()-order; i++){
    String part = text.substring(i, i+order);
    String next = text.substring(i+order, i+order+1);
    if (chain.hasKey(part))
      chain.set(part, chain.get(part)+next);
    else
      chain.set(part, next);
  }
  println(chain);
  result = text.substring(0, order);
  for (int i=0; i<1000; i++){
    String last = result.substring(i, i+order),
           next = chain.get(last);
    int index = floor(random(0, next.length()));
    //println(last + '/' + next + '/' + index);
    result += next.charAt(index);
  }
  print("\n\n\n\n\n");
  println(result);
  done = true;
}
