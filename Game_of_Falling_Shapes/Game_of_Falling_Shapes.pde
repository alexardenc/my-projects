Gun gun;
Timer timer;
Timer bulletTimer;
Hero hero;
Healthbar healthbar;
Restart restart;
Start start;
int shapeCode;
float gunHeight = 50;
boolean[] move = new boolean[2];
ArrayList <Shapes> allShapes;
int frame = 0;
int score = 0;
int health = 100;
Boolean begin = false;


void setup (){
  size (1200, 700);
  healthbar = new Healthbar();
  bulletTimer = new Timer(300);
  restart = new Restart(500, 400);
  start = new Start();
  gun = new Gun (new PVector (width / 2, height), new PVector (0, -5));
  timer = new Timer(75);
  hero = new Hero(new PVector(500, 570), timer);
  move[0] = false;
  move[1] = false;
  allShapes = new ArrayList<Shapes>();
}

void draw (){
  frame += 1;

  background (240, 248, 255);
  fill (#B78E43);
  rect (0, 620, 1200, 100);
  
  if (begin == false){
    start.display();
    if (start.clicked()) {
      begin = true;
    }
  }else{
  
    if (move[0]) {
      hero.moveForward();
    }
    else if (move[1]) {
      hero.moveBack();
    }
    
    gun.shoot (new PVector (hero.position.x + 25, hero.position.y - gunHeight + 35));
    hero.advance();
    hero.display();
    
    is_contact();
    
    add_shape(frame);
    // for item in allShapes - item.display
    for (int i = 0; i < allShapes.size(); i++) {
      Shapes shape = allShapes.get(i);
      shape.display();
      shape.move();
      if (shape.yPos > 725){
        allShapes.remove (i);
      }
    }
    
    healthbar.display();
    
    // checking health for restart
    if (healthbar.checkHealth()) {
      textSize(100);
      fill(0);
      text("You Failed!", 350, 350);
      restart.display();
      if (restart.clicked()) {
        healthbar.resetHealth();
        score = 0;
        allShapes = new ArrayList<Shapes>();
      }  
    }
    else if (score == 25) {
      textSize(100);
      fill(0);
      text("You Win!", 400, 350);
      restart.display();
      if (restart.clicked()) {
        healthbar.resetHealth();
        score = 0;
        allShapes = new ArrayList<Shapes>();
      }
    }
      
    
    // test score/damage display
    String scoreString = "Score: " + str (score) + "/25";
    fill (0);
    textSize (30);
    text (scoreString, 10, 40);
  }
}

void keyPressed() {
  if (key == 'l') {
    if (hero.position.x >= 1100) {
      move[0] = false;
    } else{
      move[0] = true;
    }
  } else if (key == 'j') {
    if (hero.position.x <= 40) {
      move[1] = false;
    } else{
      move[1] = true;
    }
  } if (key == '1'){
    gun.add_bullet(1);
    gun.empty();
  } else if (key == '2'){
    gun.add_bullet(2);
    gun.empty();
  } else if (key == '3'){
    gun.add_bullet(3);
    gun.empty();
  }
}

void keyReleased() {
  if (key == 'l') {
    move[0] = false;
  } else if (key == 'j') {
    move[1] = false;
  } if (key == '1'){
    gun.reload();
  } else if (key == '2'){
    gun.reload();
  } else if (key == '3'){
    gun.reload();
  }
}

void add_shape(int frame){
  shapeCode = int(random(1,4));

  if (frame % 100 == 0){
    allShapes.add(new Shapes(shapeCode));
  }
}

void is_contact(){
  for (int i = 0; i < allShapes.size(); i++) {
    Shapes shape = allShapes.get (i);
    for (int j = 0; j < gun.bullets.size(); j++){
      Bullet bullet = gun.bullets.get (j);
      if ((bullet.bottom.y <= shape.yBot) && (abs (bullet.bottom.x - shape.xPos) <= 25)){
        allShapes.remove (i);
        gun.bullets.remove (j);
        if (bullet.shapeCode == shape.shapeCode && !(healthbar.checkHealth()) && !(score == 25)){
          score ++;
        } else if (score != 25) {
          healthbar.lowerHealth();
        }
      }
    }
  }
}