class Fish {
  float x, y, angle;
  float change = 1;
  color bodyColor;

  
  Fish(float x, float y, color bodyColor) {
    this.x = x;
    this.y = y;
    this.bodyColor = bodyColor;
  }
  
  void display() {
    PShape fish = createShape(GROUP);
    fill (this.bodyColor);
    PShape body = createShape(ELLIPSE, this.x, this.y, 75, 50);
    stroke(#2F99E8);
    PShape mouth = createShape(TRIANGLE, this.x+25, this.y+5, this.x+40, this.y, this.x+40, this.y+10);
    mouth.setFill(#2F99E8);
    PShape eye = createShape(ELLIPSE, this.x+20, this.y-5, 7, 7);
    eye.setFill(0); 
    stroke(0);
    PShape sideFin = createShape(ARC, this.x, this.y, 10, 13, radians(90), radians(270), OPEN);
    PShape topFin = createShape(ELLIPSE, this.x, this.y-25, 30, 15);
    fish.addChild(topFin);
    fish.addChild(body);
    fish.addChild(mouth);
    fish.addChild(eye);
    fish.addChild(sideFin);
    shape(fish);
  }
  
  void displayTail(){
    angle += change;

    if (angle > 30 || angle < -10){
      change = -change;
      angle += change;
    } 

    pushMatrix();
    translate(this.x-50, this.y);
    rotate(radians(angle));
    fill (this.bodyColor);
    PShape tail = createShape(ARC, 0, 0, 40, 40, PI+QUARTER_PI, 3*PI-QUARTER_PI, PIE);
    shape(tail);
    popMatrix();
  }
  
  void move() {
    this.x += 2;
    
    if (x>=1050){
      this.x = 0;
    }
    if (this.x == -2){
      this.x = -700;
    }
  }
}