class wave{
  float freq, T, omega, phi;
  
  wave(float freq_){
  freq = freq_;
  phi = 0;
  }
  
  float val(float unit, int i){
  T = unit / freq;
  omega = TWO_PI/T;
  return 1 + cos(omega * i + phi);
  }
}
