class SpriteTimer {
  int time;
  float interval;
  boolean repeat;
  boolean isActive;
  
  SpriteTimer(float interval) {
    this.interval = interval;
    this.time = millis();
    this.isActive = true;
  }
  
  boolean cycle() {
    if ((millis() - this.time) >= interval) {
      this.time = millis();
      return(true);
    }
    else {
      return(false);
    }
  }
}