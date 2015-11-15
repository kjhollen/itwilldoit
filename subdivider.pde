
/* some simple business machines...
 */

final int MAX_COLUMNS = 68;
final int MAX_BLOCK_SIZE = 6; // err, MAX_BLOCK_SIZE_PLUS_ONE, that is
final int MAX_ROWS = 68;
PImage[] tiny_button_img;
PImage[] rect_button_img;
PImage[] lever_img;
PImage[] knob_img;

final int SIZE = 1600;
final float GRID_UNIT_SIZE = 22;

ArrayList <Cell> cells;

final boolean DEBUG = false;

enum Component {
  TINY_BUTTON (1, 1, 2), LEVER (1, 2, 1), RECT_BUTTON (2, 2, 3), KNOB (5, 4, 3);
  
  // grid width and height that the image is supposed to take
  // up at its native resolution
  public final int w;
  public final int h;
  // the number of images available to load (nope, this isn't done
  // dynamically, it's hardcoded)
  public final int num_images;
  
  Component (int w, int h, int num_images) {
    this.w = w;
    this.h = h;
    this.num_images = num_images;
  }
}

void setup () {
  size (1600, 1600);
  noStroke ();

  // load in available images for each component
  tiny_button_img = new PImage[Component.TINY_BUTTON.num_images];
  for (int i = 0  ;  i < tiny_button_img.length  ;  i++) {
    tiny_button_img[i] = loadImage ("tiny-button-" + (i + 1) + ".jpg");
  }
  rect_button_img = new PImage[Component.RECT_BUTTON.num_images];
  for (int i = 0  ;  i < rect_button_img.length  ;  i++) {
    rect_button_img[i] = loadImage ("rect-button-" + (i + 1) + ".jpg");
  }
  lever_img = new PImage[Component.LEVER.num_images];
  for (int i = 0  ;  i < lever_img.length  ;  i++) {
    lever_img[i] = loadImage ("lever-" + (i + 1) + ".jpg");
  }
  knob_img = new PImage[Component.KNOB.num_images];
  for (int i = 0  ;  i < knob_img.length  ;  i++) {
    knob_img[i] = loadImage ("knob-" + (i + 1) + ".jpg");
  }
  
  cells = new ArrayList <Cell> ();
  
  // yay. it's doing it:
  boolean split_horizontal = int (random (0, 2)) == 0;
  subdivide (0, 0, MAX_ROWS, MAX_COLUMNS, 0, split_horizontal);
}

void draw () {
  background (153, 149, 147);
  for (Cell c : cells)
    c.draw ();
  
  if (! DEBUG)
    { save ("output.jpg");
      exit ();
    }
}


final int MAX_DEPTH = 6;

/*
 * recursively subdivides the rectangle until MAX_DEPTH is reached
 * 
 * x, y, w, h are in grid units, defining the rectangular region to
 * be filled in or subdivided further.
 *
 * split_horizontal indicates whether the next subdivision should
 * divide the space horizontally or vertically (it alternates between
 * recursive calls).
 *
 */
void subdivide (int x, int y, int w, int h, int depth, boolean split_horizontal) {
  //println ("sub x: " + x + " y: " + y + " w: " + w + " h: " + h + " d: " + depth);
  if (depth == MAX_DEPTH)
    { cells.add (new Cell (x, y, w, h, notSoRandomComponent (w, h)));
      return;
    }
  
  // leave some space around the first few levels so that
  // subdivisions are visible; read as separate "panels" interface
  boolean padding = depth < 4;
  int num_splits = int (random (2, 4));
  
  for (int i = 0  ;  i < num_splits  ;  i++)
    { //println ("split horizontal? " + split_horizontal);
      
      int tw =  split_horizontal  ?  0  :  (w / num_splits + (i == (num_splits - 1)  ?  w % num_splits  :  0));
      int th =  split_horizontal  ?  (h / num_splits + (i == (num_splits - 1)  ?  h % num_splits  :  0))  :  0;
      subdivide (x, y, split_horizontal  ?  w  :  tw - (padding  &&  i != (num_splits - 1) ?  1  :  0),
                       split_horizontal  ?  th - (padding  &&  i != (num_splits - 1) ?  1  :  0) :  h, depth + 1,
                       !split_horizontal);
      x += tw;
      y += th;
    }
}

Component notSoRandomComponent (int w, int h) {
  if (w % Component.KNOB.w == 0  &&  h % Component.KNOB.h == 0)
    return Component.KNOB;
  else if (w % Component.RECT_BUTTON.w == 0  &&  h % Component.RECT_BUTTON.h == 0)
    return Component.RECT_BUTTON;
  else if (w % Component.LEVER.w == 0  &&  h % Component.LEVER.h == 0)
    return Component.LEVER;
  
  // default
  return Component.TINY_BUTTON;
}

/* 
 * only accessible if DEBUG = true above
 * (otherwise, app quits before this can ever happen
 *
 */
void mousePressed () {
  cells.clear();
  boolean split_horizontal = int (random (0, 2)) == 0;
  subdivide (0, 0, MAX_ROWS, MAX_COLUMNS, 0, split_horizontal);
}