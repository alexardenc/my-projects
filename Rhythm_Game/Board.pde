// 13x9 game board
class Board {
  int level, score;
  PImage[] dragonSprites;
  PImage[] baddieSprites;
  PImage[] fireSprite;
  color color1, color2, startColor;
  PVector dim;
  SpriteTimer spriteTimer;
  Hero hero;
  int[][] occupied;
  Barrier[] barriers;
  ArrayList <Baddie> baddies;
  ArrayList <Dragon> dragons;
  
  Board (int _level, color _color1, color _color2, PImage[] baddieSprites, PImage[] dragonSprites, PImage[] fire){
    color1 = _color1;
    color2 = _color2;
    startColor = color1;
    this.baddieSprites = baddieSprites;
    this.dragonSprites = dragonSprites;
    this.fireSprite = fire;
    
    // initialize list of occupied spaces
    occupied = new int[13][9];
    for (int x = 0; x < occupied.length; x++){
      for (int y = 0; y < occupied[x].length; y++){
        occupied[x][y] = 0;
      }
    }
    
    // create barriers
    barriers = new Barrier[_level * 2];
    for (int i = 0; i < barriers.length; i++){
      PVector pos = new PVector (6, 4);
      while ((pos.x == 6 && pos.y == 4) || !is_empty(pos)){
        pos = new PVector (int (random (0, 13)), int (random (0, 9)));
      }
      barriers[i] = new Barrier (pos);
      occupied[int (pos.x)][int (pos.y)] = 1;
    }
    
    // create hero
    spriteTimer = new SpriteTimer(50);
    hero = new Hero(new PVector (6, 4), spriteTimer);
    
    // initialize baddie/dragon arrays
    baddies = new ArrayList <Baddie>();
    dragons = new ArrayList <Dragon>();
  }
  
  int getScore() {
    return(this.score);
  }
  
  // display game board and characters
  void display(){
    noStroke();
    rectMode (CORNER);
    
    // display board
    color fillColor = startColor;
      for (int x = 0; x < 13; x++){
        for (int y = 0; y < 9; y++){
        fill (fillColor);
        rect ((x * 50) + 175, (y * 50) + 125, 50, 50);
        if (fillColor == color1){
          fillColor = color2;
        }
        else {
          fillColor = color1;
        }
      }
    }
    
    // display barriers
    for (int i = 0; i < barriers.length; i ++){
      barriers[i].display();
    }
    
    // display hero
    hero.advanceSprite();
    hero.display();
    
    // display baddies/dragons
    for (int i = 0; i < baddies.size(); i++){
      Baddie temp = baddies.get (i);
      temp.display();
    }
    for (int i = 0; i < dragons.size(); i++){
      Dragon temp = dragons.get (i);
      temp.display();
    }
  }
  
  // alternate board colors
  void switch_colors(){
    if (startColor == color1){
      startColor = color2;
    }
    else {
      startColor = color1;
    }
  }
  
  // check list of occupied spaces and return true if board position is empty
  Boolean is_empty (PVector pos){
    if (occupied[int (pos.x)][int (pos.y)] == 0){
      return true;
    }
    else {
      return false;
    }
  }
  
  // check if a space is surrounded by occupied spaces
  Boolean is_surrounded (PVector pos){
    if (pos.x != 0){
      if (is_empty (new PVector (pos.x - 1, pos.y))){
        return false;
      }
    }
    if (pos.x != 12){
      if (is_empty (new PVector (pos.x + 1, pos.y))){
        return false;
      }
    }
    if (pos.y != 0){
      if (is_empty (new PVector (pos.x, pos.y - 1))){
        return false;
      }
    }
    if (pos.y != 8){
      if (is_empty (new PVector (pos.x, pos.y + 1))){
        return false;
      }
    }
    return true;
  }
  
  // check list of barriers and return true if board position is a barrier
  Boolean is_barrier (PVector pos){
    for (int i = 0; i < barriers.length; i++){
      if (barriers[i].pos.x == pos.x && barriers[i].pos.y == pos.y){
        return true;
      }
    }
    return false;
  }
  
  // add baddie/dragon to board
  void add_baddie(){
    float randChance = random (0, 2);
    PVector baddiePos = new PVector (int (random (0, 13)), int (random (0, 9)));
    
    // do not place baddie on occupied square
    while ((baddiePos.x == hero.pos.x && baddiePos.y == hero.pos.y) || !is_empty (baddiePos)){
      baddiePos = new PVector (int (random (0, 13)), int (random (0, 9)));
    }
    
    // add baddie 1/2 of the time
    if (randChance < 1){
      baddies.add (new Baddie (baddiePos, new SpriteTimer (50), baddieSprites, 2));
      occupied[int (baddiePos.x)][int (baddiePos.y)] = 1;
    }
    
    // add dragon 1/2 of the time
    else {
      Dragon tempDrag = new Dragon (baddiePos, baddiePos, new SpriteTimer (50), dragonSprites, 2, fireSprite, 1);
      occupied[int (baddiePos.x)][int (baddiePos.y)] = 1;
      
      // place fire
      PVector firePos = tempDrag.test_fire();
      while (!is_empty (firePos)){
        firePos = tempDrag.test_fire();
      }
      tempDrag.firePos = firePos;
      dragons.add (tempDrag);
      occupied[int (firePos.x)][int (firePos.y)] = 1;
    }
  }
  
