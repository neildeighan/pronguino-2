/**
 * Pronguino
 *
 * Processing Pong with Arduino
 *
 * @author  Neil Deighan
 */

// Import the serial library
import processing.serial.*;

// Declare Serial Port
Serial usbPort;

// Declare Game Options
Options options;

// Declare Game Objects
Net net;
Ball ball;
Scoreboard[] scoreboards;
Player[] players;

/**
 * Setup environment, load options, create game objects, initialise serial communications
 */
void setup() 
{
  // Set Window size in pixels, these are refered to throughout code as "width" and "height" respectively,
  // and all game objects have been coded to be displayed relative to these, so you can have a really short game at 100 x 100,
  // or a really long game at say 1280 x 640, size() can also be replace with fullScreen();
  size(640, 320);

  // "Load" Game Options
  options = new Options();

  // Set Frame Per Second (FPS)
  frameRate(options.framesPerSecond);

  // Create Net
  net = new Net();

  // Create Ball  
  ball = new Ball(options.ballSize, options.ballSpeed);
  ball.positionAtStart();
  ball.directionAtStart();

  // Create Scoreboards 
  float fontSize = options.scoreboardFontSize;
  PFont font = createFont(options.scoreboardFont, fontSize);
  scoreboards = new Scoreboard[Constants.PLAYER_COUNT];
  scoreboards[Constants.PLAYER_ONE] = new Scoreboard(fontSize/2, fontSize, font); 
  scoreboards[Constants.PLAYER_TWO] = new Scoreboard(width-(fontSize*2), fontSize, font);

  // Create Players, each player will create its own paddle and controller
  players = new Player[Constants.PLAYER_COUNT];
  for (int index=0; index < Constants.PLAYER_COUNT; index++) {
    players[index] = new Player(index);
  }

  // Get Serial Port name .. change in Options once identified 
  // println(Serial.list());

  // Connect to serial port, just show error message for now,
  // the game will just continue to use keyboard controls 
  try {
    usbPort = new Serial(this, options.serialPortName, options.serialBaudRate);
  } 
  catch (Exception e) {
    println(e.getMessage());
  }

  // A short delay to make sure, if connected, serial communications catch up
  delay(100);

  // Set each players starting position for paddles 
  for (Player player : players) {
    player.positionAtStart();
  }
}

/**
 * Called everytime a key is pressed 
 */
void keyPressed() {

  // Check if any players control keys pressed
  for (Player player : players) {
    player.checkKeyPressed(key);
  }
}

/**
 * Called everytime a key is released
 */
void keyReleased() {

  // Check if any players control keys released
  for (Player player : players) {
    player.checkKeyReleased(key);
  }
}

/**
 * Called everytime data is received from the serial port
 */
void serialEvent(Serial usbPort) {

  // Is there any data available ?
  if (usbPort.available() > 0) {

    // Get the data from port and "split" value for each players controller
    byte data = (byte)usbPort.read();
    players[Constants.PLAYER_ONE].setController(Functions.getHighNibble(data));
    players[Constants.PLAYER_TWO].setController(Functions.getLowNibble(data));

    // Check the players controllers to determine how to move
    for (Player player : players) {
      player.checkController();
    }
  }
}

/**
 * The code within this function runs continuously in a loop
 */
void draw() 
{

  // Set Background Colour
  background(options.backgroundColour);

  // Move the ball, paddles and update the scoreboards 
  ball.move();
  for (Player player : players) {
    scoreboards[player.index].update(player.score);
    player.move();
  }

  // Check if the ball hits the wall
  if (ball.hitsWall()) {
    try {
      // This will only cause error if we provided an invalid parameter, try it
      ball.bounce(Constants.AXIS_VERTICAL);
    } 
    catch (Exception e) {
      // Just show error message for now
      // the game will continue, but you will see some strange movements
      println(e.getMessage());
    }
  }   

  // Check if player hits the wall
  for (Player player : players) {
    if (player.hitsWall()) {
      // Reposition
      player.positionAtWall();
      // Stop
      player.stopMoving();
    }
  }

  // Check if player hits ball
  for (Player player : players) {
    if (player.hits(ball)) {
      // Reposition
      ball.positionAtPlayer(player);
      // Bounce
      try {
        // This will only cause error if we provided an invalid parameter, try it, use say,
        ball.bounce(Constants.AXIS_HORIZONTAL);
      } 
      catch (Exception e) {
        // Just show error message for now,  
        // the game will continue, but you will see some strange movements
        println(e.getMessage());
      }
    }
  }

  // Check if player misses ball
  for (Player player : players) {
    if (player.misses(ball)) {
      // Add point to other players score
      players[player.index^1].score++;
      // Move to ball to start position
      ball.positionAtStart();
      // Set direction of ball from start position, depending on who missed
      ball.directionAtStart(player);
    }
  }

  // Display the game objects
  net.display();
  ball.display();
  for (Player player : players) {
    scoreboards[player.index].display();
    player.display();
  }

  // Saves an image of screen every frame, which can be used to make a movie
  // saveFrame();
  // WARNING: Remove or comment if not in use, can fill up disk space if forgotton about
}
