class Dolphin {
  float x, y, speed, resetThresh, resetCount;
  int blowholeCount;
  color bodyColor;
  PShape body, blowhole;
  
  Dolphin (float x, float y, color bodyColor, float speed) {
    this.x = x;
    this.y = y;
    this.bodyColor = bodyColor;
    this.speed = speed;
    this.blowholeCount = 0;
    this.resetThresh = 1225 / speed;
    this.resetCount = 0;
    this.draw_body ();
    this.draw_blowhole ();
  };
  
  void draw_body () {
    this.body = createShape (GROUP);
    fill (bodyColor);
    noStroke ();
    PShape torso = createShape (ELLIPSE, this.x, this.y, 225, 75);
    PShape nose = createShape (ELLIPSE, this.x + 75, this.y + 15, 150, 25);
    PShape dorsal = createShape (TRIANGLE, this.x - 30, this.y - 20, this.x - 30, this.y - 75, this.x + 30, this.y - 20);
    PShape tail = createShape (TRIANGLE, this.x - 100, this.y, this.x - 150, this.y - 30, this.x - 150, this.y + 30);
    fill (0);
    PShape eye = createShape (ELLIPSE, this.x + 75, this.y - 5, 10, 10);
    fill (bodyColor);
    stroke (0);
    strokeWeight (1);
    PShape fin = createShape (TRIANGLE, this.x - 20, this.y + 15, this.x + 20, this.y + 15, this.x - 20, this.y + 60);
    this.body.addChild (torso);
    this.body.addChild (nose);
    this.body.addChild (dorsal);
    this.body.addChild (tail);
    this.body.addChild (eye);
    this.body.addChild (fin);
  }
  
  void draw_blowhole (){
    fill (color (175, 230, 255));
    this.blowhole = createShape (GROUP);
    PShape blowhole1 = createShape (ELLIPSE, this.x + 80, this.y - 30, 10, 10);
    PShape blowhole2 = createShape (ELLIPSE, this.x + 80, this.y - 40, 15, 15);
    PShape blowhole3 = createShape (ELLIPSE, this.x + 80, this.y - 55, 20, 20);
    this.blowhole.addChild (blowhole1);
    this.blowhole.addChild (blowhole2);
    this.blowhole.addChild (blowhole3);
  }
  
  void display () {
    pushMatrix ();
    if (this.resetCount > this.resetThresh){
      this.body.translate (this.speed * -this.resetCount, 0);
      this.blowhole.translate (this.speed * -this.resetCount, 0);
      this.resetCount = 0;
    } else {
      this.resetCount ++;
    }
    this.body.translate (this.speed, 0);
    this.blowhole.translate (this.speed, 0);
    if (this.blowholeCount < 20){
      this.blowhole.translate (0, -1);
      this.blowholeCount ++;
    } else {
      this.blowhole.translate (0, 20);
      this.blowholeCount = 0;
    }
    shape (this.body);
    shape (this.blowhole);
    popMatrix ();
  }
  
  void reset (){
    this.body.translate (-1080, 0);
    this.blowhole.translate (-1080, 0);
  }
}