  // move baddies/dragons around board
  void move_baddies(){
    
    // move baddies
    for (int i = 0; i < baddies.size(); i++){
      Baddie temp = baddies.get (i);
      
      // stay still if surrounded
      if (is_surrounded (temp.pos)){
        continue;
      }
      occupied[int (temp.pos.x)][int (temp.pos.y)] = 0;
      PVector tempPos = temp.test_move();
      
      // do not move baddie to occupied square
      while (!is_empty (tempPos)){
        tempPos = temp.test_move();
      }
      temp.pos = tempPos;
      occupied[int (temp.pos.x)][int (temp.pos.y)] = 1;
      baddies.set (i, temp);
    }
    
    // move dragons
    for (int i = 0; i < dragons.size(); i++){
      Dragon temp = dragons.get (i);
      occupied[int (temp.firePos.x)][int (temp.firePos.y)] = 0;
      
      // stay still if surrounded
      if (is_surrounded (temp.pos)){
        occupied[int (temp.firePos.x)][int (temp.firePos.y)] = 1;
        continue;
      }
      occupied[int (temp.pos.x)][int (temp.pos.y)] = 0;
      PVector tempPos = temp.test_move();
      
      // do not move dragon to occupied square
      while (!is_empty (tempPos)){
        tempPos = temp.test_move();
      }
      temp.pos = tempPos;
      occupied[int (temp.pos.x)][int (temp.pos.y)] = 1;
      
      // move fire to empty square adjacent to new dragon position
      PVector firePos = temp.test_fire();
      while (!is_empty (firePos)){
        firePos = temp.test_fire();
      }
      temp.firePos = firePos;
      dragons.set (i, temp);
    }
    check_collision();
  }
  
  // move all dragon fires on beat
  void move_fires(){
    for (int i = 0; i < dragons.size(); i++){
      Dragon temp = dragons.get (i);
      occupied[int (temp.firePos.x)][int (temp.firePos.y)] = 0;
      PVector tempFire = temp.test_fire();
      
      // move fire to empty square
      while (!is_empty (tempFire)){
        tempFire = temp.test_fire();
      }
      temp.firePos = tempFire;
      occupied[int (tempFire.x)][int (tempFire.y)] = 1;
      dragons.set (i, temp);
    }
  }
  
  // check if any of the baddies/dragons have collided with hero
  // if collisions occurs, decrease health and animate
  void check_collision(){
    
    // check for baddie collisions
    for (int i = 0; i < baddies.size(); i++){
      Baddie temp = baddies.get (i);
      
      // if collision, remove baddie
      if (hero.pos.x == temp.pos.x && hero.pos.y == temp.pos.y){
        hero.health -= 5;
        baddies.remove (i);
        return;
      }
    }
    
    // check for dragon collisions
    for (int i = 0; i < dragons.size(); i++){
      Dragon temp = dragons.get (i);
      
      // if collision, remove dragon
      if (hero.pos.x == temp.pos.x && hero.pos.y == temp.pos.y){
        hero.health -= 5;
        dragons.remove (i);
        return;
      }
      
      // if collision is with fire, do not remove dragon
      if (hero.pos.x == temp.firePos.x && hero.pos.y == temp.firePos.y){
        hero.health -= 5;
        return;
      }
    }
  }
  
  // remove baddies/dragons based on attack key and update score
  void remove_baddies (char attackKey){
    PVector dir = new PVector (0, 0);
    if (attackKey == 'A'){
      dir.x = -1;
    }
    else if (attackKey == 'D'){
      dir.x = 1;
    }
    else if (attackKey == 'W'){
      dir.y = -1;
    }
    else {
      dir.y = 1;
    }
    
    // remove baddie or dragon if in attack space
    for (int i = 0; i < baddies.size(); i++){
      Baddie temp = baddies.get (i);
      if (temp.pos.x == hero.pos.x + dir.x && temp.pos.y == hero.pos.y + dir.y){
        baddies.remove (i);
        score +=5;
        return;
      }
    }
    for (int i = 0; i < dragons.size(); i++){
      Dragon temp = dragons.get (i);
      if (temp.pos.x == hero.pos.x + dir.x && temp.pos.y == hero.pos.y + dir.y){
        dragons.remove (i);
        score += 5;
        return;
      }
    }
  }
}