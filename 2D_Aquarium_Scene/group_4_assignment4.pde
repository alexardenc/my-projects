import processing.sound.*;
SoundFile noise;

Fish nemo;
Fish stretch;
Crab crab1;
Crab crab2;
Crab crab3;
Dolphin dolphin1, dolphin2;
color blueGrey;

void setup() {
  size(1000, 800);

  noise = new SoundFile(this, "water.mp3");
  noise.play();

  crab1 = new Crab(4, 200, 500, color(200, 75, 30));
  crab2 = new Crab(2, 500, 500, color(100, 20, 150));
  crab3 = new Crab(6, 200, 500, color(50, 150, 50));
  nemo = new Fish(100, 300, color (#FCA233));
  stretch = new Fish(-700, 600, color (#EBFF12));
  blueGrey = color (146, 153, 193);
  dolphin1 = new Dolphin (0, 100, blueGrey, 5);
  dolphin2 = new Dolphin (0, 175, 225, 3);

}

void draw() {
  fill(#F5D34D);
  background(#2F99E8);
  rect(-10, 600, 1010, 200);
  
  crab1.move();
  crab1.display();
  crab2.move();
  crab2.display();
  crab3.move();
  crab3.display();
  
  nemo.displayTail();
  nemo.display();
  nemo.move();
  pushMatrix();
  scale(-1.6, .7);
  stretch.displayTail();
  stretch.display();
  stretch.move();
  popMatrix();
  
  dolphin1.display ();
  dolphin2.display ();
}