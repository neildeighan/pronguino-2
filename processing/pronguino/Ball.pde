/**
 * Ball
 *
 * Encapsulates the ball
 *
 * @author  Neil Deighan
 */
class Ball {
  float x;
  float y;
  float w;
  float h;
  float speed; 

  private int horizontalDirection;
  private int verticalDirection;  

  /**
   * Class Constructor 
   *
   * @param  ballSize  the height and width of the ball in pixels
   * @param  ballSpeed the number of pixels added to the position of ball when moving
   */
  Ball(float ballSize, float ballSpeed) {
    this.w = ballSize;
    this.h = ballSize;
    this.speed = ballSpeed;
  }

  /**
   * Generates a random direction of -1 or +1, but not 0
   *
   * @return  -1 or +1
   */
  private int getRandomDirection() {
    int r;

    do {
     // The random functions parameters are non-inclusive so -2 and 2
     // are not returned, also returns float type, i.e. 1.85428, 0.76158786 or -1.1046469,
     // so we cast to (int) to "round" to 1, 0 or -1
     r = (int)random(-2, 2);
    } while (r == 0);
    
    return r;
  }

  /**
   * Positions the ball in front of the players paddle
   */
  void positionAtPlayer(Player player) {
    this.x = (player.index==Constants.PLAYER_ONE) 
      ? player.paddle.x + player.paddle.w 
      : player.paddle.x - player.paddle.w;
  }

  /**
   * Positions the ball in the centre of the screen at a random height, not too close to the edges,
   * so as not to kick in any of the checks i.e. ball hitting the wall.
   */
  void positionAtStart() {
    x = width / 2;
    y = (int)random(10, height-10);
  }

  /**
   * Sets the initial direction of the ball at random, before it starts moving at beginning of game
   */
  void directionAtStart() {
    horizontalDirection = getRandomDirection();
    verticalDirection = getRandomDirection();
  }

  /**
   * Sets the horizontal direction of the ball based on the player who missed ball
   *
   * @param  player  Player that missed the ball
   */
  void directionAtStart(Player player) {
    horizontalDirection = (player.index == Constants.PLAYER_ONE) 
      ? Constants.DIRECTION_RIGHT 
      : Constants.DIRECTION_LEFT;
    verticalDirection = getRandomDirection();
  }

  /**
   * Increases/decreases the x and y co-ords of the ball in pixels by speed * direction 
   */
  void move() {
    x += ( speed * horizontalDirection );
    y += ( speed * verticalDirection );
  }

  /**
   * Changes the direction of the ball on the given axis.
   *
   * @param  axis  
   *
   * @throws Exception if invalid axis value given
   */
  void bounce(int axis) throws Exception {

    switch(axis) {
      case Constants.AXIS_HORIZONTAL:
        horizontalDirection *= Constants.DIRECTION_OPPOSITE;
        break;
      case Constants.AXIS_VERTICAL:
        verticalDirection *= Constants.DIRECTION_OPPOSITE;
        break;
      default:
        // Have added simple parameter checking which raises 
        // error if invalid, this protects the game from 
        // the developer
        throw new Exception("axis parameter must be AXIS_HORIZONTAL or AXIS_VERTICAL");
    }
  }

  /**
   * Checks if the y co-ord of the ball is outside of the top/bottom screen boundaries
   *
   * @return true, if outside of the boundaries 
   */
  boolean hitsWall() {
    return ( y < 0) || (y > height-h);
  }

  /**
   * Draws the ball
   */
  void display() {
    noStroke();
    rect(x, y, w, h);
  }
}
