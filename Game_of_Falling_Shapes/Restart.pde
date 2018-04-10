class Restart {
  PVector origin;
  float butWidth;
  float butHeight;

  Restart (float x, float y) {
    this.origin = new PVector(x, y);
    this.butWidth = 200;
    this.butHeight = 120;
  }

  boolean clicked() {
    if (mousePressed && mouseX > this.origin.x && mouseX < this.origin.x + //
      this.butWidth && mouseY > this.origin.y && mouseY < this.origin.y + //
      this.butHeight) {
      return(true);
    } else {
      return(false);
    }
  }

  void display() {
    fill(#05DFF5);
    rect(this.origin.x, this.origin.y, this.butWidth, this.butHeight);
    textSize(30);
    fill(0);
    text("RESTART", this.origin.x + 35, this.origin.y + 70);
  }
}