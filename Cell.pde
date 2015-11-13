

public class Cell {
  
  Component type;
  
  // these are all in grid units, not pixel units
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
    PImage[] imgs = tiny_button_img;
    //println ("drawing cell");

    color col = color (0);
    if (type == Component.TINY_BUTTON) {
      imgs = tiny_button_img;
      col = color (0, 50);
    } else if (type == Component.RECT_BUTTON) {
      imgs = rect_button_img;
      col = color (255, 0, 0, 50);
    } else if (type == Component.LEVER) {
      imgs = lever_img;
      col = color (0, 255, 0, 50);
    } else if (type == Component.KNOB) {
      imgs = knob_img;
      col = color (0, 0, 255, 50);
    }
    
    float x_offset = (SIZE - GRID_UNIT_SIZE * MAX_COLUMNS) * 0.5;
    float y_offset = (SIZE - GRID_UNIT_SIZE * MAX_ROWS) * 0.5;
    
    // fill in with an appropriate number of images
    for (int r = 0  ;  r < this.h  ;  r += type.h) {
      for (int c = 0  ;  c < this.w  ;  c += type.w) {
        PImage img = imgs[int (random(0, type.num_images))];
        image (img, x_offset + (x + c) * GRID_UNIT_SIZE,
                    y_offset + (y + r) * GRID_UNIT_SIZE,
                    type.w * GRID_UNIT_SIZE,
                    type.h * GRID_UNIT_SIZE);
      }
    }
    
    if (DEBUG) {
      fill (col);
      rect (x_offset + x * GRID_UNIT_SIZE,
            y_offset + y * GRID_UNIT_SIZE,
            w * GRID_UNIT_SIZE,
            h * GRID_UNIT_SIZE);
    }
  } //<>//
}