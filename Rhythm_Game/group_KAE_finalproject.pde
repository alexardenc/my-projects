import processing.sound.*;

// GUI variables
Icon icon;
Button start;
Button info;
Button scores;
Button home;
Button exit;
Button quit;
Healthbar healthbar;
PImage note1, note2;
PFont myFont;
boolean infoPressed = false;
boolean scoresPressed = false;
boolean homePressed = true;
boolean finishScreen = false;
boolean failed = false;
int health = 100;

// game variables
Board board;
Timer timer;
SoundFile beneath;
SoundFile funky;
SoundFile tighten;
SoundFile cow;
SoundFile song;
boolean newGame = true;
boolean firstPress = false;
boolean attackActive = false;
boolean resetActive = false;
boolean muteActive = false;
int baddieCounter = 1;
int attackCounter = 0;
int resetCounter = 0;
int level = 3;

// Make the variable for the Score table.
Table scoreTable1;
String[] tableLines;
String playerName = "";

// Make the PImage lists of the baddie and dragon sprites.
PImage[] baddieSprites = new PImage[2];
PImage[] dragonSprites = new PImage[2];
PImage[] fireSprite = new PImage[1];

void setup() {
  size (1000, 700);
  
  // load in the sprite images for monster and baddie
  for (int i = 0; i < 2; i++) {
    baddieSprites[i] = loadImage ("monster-" + nf(i + 1) + ".png");
    baddieSprites[i].resize (50, 50);
  }
  for (int i = 0; i < 2; i++) {
    dragonSprites[i] = loadImage ("dragon-" + nf(i + 1) + ".png");
    dragonSprites[i].resize (50, 50);
  }
  for (int i = 0; i < 1; i++) {
    fireSprite[i] = loadImage ("fire-" + nf(i + 1) + ".png");
    fireSprite[i].resize (50, 50);
  }
  
  // GUI initialization
  note1 = loadImage ("note.png");
  note1.resize(50, 50);
  note2 = loadImage ("eighth.png");
  note2.resize(50, 50);
  
  icon = new Icon(new PVector(100, 550), note1);
  exit = new Button (new PVector (75, 40));
  exit.origin = new PVector (900, 40);
  healthbar = new Healthbar();
  start = new Button(new PVector(500, 390));
  info = new Button(new PVector(500, 290));
  scores = new Button(new PVector(500, 190));
  quit = new Button(new PVector(500, 490));
  home = new Button(new PVector(75, 40));
  myFont = createFont("CopperplateGothic-Light-48", 32);
  textFont(myFont);
  // beneath tempo is 449.25;
  // funky tempo is 495;
  funky = new SoundFile(this, "Let's Get Funky.mp3");
  tighten = new SoundFile(this, "Tighten Up.mp3");
  cow = new SoundFile(this, "cow.wav");
  tighten.cue(2);
  tighten.loop();
  
  // Load in the player scores for What Lies Beneath.
  scoreTable1 = loadTable("playerScores1.csv", "header");
  tableLines = loadStrings("playerScores1.csv");
}

