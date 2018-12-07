// make home screen Welcome to _____
//buttons: instructions, start, highscores, sound toggle
class Button {
  PVector origin;
  float butWidth;
  float butHeight;
  PFont myFont;
  color base = color(1, 106, 80), hover = color(255, 0, 0), buttonColor = base, infoColor = base, hsColor = base;
  
  Button (PVector origin) {
    this.origin = origin;
    if (this.origin.y == 40){
      this.butWidth = 130;
      this.butHeight = 40;
    }else{
      this.butWidth = 300;
      this.butHeight = 75;
    }
  }
  
  boolean clicked() {
    if (mousePressed && mouseX > this.origin.x - (this.butWidth/2) && //
      mouseX < this.origin.x + (this.butWidth/2)//
      && mouseY > this.origin.y - (this.butHeight/2) && //
      mouseY < this.origin.y + (this.butHeight/2)){
      return(true);
    }
    else {
      return(false);
    }
  }
  
  boolean overButton(){
    if (mouseX > this.origin.x - (this.butWidth/2) && //
      mouseX < this.origin.x + (this.butWidth/2)//
      && mouseY > this.origin.y - (this.butHeight/2) && //
      mouseY < this.origin.y + (this.butHeight/2)){
      return(true);
    }
    else {
      return(false);
    }
  }
  
  void display() {
    if (overButton()){
      buttonColor = hover;
    }else{
      buttonColor = base;
    }
    fill(buttonColor);
    rectMode(CENTER);
    rect(this.origin.x, this.origin.y, this.butWidth, this.butHeight);
  }
}