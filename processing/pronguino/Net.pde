/**
 * Net
 *
 * Encapsulates the tables net
 *
 * @author  Neil Deighan
 */
class Net {

  float w;
  float h;
  float gap;
  float x;

  /**
   * Class constructor
   */
  Net() {
    this.w = options.netWidth;
    this.h = options.netHeight;
    this.gap = options.netGap;
    this.x = (width - this.w) / 2;
  }

  /**
   * Draws the net
   */
  void display() {
    float y = 0;

    do {
      noStroke();
      rect( this.x, y, this.w, this.h);
      y += (this.h + this.gap);
    } while ( y + this.h < height);
  }
}