void draw() {
  background (39, 1, 106);
  fill (0);
  
  // home screen
  if (homePressed){
    display_home();
  }
  else if (infoPressed){
    display_info();
  }
  else if (scoresPressed){
    display_scores();
  }
  else if (finishScreen) {
    // Note that user input is suspended while this is active. But if the user
    // happened to be near a dragon, the fire could be on the same square.
    // NOTE: The above concern is actually not possible, since the baddie, fire,
    // and dragon movement only happens in when timer.advanceBoard() is true,
    // which only happens in the last else statement (finishScreen = false there.
    display_finish();
    display_input();
  }
  else if (failed) {
    display_failed();
    display_input();
    song.stop();
  }
  else {
    if (newGame){
      init_game (funky, funky.duration() * 1000, level, 495, 150, color (255, 230, 167), color (167, 196, 255));
      newGame = false;
      tighten.stop();
    }
    
    if (timer.songOver()) {
      finishScreen = true;
    }
    
    if (healthbar.checkHealth()){
      failed = true;
    }

    // Note that until the first key Press triggers the timer, timer.toggleActive()
    // does nothing. Look at the method in the timer class to see.
    timer.toggleActive();
  
    // advance board on beat
    if (timer.advanceBoard()) {
      board.switch_colors();
      
      // after attack, wait 3 beats until activating attack again
      if (!attackActive && attackCounter < 2){
        attackCounter ++;
      }
      else if (!attackActive && attackCounter == 2){
        attackCounter = 0;
        attackActive = true;
      }
      
      if (!resetActive && resetCounter < 31){
        resetCounter ++;
      }
      else if (!resetActive && resetCounter == 31){
        resetCounter = 0;
        resetActive = true;
      }
      
      // move dragon fires every other beat
      if (baddieCounter % 2 == 0){
        board.move_fires();
      }
      
      // add baddie every 10th beat
      if (baddieCounter % 8 == 0){
        board.add_baddie();
      }
      
      // move baddies every 5th beat
      if (baddieCounter % 4 == 0){
        board.move_baddies();
      }
      baddieCounter ++;
    }
    board.display();
    
    // display attack active signal
    if (attackActive){
      strokeWeight (3);
      stroke (255);
      fill (255);
      ellipse (width / 2, 640, 75, 75);
    }
    else {
      strokeWeight (3);
      stroke (255);
      fill (178, 34, 34);
      ellipse (width / 2, 640, 75, 75);
    }
    noStroke();
    fill (178, 34, 34);
    textSize (25);
    textAlign (LEFT);
    text ("Inactive", 330, 650);
    fill (255);
    text ("Active", 560, 650);
    
    // display in game GUI
    // Make a healthbar method to call for this line.
    healthbar.rectWidth = board.hero.health * 2;
    healthbar.display();
    fill (255);
    textSize (20);
    textAlign (LEFT);
    fill(255);
    textSize(50);
    textAlign (CENTER);
    text("Baddie Boogie", 500, 70);
    textSize (30);
    text ("Score: ", 910, 300);
    text (board.score, 910, 330);

    // display controls
    rectMode(CENTER);
    textSize(20);
    text("Attack keys:", 75, 210);
    rect(85, 240, 40, 40, 5);
    rect(85, 283, 40, 40, 5);
    rect(42, 283, 40, 40, 5);
    rect(128, 283, 40, 40, 5);
    text("Move keys:", 65, 330);
    rect(85, 360, 40, 40, 5);
    rect(85, 403, 40, 40, 5);
    rect(42, 403, 40, 40, 5);
    rect(128, 403, 40, 40, 5);
    text("Mute:", 38, 450);
    rect(85, 480, 40, 40, 5);
    
    fill(39, 1, 106);
    text("M", 85, 485);
    text("W", 85, 245);
    text("S", 85, 288);
    text("A", 42, 288);
    text("D", 128, 288);
    textSize(30);
    text("^", 85, 368);
    textSize(20);
    text("v", 85, 413);
    text("<", 42, 410);
    text(">", 128, 410);
    
    // exit button
    // Find a way to only create one exit button in setup rather than creating new
    // ones every draw loop.
    exit.display();
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text ("Exit", 900, 50);
    displayReset();
  }
}

