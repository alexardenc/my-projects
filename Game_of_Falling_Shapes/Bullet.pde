class Bullet {
  // shapeCodes are assigned 1 - Triangle, 2 - Circle, 3 - Square
  int shapeCode;
  PVector bottom, top;
  float size = 15;
  
  Bullet (PVector bottom, int shapeCode){
    this.bottom = bottom;
    this.top = new PVector (this.bottom.x, this.bottom.y - size);
    this.shapeCode = shapeCode;
  }
  
  void display(){
    if (shapeCode == 1){
      fill (255, 0, 0);
      triangle (bottom.x, bottom.y, bottom.x - size / 2, bottom.y - size, 
                bottom.x + size / 2, bottom.y - size);
    } else if (shapeCode == 2){
      fill (0, 255, 0);
      ellipse (bottom.x, bottom.y - size / 2, size, size);
    } else if (shapeCode == 3){
      fill (0, 0, 255);
      rect (bottom.x - size / 2, bottom.y - size, size, size);
    }
  }
  
  void move (PVector bulVec){
    this.bottom.add (bulVec);
    this.top.add (bulVec);
  }
}