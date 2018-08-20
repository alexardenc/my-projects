class Shapes {
  float xPos = random(50, 1151), yPos = 0, yBot;
  int shapeCode;
  
  Shapes (int shapeCode){
    this.shapeCode = shapeCode;
    this.yBot = this.yPos + 50;
  }
  
  void display(){
    if (this.shapeCode == 1) {
      fill (255, 0, 0);
      triangle (this.xPos, this.yPos, this.xPos - 25, this.yPos + 50, 
                this.xPos + 25, this.yPos + 50);
    } else if (this.shapeCode == 2) {
      fill (0, 255, 0);
      ellipse (this.xPos, this.yPos +15, 50, 50);
   } else if (this.shapeCode == 3) {
      fill (0, 0, 255);
      rect (this.xPos - 25, this.yPos, 50, 50);
    }
  }
  
  void move(){
    // make em fall 
    this.yPos += 1.5;
    this.yBot += 1.5;
  }
}