void keyPressed() {
  
  // start timer and activate attack on first key press
  // User input is suspended on home, info, score, finish, and defeat screens.
  if (keyCode == 'M' && newGame) {
    if (muteActive) {
      tighten.amp(1);
      cow.amp(1);
      muteActive = false;
    }
    else {
      tighten.amp(0);
      cow.amp(0);
      muteActive = true;
    }
  }
  else if (!homePressed && !infoPressed && !scoresPressed && !finishScreen && !failed) {
    if (!firstPress) {
      timer.startTimer();
      firstPress = true;
      attackActive = true;
    }
    
    // if attack is active, attack in the corresponding direction
    // attack keys are as follows: A - left, D - right, W - up, S - down
    // after attack, disable attack
    if (attackActive && keyCode == 'A'){
      attackActive = false;
      board.remove_baddies ('A');
    }
    else if (attackActive && keyCode == 'D'){
      attackActive = false;
      board.remove_baddies ('D');
    }
    else if (attackActive && keyCode == 'W'){
      attackActive = false;
      board.remove_baddies ('W');
    }
    else if (attackActive && keyCode == 'S'){
      attackActive = false;
      board.remove_baddies ('S');
    }
    
    else if (resetActive && key == ' ') {
      resetActive = false;
      timer.startTimer();
    }
    
    // Press 'M' to mute the sounds of the game.
    else if (keyCode == 'M') {
      if (muteActive) {
        song.amp(1);
        tighten.amp(1);
        cow.amp(1);
        muteActive = false;
      }
      else {
        song.amp(0);
        tighten.amp(0);
        cow.amp(0);
        muteActive = true;
      }
    }
    
    // for each movement key press, check if hero is at edge of board or running into a barrier/baddie
    // also for each key press, check if the move is on beat, decrease health if off beat
    else if (keyCode == RIGHT) {
      PVector next = new PVector (board.hero.pos.x + 1, board.hero.pos.y);
      if (next.x <= 12 && !board.is_barrier (next)){
        board.hero.moveRight();
      }
      if (!timer.getIsActive()) {
        board.hero.health --;
      }
      board.check_collision();
    }
    else if (keyCode == LEFT) {
      PVector next = new PVector (board.hero.pos.x - 1, board.hero.pos.y);
      if (next.x >= 0 && !board.is_barrier (next)){
        board.hero.moveLeft();
      }
      if (!timer.getIsActive()) {
        board.hero.health --;
      }
      board.check_collision();
    }
    else if (keyCode == DOWN) {
      PVector next = new PVector (board.hero.pos.x, board.hero.pos.y + 1);
      if (next.y <= 8 && !board.is_barrier (next)){
        board.hero.moveDown();
      }
      if (!timer.getIsActive()) {
        board.hero.health --;
      }
      board.check_collision();
    }
    else if (keyCode == UP) {
      PVector next = new PVector (board.hero.pos.x, board.hero.pos.y - 1);
      if (next.y >= 0 && !board.is_barrier (next)){
        board.hero.moveUp();
      }
      if (!timer.getIsActive()) {
        board.hero.health --;
      }
      board.check_collision();
    }
  }
  else if (finishScreen || failed) {
    if (Character.isLetter(key) || Character.isDigit(key)) {
      if (playerName.length() <= 12) {
        playerName += key;
      }
    }
    if (keyCode == ENTER || keyCode == RETURN) {
      String beforeLines = "";
      String afterLines = "";
      String[] newCSVLines;
      for (int i = 1; i < tableLines.length; i++) {
        int commaIndex = tableLines[i].indexOf(",");
        int currentScore = Integer.parseInt(tableLines[i].substring(commaIndex + 1, tableLines[i].length()));
        String newRow = playerName + "," + Integer.toString(board.getScore()) + "\n";
        if (board.getScore() >= currentScore) {
          for (int j = i; j < tableLines.length; j++) {
            afterLines = afterLines + tableLines[j] + "\n";
          }
          // Remember to add in the player, score columns we skipped by starting at i = 1;
          String newCSV = tableLines[0] + "\n" + beforeLines + newRow + afterLines;
          newCSVLines = newCSV.split("\n");
          saveStrings("playerScores1.csv", newCSVLines);
          break;
        }
        else {
          if (i == tableLines.length - 1) {
            beforeLines += tableLines[i] + "\n";
            String newCSV = tableLines[0] + "\n" + beforeLines + newRow;
            newCSVLines = newCSV.split("\n");
            saveStrings("playerScores1.csv", newCSVLines);
          }
          else {
            beforeLines += tableLines[i] + "\n";
          }
        }
      }
      playerName = "";
      finishScreen = false;
      failed = false;
      scoresPressed = true;
      homePressed = false;
      infoPressed = false;
      newGame = true;
      firstPress = false;
      resetActive = false;
      attackActive = true;
      healthbar.reset();
      song.stop ();
      tighten.loop();
      scoreTable1 = loadTable("playerScores1.csv", "header");
    }
    else if (keyCode == BACKSPACE && (playerName.length() > 0)) {
      playerName = playerName.substring(0, playerName.length() - 1);
    }
  }
}

