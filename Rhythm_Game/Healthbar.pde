class Healthbar {
  float rectHeight = 20, rectWidth;
  PVector position;
  
  // health is out of 200
  // shown by width of rectangle in upper left
  Healthbar() {
    this.rectWidth = 200;
  }
  
  void display() {
    textSize(20);
    textAlign (LEFT);
    fill(255);
    text("Health: " + str (int (rectWidth / 2)), 15, 20);
    fill(0, 255, 0);
    rectMode(CORNER);
    rect(15, 30, this.rectWidth, rectHeight);
  }
  
  boolean checkHealth() {
    if (this.rectWidth <= 0) {
      return(true);
    }
    else {
      return(false);
    }
  }
  
  void reset() {
    this.rectWidth = 200;
  }
}