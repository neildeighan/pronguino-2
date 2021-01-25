/**
 * Controller
 *
 * Encapsulates the players "controller", when Arduino connected
 *
 * @author  Neil Deighan
 */
class Controller {

  Player parent;
  int currentValue;
  int previousValue;

  /**
   * Class constructor
   *
   * @param  player  parent of this controller
   */
  Controller(Player player) {
    // Sets the parent of controller
    this.parent = player;
    // Sets the initial value of the controller outside of the min, max range,
    // so we can check wether controllers are connected or not.
    this.currentValue = Constants.CONTROLLER_DUMMY_VALUE;
  }

  /**
   * Checks if controller value has changed since previously set
   *
   * return  true, if the value has changed  
   */
  boolean valueChanged() {
    return (this.currentValue != this.previousValue);
  }

  /**
   * Calculates the difference between the current and previous values
   *
   * @return  value difference
   */
  int valueDifference() {
    return (currentValue - previousValue);
  }
}
