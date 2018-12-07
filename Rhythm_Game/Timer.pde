class Timer {
  int time, boardTime, songTime;
  float interval, songLength;
  boolean isActive;
  int cushion;
  boolean isStart = false;
  
  Timer(float _interval, int cushion, float songLength) {
    this.interval = _interval;
    this.isActive = true;
    this.cushion = cushion;
    this.songLength = songLength;
    // initialize the total song timer as soon as the timer is created.
    this.songTime = millis();
    
  }
  
  boolean getIsActive() {
    return(this.isActive);
  }
  
  boolean advanceBoard() {
    if (this.isStart){
      if ((millis() - this.boardTime) >= this.interval) {
        this.boardTime = millis();
        return(true);
      }
      else {
        return(false);
      }
    }
    else {
      return(false);
    }
  }
  
  boolean songOver() {
   if ((millis() - this.songTime) > this.songLength) {
      return(true);
    }
    else {
      return(false);
    }
  }
  
  void startTimer() {
    this.isStart = true;
    this.time = millis();
    this.boardTime = millis();
    
  }
  
  void toggleActive() {
    // Once the user triggers the start with the first key press, he/she has
    // set the timer from that point onward. So theoretically, they could play
    // on the upbeats if they wanted.
    if (this.isStart == true) {
      if ((millis() - time) >= (this.interval - this.cushion) && //
      (millis() - time) <= (this.interval + this.cushion)) {
        this.isActive = true;
      }
      else if ((millis() - time) < (this.interval - this.cushion)) {
        this.isActive = false;
      }
      else if ((millis() - time) > (this.interval + this.cushion)) {
        this.isActive = false;
        // We subtract the cushion so that the next cycle overlaps with the
        // end of the cushion, rather than being added on to the end.
        this.time = millis() - this.cushion;
      }
    }
    
  }
}