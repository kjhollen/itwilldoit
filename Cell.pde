

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
    textFont (font);

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
    
    float x_offset = (width - GRID_UNIT_SIZE * MAX_COLUMNS) * 0.5;
    float y_offset = (height - GRID_UNIT_SIZE * MAX_ROWS) * 0.5;
    
    char ch = char (floor (random (65, 65 + 26)));
    
    // fill in with an appropriate number of images
    for (int r = 0  ;  r < this.h  ;  r += type.h) {
      for (int c = 0  ;  c < this.w  ;  c += type.w) {
        rectMode (CORNER);
        PImage img = imgs[int (random(0, type.num_images))];
        image (img, x_offset + (x + c) * GRID_UNIT_SIZE,
                    y_offset + (y + r) * GRID_UNIT_SIZE,
                    type.w * GRID_UNIT_SIZE,
                    type.h * GRID_UNIT_SIZE);
        if (type == Component.TINY_BUTTON) {
          fill (0);
          textFont (font);
          textSize (7);
          textAlign (CENTER, TOP);
          text (String.format ("%c%d", ch, r * this.w + c), x_offset + (x + c + 0.5) * GRID_UNIT_SIZE,
                       y_offset + (y + r) * GRID_UNIT_SIZE + 3);  //<>//
        }
       else if (type == Component.RECT_BUTTON) {
          fill (255);
          textFont (bold_font);
          textSize (7);
          textLeading (8.5);
          textAlign (CENTER, CENTER);
          rectMode (CENTER);
          String label = button_names[floor(random (button_names.length))];
          text (label, x_offset + (x + c + 1) * GRID_UNIT_SIZE,
                       y_offset + (y + r + 1) * GRID_UNIT_SIZE,
                       45, 40); 
        }
      }
    }
    
    /*if (DEBUG) {
      fill (col);
      rect (x_offset + x * GRID_UNIT_SIZE,
            y_offset + y * GRID_UNIT_SIZE,
            w * GRID_UNIT_SIZE,
            h * GRID_UNIT_SIZE);
    }*/
  } //<>//
}