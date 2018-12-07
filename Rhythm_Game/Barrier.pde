class Barrier {
  PVector pos;
  
  Barrier (PVector _pos){
    pos = _pos;
  }
  
  void display(){
    fill (139, 69, 19);
    rect ((pos.x * 50) + 175, (pos.y * 50) + 125, 50, 50);
  }
}