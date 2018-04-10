class Hero {
  PVector position;
  int spriteIndex;
  float speed;
  int framecount = 8;
  PImage[] spriteImages = new PImage[framecount];
  Timer timer;
  
  Hero (PVector position, Timer timer) {
    this.position = position;
    this.spriteIndex = 0;
    this.speed = 5;
    this.timer = timer;
    for (int i = 0; i < 8; i++) {
      spriteImages[i] = loadImage("spritesheet_caveman-" + nf((i + 1), 2) + ".png");
      spriteImages[i].resize(50, 50);
    }
  }
  
  void advance() {
    if (this.timer.reset()) {
      if (this.spriteIndex == 7) {
        spriteIndex = 0;
      }
      else {
        spriteIndex++;
      }
    }
  }
  
  void moveForward() {
    this.position.x += this.speed;
  }
  
  void moveBack() {
    this.position.x -= this.speed;
  }
  
  void display() {
    image(spriteImages[spriteIndex], position.x, position.y);
  }
      
}