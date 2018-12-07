class Icon {
  PVector pos;
  float angle, breath = 30;
  float change = .5, changeRate = 1, angleChange = .6;
  PImage baddie, fire, note;
  
  Icon(PVector pos, PImage note){
    this.pos = pos;
    fire = loadImage("fire-1.png");
    fire.resize(90, 60);
    baddie = loadImage("dragon-1.png");
    baddie.resize(110, 90);
    this.note = note;

  }
  
  void display(){
    display_fire();
    image (baddie, this.pos.x, this.pos.y);
    
    angle += angleChange;

    if (angle > 20 || angle < -20){
      angleChange = - angleChange;
      angle += angleChange;
    } 
    pushMatrix();
    translate(this.pos.x + 115, this.pos.y - 15);
    rotate(radians(angle));
    image(note, 0, 0);
    popMatrix();
  }
  
  void display_fire(){
    breath += change;      
    
    if (breath > 85 || breath < 0){
      change = -change;
    }
    pushMatrix();
    translate(this.pos.x + breath, this.pos.y + 30);
    image (fire, 0, 0);
    popMatrix();
  }
  
  void move(){
    this.pos.x += changeRate;
    
    if (this.pos.x >= 1050){
      this.pos.x = -100;
    }
  }
}