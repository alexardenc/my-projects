class Healthbar {
  float rectWidth = 75;
  float rectHeight = 40;
  PVector position;
  int health = 3;
  
  Healthbar() {
    this.position = new PVector(965, 650);
  }
  
  void lowerHealth() {
    this.health --;
  }
  
  void display() {
    textSize(30);
    fill(0);
    text("Health: ", 850, 675);
    if (this.health == 3) {
      fill(#0DB702);
      rect(this.position.x, this.position.y, rectWidth, rectHeight);
      rect(this.position.x + rectWidth, this.position.y, rectWidth, rectHeight);
      rect(this.position.x + rectWidth * 2, this.position.y, rectWidth, rectHeight);
    }
    else if (this.health == 2) {
      fill(#0DB702);
      rect(this.position.x, this.position.y, rectWidth, rectHeight);
      rect(this.position.x + rectWidth, this.position.y, rectWidth, rectHeight);
      fill(#C61E00);
      rect(this.position.x + rectWidth * 2, this.position.y, rectWidth, rectHeight);
    }
    else if (this.health == 1) {
      fill(#0DB702);
      rect(this.position.x, this.position.y, rectWidth, rectHeight);
      fill(#C61E00);
      rect(this.position.x + rectWidth, this.position.y, rectWidth, rectHeight);
      rect(this.position.x + rectWidth * 2, this.position.y, rectWidth, rectHeight);
    }
    else if (this.health <= 0) {
      fill(#C61E00);
      rect(this.position.x, this.position.y, rectWidth, rectHeight);
      rect(this.position.x + rectWidth, this.position.y, rectWidth, rectHeight);
      rect(this.position.x + rectWidth * 2, this.position.y, rectWidth, rectHeight);
    }
  }
  
  boolean checkHealth() {
    if (this.health <= 0) {
      return(true);
    }
    else {
      return(false);
    }
  }
  
  void resetHealth() {
    this.health = 3;
  }
      

}