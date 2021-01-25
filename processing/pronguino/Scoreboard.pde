/**
 * Scoreboard
 *
 * Encapsulates the scoreboard
 *
 * @author  Neil Deighan
 */
class Scoreboard {

  int score = 0;
  float x;
  float y;
  PFont font;

  /**
   * Class constructor
   *
   * @param  x      x co-ord of scoreboard
   * @param  y      y co-ord of scoreboard
   * @param  font   font family
   */
  Scoreboard(float x, float y, PFont font) {
    this.x = x;
    this.y = y;
    this.font = font;
  }

  /**
   * Update the scoreboard
   *
   * @param  score
   */
  void update(int score) {
    this.score = score;
  }

  /**
   * Draw the scoreboard
   */
  void display() {
    textFont(font);
    text(score, x, y);
  }
}
