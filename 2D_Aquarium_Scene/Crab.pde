class Crab {
  float speed;
  float xPos;
  float yPos;
  float yPosIn;
  float yPosOut;
  float moveCounter;
  boolean moveRight;
  color crabColor;
  color outlineColor;
  float tempBright;
  PShape crabImage;
  PShape inLegGroup;
  PShape outLegGroup;
  float legDiff = 30;
  
  // Create the individual pieces of the crab's body.
  PShape body;
  PShape leftmostLeg;
  PShape nextLeftLeg;
  PShape rightmostLeg;
  PShape nextRightLeg;
  PShape armLeft;
  PShape armRight;
  PShape eyeStalkLeft;
  PShape eyeStalkRight;
  PShape eyeLeft;
  PShape eyeRight;
  PShape pupilLeft;
  PShape pupilRight;
  PShape clawBotLeft;
  PShape clawBotRight;
  PShape clawTopLeft;
  PShape clawTopRight;
  
  
  // Define the points for the left leg. We will simply translate
  // these with the x-coordinate to create the second left leg.
  PVector leftLeg1 = new PVector(-190, 150);
  PVector leftLeg2 = new PVector(-260, 200);
  PVector leftLeg3 = new PVector(-260, 280);
  PVector leftLeg4 = new PVector(-240, 200);
  PVector leftLeg5 = new PVector(-170, 150);
  PVector leftLeg6 = new PVector(-190, 150);
  
  // Define the points for the right leg. We will simply translate
  // these with the x-coordinate to create the second left leg.
  PVector rightLeg1 = new PVector(-110, 150);
  PVector rightLeg2 = new PVector(-40, 200);
  PVector rightLeg3 = new PVector(-40, 280);
  PVector rightLeg4 = new PVector(-60, 200);
  PVector rightLeg5 = new PVector(-130, 150);
  PVector rightLeg6 = new PVector(-110, 150);
  
  // The constructor function.
  Crab(float speed, float x, float y, color c) {
    this.speed = speed;
    this.xPos = x;
    this.yPos = y;
    this.yPosIn = y;
    this.yPosOut = y;
    this.moveRight = true;
    this.crabColor = c;
    fill(crabColor);
    // get the stroke color from the fill color.
    colorMode(HSB);
    this.tempBright = brightness(crabColor) - 100;
    constrain(this.tempBright, 0, 255);
    outlineColor = color(hue(crabColor), saturation(crabColor), tempBright);
    stroke(outlineColor);
    strokeWeight(3);
    colorMode(RGB);
    
    this.body = createShape();
    this.leftmostLeg = createShape();
    this.nextLeftLeg = createShape();
    this.rightmostLeg = createShape();
    this.nextRightLeg = createShape();
    this.armLeft = createShape();
    this.armRight = createShape();
    this.clawBotLeft = createShape();
    this.clawBotRight = createShape();
    
    // Assemble the crab's crabImage
    this.leftmostLeg.beginShape();
    this.leftmostLeg.vertex(leftLeg1.x, leftLeg1.y);
    this.leftmostLeg.vertex(leftLeg2.x, leftLeg2.y);
    this.leftmostLeg.vertex(leftLeg3.x, leftLeg3.y);
    this.leftmostLeg.vertex(leftLeg4.x, leftLeg4.y);
    this.leftmostLeg.vertex(leftLeg5.x, leftLeg5.y);
    this.leftmostLeg.vertex(leftLeg6.x, leftLeg6.y);
    this.leftmostLeg.endShape();
    
    this.nextLeftLeg.beginShape();
    this.nextLeftLeg.vertex(leftLeg1.x - legDiff, leftLeg1.y);
    this.nextLeftLeg.vertex(leftLeg2.x - legDiff, leftLeg2.y);
    this.nextLeftLeg.vertex(leftLeg3.x - legDiff, leftLeg3.y);
    this.nextLeftLeg.vertex(leftLeg4.x - legDiff, leftLeg4.y);
    this.nextLeftLeg.vertex(leftLeg5.x - legDiff, leftLeg5.y);
    this.nextLeftLeg.vertex(leftLeg6.x - legDiff, leftLeg6.y);
    this.nextLeftLeg.endShape();
    
    this.rightmostLeg.beginShape();
    this.rightmostLeg.vertex(rightLeg1.x, rightLeg1.y);
    this.rightmostLeg.vertex(rightLeg2.x, rightLeg2.y);
    this.rightmostLeg.vertex(rightLeg3.x, rightLeg3.y);
    this.rightmostLeg.vertex(rightLeg4.x, rightLeg4.y);
    this.rightmostLeg.vertex(rightLeg5.x, rightLeg5.y);
    this.rightmostLeg.vertex(rightLeg6.x, rightLeg6.y);
    this.rightmostLeg.endShape();
    
    this.nextRightLeg.beginShape();
    this.nextRightLeg.vertex(rightLeg1.x + legDiff, rightLeg1.y);
    this.nextRightLeg.vertex(rightLeg2.x + legDiff, rightLeg2.y);
    this.nextRightLeg.vertex(rightLeg3.x + legDiff, rightLeg3.y);
    this.nextRightLeg.vertex(rightLeg4.x + legDiff, rightLeg4.y);
    this.nextRightLeg.vertex(rightLeg5.x + legDiff, rightLeg5.y);
    this.nextRightLeg.vertex(rightLeg6.x + legDiff, rightLeg6.y);
    this.nextRightLeg.endShape();
    
    // Create the body
    this.body = createShape(ELLIPSE, -150, 150, 180, 120);
    
    // Create the eye stalks
    this.eyeStalkLeft = createShape(RECT, -170, 40, 10, 75);
    this.eyeStalkRight = createShape(RECT, -140, 40, 10, 75);
    
    // Create the eyes
    stroke(0);
    fill(255);
    this.eyeLeft = createShape(ELLIPSE, -165, 40, 20, 20);
    this.eyeRight = createShape(ELLIPSE, -135, 40, 20, 20);
    fill(0);
    this.pupilLeft = createShape(ELLIPSE, -165, 40, 5, 5);
    this.pupilRight = createShape(ELLIPSE, -135, 40, 5, 5);
    fill(crabColor);
    stroke(outlineColor);
    
    // Make the crab arms.
    this.armLeft = createShape(RECT, -215, 20, 12, 100);
    this.armLeft.translate(-88, -90);
    this.armLeft.rotate(-PI / 6);
    this.armRight = createShape(RECT, -97, 20, 12, 100);
    this.armRight.translate(50, 60);
    this.armRight.rotate(PI / 6);
    
    // Make the claws.
    this.clawBotLeft = createShape(ARC, -250, 20, 60, 30, 0, PI, CHORD);
    this.clawBotRight = createShape(ARC, -50, 20, 60, 30, 0, PI, CHORD);
    ellipseMode(CORNER);
    this.clawTopLeft = createShape(ARC, -290, -35, 30, 60, PI / 2, 3 * PI / 2, CHORD);
    this.clawTopRight = createShape(ARC, -35, -35, 30, 60, - PI / 2, PI / 2, CHORD);
    ellipseMode(CENTER);
   
    
    // Here, we assemble the PShapes for the leg groups and the main body of the crab
    
    this.inLegGroup = createShape(GROUP);
    this.inLegGroup.addChild(this.leftmostLeg);
    this.inLegGroup.addChild(this.rightmostLeg);
    
    this.outLegGroup = createShape(GROUP);
    this.outLegGroup.addChild(this.nextLeftLeg);
    this.outLegGroup.addChild(this.nextRightLeg);
    
    this.crabImage = createShape(GROUP);
    this.crabImage.addChild(this.body);
    this.crabImage.addChild(this.eyeStalkLeft);
    this.crabImage.addChild(this.eyeStalkRight);
    this.crabImage.addChild(this.eyeLeft);
    this.crabImage.addChild(this.eyeRight);
    this.crabImage.addChild(this.pupilLeft);
    this.crabImage.addChild(this.pupilRight);
    this.crabImage.addChild(this.armLeft);
    this.crabImage.addChild(this.armRight);
    this.crabImage.addChild(this.clawBotLeft);
    this.crabImage.addChild(this.clawBotRight);
    this.crabImage.addChild(this.clawTopLeft);
    this.crabImage.addChild(this.clawTopRight);
    
    // Scale the final image
    this.crabImage.scale(.5);
    this.inLegGroup.scale(.5);
    this.outLegGroup.scale(.5);
    
  }
  
  void move() {
    if (this.crabImage.width + this.xPos > 900) {
      this.moveRight = false;
    }
    if (this.xPos < 200) {
      this.moveRight = true;
    }
    // This below statement is just to reset the counter so it doesn't grow
    // uncontrollably.
    if (this.moveCounter == 12) {
      this.moveCounter = 0;
    }
    if (this.moveCounter % 12 < 6) {
      this.yPosIn -= 2;
      this.yPosOut += 2;
      this.moveCounter += 1;
    }
    if (this.moveCounter % 12 >= 6) {
      this.yPosIn += 2;
      this.yPosOut -= 2;
      this.moveCounter += 1;
    }
    if (this.moveRight == true) {
      this.xPos += speed;
    }
    else {
      this.xPos -= speed;
    }
  }
  
  void display() {
    shape(this.inLegGroup, this.xPos, this.yPosIn);
    shape(this.outLegGroup, this.xPos, this.yPosOut);
    shape(this.crabImage, this.xPos, this.yPos);
  }
  
  
}