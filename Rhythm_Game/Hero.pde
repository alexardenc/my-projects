class Hero {
  PVector pos;
  boolean attacking;
  PImage[] sprite = new PImage[8];
  SpriteTimer timer;
  int health = 100;
  int spriteIndex;
  
  Hero(PVector pos, SpriteTimer timer) {
    this.pos = pos;
    this.timer = timer;
    
    for (int i = 0; i < 8; i++) {
      this.sprite[i] = loadImage("spritesheet_caveman-" + nf((i + 1), 2) + ".png");
      this.sprite[i].resize(50, 50);
    }
  }
  
  void moveRight() {
    this.pos.x += 1;
  }
  
  void moveLeft() {
    this.pos.x -= 1;
  }
  
  void moveDown() {
    this.pos.y += 1;
  }
  
  void moveUp() {
    this.pos.y -= 1;
  }
  
  void advanceSprite() {
    if (this.timer.cycle()) {
      if (this.spriteIndex == 7) {
        this.spriteIndex = 0;
      }
      else {
        this.spriteIndex++;
      }
    }
  }
  
  void display() {
    image(sprite[this.spriteIndex], (this.pos.x * 50) + 175, (this.pos.y * 50) + 125);
  }
    
}