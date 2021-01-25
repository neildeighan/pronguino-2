/**
 * Paddle
 *
 * Encapsulates the paddle
 *
 * @author  Neil Deighan
 */
class Paddle {
  float x;
  float y;
  float w;
  float h;

  private float speed;
  private float direction;

  Player parent;

  /**
   * Class constructor
   *
   * @param  player  parent of this paddle  
   */
  Paddle(Player player) {
    this.parent = player; 

    // Which side does this paddle go .. not too close the the edge
    this.x = this.parent.index == Constants.PLAYER_ONE ? 10 : width-20;

    this.w = options.paddleWidth; 
    this.h = options.paddleHeight;
    this.speed = options.paddleSpeed;
  }

  /**
   * Sets the direction of the paddle
   *
   * @param  direction, multiplier, either up or down direction constants
   */
  void updateDirection(int direction) {
    this.direction = direction;
  }

  /**
   * Sets the speed of the paddle
   *
   * @param  speed, no. of pixels to add to y co-ord of paddle 
   */
  void updateSpeed(float speed) {
    this.speed = speed;
  }

  /**
   * Sets the starting position of the paddle depending on position of controller, if connected, 
   * or default to middle if if no controller
   */
  void positionAtStart() {
    if (this.parent.controller.currentValue != Constants.CONTROLLER_DUMMY_VALUE) {

      // Set the y position of the paddle based on current controller rvalue
      this.y = map(this.parent.controller.currentValue, 
                   Constants.CONTROLLER_MIN_VALUE, Constants.CONTROLLER_MAX_VALUE, 
                   0, height-this.h);
    } else {
      // Default to middle 
      this.y = (height-this.h)/2;
    }
  }

  /**
   * Sets the position of paddle to the wall, depending on proximity
   */
  void positionAtWall() {
    if (y < 0) {
      y = 0;
    } else {
      if (y+h > height) {
        y = height-h;
      }
    }
  }

  /**
   * Increases/decreases the y co-ords of the paddle in pixels by speed * direction 
   */
  void move() {
    y += (speed * (float)direction);
  }

  /**
   * Sets the direction to 0, stopping the paddle
   */
  void stopMoving() {
    direction = Constants.DIRECTION_NONE;
  }

  /**
   * Checks if the y co-ord of the paddle is outside of the top/bottom screen boundaries
   *
   * @return true, if outside of the boundaries 
   */
  boolean hitsWall() {
    return (y < 0) || (y + h > height);
  }

  /**
   * Checks the proximity of the ball to the paddle, and determines if collision is made
   *
   * @param  ball  
   *
   * @return true, if collision is made
   */
  boolean hits(Ball ball) {
    return  ( ( ball.x < (this.x + this.w) && parent.index == Constants.PLAYER_ONE) || 
              ( (ball.x + ball.w) > this.x && parent.index == Constants.PLAYER_TWO) ) && 
              ( ball.y >= this.y && ball.y <= (this.y + this.h) );
  }

  /**
   * Check the x co-ord of the ball is outside of the left/right screen boundaries depending on player
   *
   * @param  ball  
   *
   * @return  true, if outside of boundaries
   */
  boolean misses(Ball ball) {
    return (ball.x < 0 && parent.index == Constants.PLAYER_ONE)  || 
           (ball.x > width && parent.index == Constants.PLAYER_TWO);
  }

  /**
   * Draws the paddle
   */
  void display() {
    noStroke();
    rect(x, y, w, h);
  }
}
