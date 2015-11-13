

final int MAX_COLUMNS = 64;
final int MAX_BLOCK_SIZE = 6; // err, MAX_BLOCK_SIZE_PLUS_ONE, that is
final int MAX_ROWS = 64;
PImage[] tiny_button_img;
PImage[] rect_button_img;
PImage[] lever_img;
PImage[] knob_img;

final int SIZE = 750;
final float GRID_UNIT_SIZE = 11;

ArrayList <Cell> cells;

enum Component {
  TINY_BUTTON (1, 1, 2), LEVER (1, 2, 1), RECT_BUTTON (2, 2, 3), KNOB (5, 4, 3);
  
  public final int w;
  public final int h;
  public final int num_images;
  
  Component (int w, int h, int num_images) {
    this.w = w;
    this.h = h;
    this.num_images = num_images;
  }
}

void setup () {
  size (750, 750);
  pixelDensity(displayDensity());
  noStroke ();

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
  boolean split_horizontal = int (random (0, 2)) == 0;
  subdivide (0, 0, MAX_ROWS, MAX_COLUMNS, 0, split_horizontal);
}

void draw () {
  background (153, 149, 147);
  for (Cell c : cells)
    c.draw ();
  save ("output.jpg");
  exit ();
}


final int MAX_DEPTH = 6;

void subdivide (int x, int y, int w, int h, int depth, boolean split_horizontal) {
  //println ("sub x: " + x + " y: " + y + " w: " + w + " h: " + h + " d: " + depth);
  if (depth == MAX_DEPTH)
    { cells.add (new Cell (x, y, w, h, randomComponent (w, h)));
      //println ("making cell");
      return;
    }
  
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

Component randomComponent (int w, int h) {
  int r = int (random (0, 4));
  if (/*r == 4  &&*/  w % Component.KNOB.w == 0  &&  h % Component.KNOB.h == 0)
    return Component.KNOB;
  else if (w % Component.RECT_BUTTON.w == 0  &&  h % Component.RECT_BUTTON.h == 0)
    return Component.RECT_BUTTON;
  else if (w % Component.LEVER.w == 0  &&  h % Component.LEVER.h == 0)
    return Component.LEVER;
  
  // default
  return Component.TINY_BUTTON;
}

void mousePressed () {
  cells.clear();
  boolean split_horizontal = int (random (0, 2)) == 0;
  subdivide (0, 0, MAX_ROWS, MAX_COLUMNS, 0, split_horizontal);
}