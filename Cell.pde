

public class Cell {
  
  Component type;
  
  // these are all in grid units
  int w, h;
  int x, y;
  
  Cell (int x, int y, int w, int h, Component type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
  }
  
  void draw () {
    /*PImage img;*/
    //println ("drawing cell");
    color c = color (0);
    switch (type) {
      case TINY_BUTTON:
        //img = tiny_button_img;
        c = color (0, 50);
        break;
      case RECT_BUTTON:
        //img = rect_button_img;
        c = color (255, 0, 0, 50);
        break;
      case LEVER:
        //img = level_img;
        c = color (0, 255, 0, 50);
        break;
      case KNOB:
        //img = knob_img;
        c = color (0, 0, 255, 50);
    }
    fill (c);
    rect (x * GRID_UNIT_SIZE, y * GRID_UNIT_SIZE, w * GRID_UNIT_SIZE, h * GRID_UNIT_SIZE); //<>//
  }
}