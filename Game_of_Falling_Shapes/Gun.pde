class Gun {
  PVector gunPos, bulVec;
  ArrayList <Bullet> bullets;
  boolean canFire;
  
  Gun (PVector gunPos, PVector bulVec){
    this.gunPos = gunPos;
    this.bulVec = bulVec;
    this.canFire = true;
    this.bullets = new ArrayList <Bullet> ();
  }
  
  void empty() {
    this.canFire = false;
  }
  
  void reload() {
    this.canFire = true;
  }
  
  void add_bullet (int shapeCode){
    if (this.canFire) {
      bullets.add (new Bullet (this.gunPos, shapeCode));
    }
  }
  
  void shoot (PVector newPos){
    this.gunPos = newPos;
    for (int i = bullets.size() - 1; i >= 0; i --){
      Bullet bullet = bullets.get (i);
      bullet.move (bulVec);
      bullet.display();
      if (bullet.bottom.y < 0){
        bullets.remove (i);
      }
    }
  }
}