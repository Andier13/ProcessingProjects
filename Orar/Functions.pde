int weekday(){
  int t[]={0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
  int y=year(), m=month(), d=day();
  if (m<3) y--;
  return (y+y/4-y/100+y/400+t[m-1]+d)%7;
}

int weekday(int d, int m, int y){
  int t[]={0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
  if (m<3) y--;
  return (y+y/4-y/100+y/400+t[m-1]+d)%7;
}

int time(int h, int min){
  return h*60+min;
}

String digitalTime(int t){
  return nf((t/60), 2)+":"+nf((t%60), 2);
}

boolean fixedHour(int ex){
  boolean result = false;
  for (int h : ore)
      result = result || (ex==h || ex==h+durataOra);
  return result;
}

void ring(){
  if (!fixedHour(now) && fixedHour(time(hour(), minute()))) 
      {notification.amp(0.15); notification.play(); println("rung");}
}
void ring2(){
  if (!fixedHour(prevnow) && fixedHour(now))
      {notification.amp(0.5); notification.play(); println("rung");}
}

String toBasicLatin(String s){
  /*
  String result = "";
  for (int i=0; i<s.length(); i++){
    char c = s.charAt(i);
    if (c=='ă' || c=='â') c='a';
    result.concat(String(c));result.replace(,)
    */
  s = s.replaceAll("ă","a"); s = s.replaceAll("Ă","A");
  s = s.replaceAll("â","a"); s = s.replaceAll("Â","A");
  s = s.replaceAll("î","i"); s = s.replaceAll("Î","I");
  s = s.replaceAll("ș","s"); s = s.replaceAll("Ș","S");
  s = s.replaceAll("ț","t"); s = s.replaceAll("Ț","T");
  return s;
}
