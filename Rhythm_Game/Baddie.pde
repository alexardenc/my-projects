class Baddie {
  PVector pos;
  PImage[] sprite;
  SpriteTimer timer;
  String spriteString;
  int spriteIndex, numSprites;
  
  Baddie (PVector _pos, SpriteTimer _timer, PImage[] _sprite, int _numSprites){
    pos = _pos;
    timer = _timer;
    this.sprite = _sprite;
    numSprites = _numSprites;
  }
  
  PVector test_move(){
    
    // randomize shift
    int shift = 0;
    while (shift == 0){
      shift = int (random (-2, 2));
    }
    
    // choose whether to move horizontally or vertically
    int leftRight = int (random (0, 2));
    if (leftRight == 0){
      
      // if on edge of board in x direction, move towards inside
      if (pos.x == 0){
        return new PVector (pos.x + 1, pos.y);
      }
      else if (pos.x == 12){
        return new PVector  (pos.x - 1, pos.y);
      }
      else {
        return new PVector (pos.x + shift, pos.y);
      }
    }
    else {
      
      // if on edge of board in y direction, move towards inside
      if (pos.y == 0){
        return new PVector (pos.x, pos.y + 1);
      }
      
      else if (pos.y == 8){
        return new PVector  (pos.x, pos.y - 1);
      }
      else {
        return new PVector (pos.x, pos.y + shift);
      }
    }
    
  }
  
  void advance_sprite() {
    if (timer.cycle()) {
      if (spriteIndex == numSprites - 1) {
        spriteIndex = 0;
      }
      else {
        spriteIndex ++;
      }
    }
  }
  
  void display(){
    advance_sprite();
    image (sprite[spriteIndex], (pos.x * 50) + 175, (pos.y * 50) + 125);
  }
}