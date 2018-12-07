class Dragon extends Baddie {
  PVector firePos;
  PImage[] fire;
  String fireString;
  int fireIndex, numFire;
  
  Dragon (PVector _pos,  PVector _firePos, SpriteTimer _timer, PImage[] dragonSprites, int _numSprites, PImage[] fireSprite, int _numFire){
    super (_pos, _timer, dragonSprites, _numSprites);
    firePos = _firePos;
    fire = fireSprite;
    numFire = _numFire;
  }
  
  PVector test_fire(){
    int xShift = 0;
    int yShift = 0;
    while (xShift == 0 && yShift == 0){
      
      // if dragon on edge of board in x direction, place fire towards inside
      if (pos.x == 0){
        xShift = int (random (0, 2));
      }
      else if (pos.x == 12){
        xShift = int (random (-2, 1));
      }
      else {
        xShift = int (random (-2, 2));
      }
      
      // if dragon on edge of board in y direction, place fire towards inside
      if (pos.y == 0){
        yShift = int (random (0, 2));
      }
      else if (pos.y == 8){
        yShift = int (random (-2, 1));
      }
      else {
        yShift = int (random (-2, 2));
      }
    }
    return new PVector (pos.x + xShift, pos.y + yShift);
  }
  
  void advance_sprite(){
    
    // advance main sprite
    if (timer.cycle()) {
      if (spriteIndex == numSprites - 1) {
        spriteIndex = 0;
      }
      else {
        spriteIndex ++;
      }
    
    // advance fire sprite
      if (fireIndex == numFire - 1) {
        fireIndex = 0;
      }
      else {
        fireIndex ++;
      }
    }
  }
  
  void display(){
    advance_sprite();
    image (sprite[spriteIndex], (pos.x * 50) + 175, (pos.y * 50) + 125);
    image (fire[fireIndex], (firePos.x * 50) + 175, (firePos.y * 50) + 125);
  }
}