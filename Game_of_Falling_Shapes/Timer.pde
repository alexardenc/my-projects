class Timer {
  int time;
  int interval;
  boolean repeat;
  boolean isActive;
  color poo = 0;
  
  Timer(int _interval) {
    time = millis();
    interval = _interval;
    repeat = false;
    isActive = true;
  }
  
  Timer(int _interval, boolean _repeat) {
    time = millis();
    interval = _interval;
    repeat = _repeat;
    isActive = true;
  }
    
  
  boolean reset() {
    if ((millis() - time) >= this.interval) {
      time = millis();
      return(true);
    }
    else {
      return(false);
    }
  }
  
  void resetZero() {
    time = millis();
  }
}