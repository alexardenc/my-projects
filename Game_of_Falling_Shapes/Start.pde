class Start {
  PVector origin;
  float butWidth;
  float butHeight;
  
  Start () {
    this.origin = new PVector(500, 400);
    this.butWidth = 200;
    this.butHeight = 120;
  }
  
  boolean clicked() {
    if (mousePressed && mouseX > this.origin.x && mouseX < this.origin.x + //
    this.butWidth && mouseY > this.origin.y && mouseY < this.origin.y + //
    this.butHeight) {
      return(true);
    }
    else {
      return(false);
    }
  }
  
  void display() {
    fill(#05DFF5);
    rect(this.origin.x, this.origin.y, this.butWidth, this.butHeight);
    textSize(20);
    fill(0);
    text("How To Play:", 510, 100);
    text("1. Use J, L to move left and right", 370, 150);
    text("2. Use 1-red triangles, 2-green circles, 3-blue squares to shoot", 370, 200);
    text("3. Shoot the falling shapes with the corresponding bullet", 370, 250);
    text("4. Use the wrong bullet and lose health", 370, 300);
    text("5. Shoot 25 shapes correctly, you win!", 370, 350);
    textSize(30);
    text("START", this.origin.x + 50, this.origin.y + 70);
  }
}