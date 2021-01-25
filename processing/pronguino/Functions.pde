/**
 * Functions
 *
 * Functions that do not necessarily belong in a class, as they could be used elsewhere
 * these do not require an instance of Functions to be created.
 *
 * @author  Neil Deighan
 */
static class Functions {

  /**
   * Extracts a high nibble (first four bits) from a byte
   *
   * @param  data  byte to extract nibble from
   */
  static int getHighNibble(byte data) {
    return (int) ((data >> 4) & (byte) 0x0F);
  }

  /**
   * Extracts a low nibble (last four bits) from a byte
   *
   * @param  data  byte to extract nibble from
   */
  static int getLowNibble(byte data) {
    return (int) (data & 0x0F);
  }
}
