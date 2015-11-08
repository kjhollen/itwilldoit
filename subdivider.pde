



final int MAX_COLUMNS = 96;
final int MAX_BLOCK_SIZE = 6; // err, MAX_BLOCK_SIZE_PLUS_ONE, that is
final int MAX_ROWS = 96;
PImage tiny_button_img;
PImage rect_button_img;
PImage lever_img;
PImage knob_img;



final int SIZE = 750;
final float GRID_UNIT_SIZE = (float) SIZE / MAX_COLUMNS;

ArrayList <Cell> cells;

enum Component {
  TINY_BUTTON (1, 1), RECT_BUTTON (2, 2), LEVER (1, 2), KNOB (5, 3);
  
  public final int w;
  public final int h;
  
  Component (int w, int h) {
    this.w = w;
    this.h = h;
  }
}

void setup () {
  size (750, 750);
  noStroke ();

  tiny_button_img = loadImage ("tiny-button.jpg");
  rect_button_img = loadImage ("rect-button.jpg");
  lever_img = loadImage ("lever.jpg");
  knob_img = loadImage ("knob.jpg");

  cells = new ArrayList <Cell> ();
  boolean split_horizontal = int (random (0, 2)) == 0;
  subdivide (0, 0, MAX_ROWS, MAX_COLUMNS, 0, split_horizontal);
}

void draw () {
  background (255);
  for (Cell c : cells)
    c.draw ();
}


final int MAX_DEPTH = 5;

void subdivide (int x, int y, int w, int h, int depth, boolean split_horizontal) {
  //println ("sub x: " + x + " y: " + y + " w: " + w + " h: " + h + " d: " + depth);
  if (depth == MAX_DEPTH)
    { cells.add (new Cell (x, y, w, h, randomComponent ()));
      //println ("making cell");
      return;
    }
  
  boolean padding = depth < 3;
  int num_splits = int (random (1, 4));
  
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

Component randomComponent () {
  int r = int (random (0, 4));
  switch (r) {
    case 0: return Component.TINY_BUTTON;
    case 1: return Component.RECT_BUTTON;
    case 2: return Component.LEVER;
    case 3: return Component.KNOB;
  }
  return Component.TINY_BUTTON;
}

void mousePressed () {
  cells.clear();
  boolean split_horizontal = int (random (0, 2)) == 0;
  subdivide (0, 0, MAX_ROWS, MAX_COLUMNS, 0, split_horizontal);
}