void mousePressed() {
  if (homePressed) {
    if (start.overButton()){
      cow.play();
      homePressed = false;
    }
    else if (info.overButton()){
      cow.play();
      infoPressed = true;
      homePressed = false;
    }
    else if (scores.overButton()){
      cow.play();
      scoresPressed = true;
      homePressed = false;
    }
    else if (quit.overButton()){
      cow.play();
      exit();
    }
  }
  else if (infoPressed || scoresPressed) {
    if (home.overButton()){
      cow.play();
      homePressed = true;
      infoPressed = false;
      scoresPressed = false;
    }
  }
  else if (!homePressed && !infoPressed && !scoresPressed && !finishScreen && !failed) {
    if (exit.overButton()){
      homePressed = true;
      infoPressed = false;
      scoresPressed = false;
      newGame = true;
      firstPress = false;
      resetActive = false;
      attackActive = true;
      healthbar.reset();
      song.stop ();
      cow.play();
      tighten.play();
    }
  }
}


// display home screen
void display_home(){
  start.display();
  info.display();
  scores.display();
  quit.display();
  
  // animation
  icon.display();
  image (note1, 50, 100);
  image (note2, 100, 200);
  image (note1, 900, 100);
  image (note2, 850, 200);
  icon.display();
  icon.move();
  
  myFont = loadFont("CopperplateGothic-Light-48.vlw");
  textFont(myFont);
  textSize(50);
  fill(255);
  textAlign(CENTER);
  text("Welcome to Baddie Boogie", 500, 100);
  textSize(30);
  text("START", 500, 400);
  text("How to play", 500, 300);
  text("Highscores", 500, 200);
  text("Quit", 500, 500);
}

void display_info(){
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("This is how you play the game:", 500, 150);
  textSize(20);
  text(" - Use the arrow keys to move with the beat", 500, 200);
  text(" - Press A to attack LEFT", 500, 250);
  text(" - Press D to attack RIGHT", 500, 300);
  text(" - Press W to attack UP", 500, 350);
  text(" - Press S to attack DOWN", 500, 400);
  text(" - Touch a baddie or dragon lose 5 health points", 500, 450);
  text(" - Touch a dragon's fire lose 1 health point", 500, 500);
  text(" - Move off beat lose 1 health point", 500, 550);
  text(" - Press SPACE on the downbeat to reset the beat if you lose health " +//
  "despite being on beat", 500, 600);
  text(" - Press M to mute the sound", 500, 650);
  home.display();
  fill(255);
  textSize(20);
  text("Main Menu", 75, 45);
}

void display_scores(){
  fill(255);
  textSize(40);
  text("Top scores", 500, 150);
  textSize(30);
  text("Player Name", 400, 240);
  text("Score", 630, 240);
  textSize(20);
  textAlign(LEFT);
  int rowCount = 0;
  float rowY = 300;
  for (TableRow row: scoreTable1.rows()) {
    if (rowCount <= 8) {
      int score = row.getInt("Score");
      String name = row.getString("Player");
      text(name, 370, rowY);
      text(score, 615, rowY);
      rowY += 40;
      rowCount += 1;
    }
    else {
      rowY = 300;
      rowCount = 0;
      break;
    }
  }
  home.display();
  fill(255);
  textAlign(CENTER);
  textSize(20);
  text("Main Menu", 75, 45);
}

void display_finish() {
  fill(255);
  textSize(40);
  text("You completed the song!", 500, 150);
}

void display_failed() {
  fill(255);
  textSize(40);
  text("You failed!", 500, 150);
}

void display_input() {
  textSize(30);
  text("Enter your name in the box below:", 500, 250);
  rectMode(CENTER);
  textSize(30);
  rect(500, 350, 270, 60);
  fill(0);
  text(playerName, 500, 360);
}
  

void init_game (SoundFile newSong, float songLength, int level, float interval, int cushion, color color1, color color2){
  timer = new Timer (interval, cushion, songLength);
  song = newSong;
  song.play();
  song.amp(1);
  board = new Board (level, color1, color2, baddieSprites, dragonSprites, fireSprite);
}

void displayReset() {
  if (resetActive) {
    fill (255);
    rectMode(CORNER);
    rect(700, 630, 200, 30);
    fill(#FCFC03);
    textSize(30);
    text("Reset Beat!", 800, 620); 
  }
  else {
    fill(255);
    rectMode(CORNER);
    rect(700, 630, 200, 30);
    fill (178, 34, 34);
    rect(703, 633, 194, 24);
  }
}
    