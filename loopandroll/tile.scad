use <rcylinder.scad>
use <copy_mirror.scad>

// Tile's corner roundness radio.
TILE_CORNER_RADIO=2;

// Width of the tile.
TILE_WIDTH=48;

// Height of the tile.
TILE_HEIGHT=20;

// Thickness of the tile's wall.
TILE_WALL_THICKNESS=2;

//
// Frame for the tile with rounded corners. The frame has a square base.
// Params:
//   w -- Width
//   h -- height
//   r -- Radio for the corners.
//
module __tile_frame(w=30, h=20, r=2)
{
  // Base frame for the tile with rounded corners.
  hull()
  {
    min_pos = -w/2 + r;
    max_pos = w/2 - r;
    for (i=[-w/2 + r, w/2 - r])
      for (j=[-w/2 + r, w/2 - r])
      {
        translate([i, j, 0])
          cylinder(r=r, h=h, center=true, $fn=30); 
      }
  }
}

// Radio of the flange's head.
FLANGE_HEAD_RADIO = 2;

// Height of the flange's base.
FLANGE_BASE_HEIGHT = 2;

// Width of the flange's base.
FLANGE_BASE_WIDTH = 2;

// Length of the outer flange's base.  
OUT_FLANGE_BASE_LENGTH = 26;

// Length of the flange's headlet.
FLANGE_HEADLET_LENGTH = 3;

// Length of the inner flange's base.
IN_FLANGE_BASE_LENGTH = TILE_HEIGHT - 2*FLANGE_HEADLET_LENGTH - 2*3;

// Height of the tile's notch.
NOTCH_HEIGHT = 2;

// Width of the tile's notch.
NOTCH_WIDTH = 14;

// 2D points of the notch shape.
NOTCH_POINTS = [[-NOTCH_WIDTH/2, NOTCH_HEIGHT/2],
                [-NOTCH_WIDTH/2, NOTCH_HEIGHT/2 + 1],
                [NOTCH_WIDTH/2, NOTCH_HEIGHT/2 + 1],
                [NOTCH_WIDTH/2, NOTCH_HEIGHT/2],
                [NOTCH_WIDTH/2 - NOTCH_HEIGHT, -NOTCH_HEIGHT/2],
                [-NOTCH_WIDTH/2 + NOTCH_HEIGHT, -NOTCH_HEIGHT/2]];

//
// Flange's head 2D shape.
// Params:
//   head_r -- Radio of the head.
//   base_w -- Width of the base.
//   half_head -- [true/false] Half head or full head.
//
module __tile_flange_head(head_r=2, base_w=2, half_head=true)
{
  hull()
  {
    difference()
    {
      circle(r=head_r, $fn=30);
      // Make a semicircle?
      if (half_head)
      {
      translate([-(head_r*2 + 2)/2, 0, 0])
        square(head_r*2 + 2, center=true);
      }
    }
    translate([head_r,0,0])
      circle(r=base_w/2, $fn=30);
  }
}

//
// Flange's 3D shape.
// Params:
//   head_r -- Radio of the flange's head.
//   base_h -- Height of the flange's base.
//   base_w -- Width of the flange's base.
//   base_l -- Length of the flange's base.
//   headlet_l -- Length of the flange's headlet.
//   half_head -- [true/false] Half head or full head.
//
module __tile_flange(head_r=2, base_h=2, base_w=2, base_l=26, 
                     headlet_l=4, half_head=true)
{
  // Flange base.
  linear_extrude(height=base_l, center=true)
  {
      translate([head_r + base_h/2, 0, 0])
        square([base_h, base_w], center=true);
  }

  // Flange head.
  linear_extrude(height=base_l, center=true)
    __tile_flange_head(head_r, base_w, half_head);

  // Flange headlets.
  copy_mirror([0,0,1])
    translate([0, 0, base_l/2])
      linear_extrude(height=headlet_l, scale=0.5)
        __tile_flange_head(head_r, base_w, half_head);
}

// Make tile with flanges and notchs.
difference()
{ 
  // Tile with flanges.
  union()
  {
    // Tile frame.
    difference() 
    {
      // Solid tile frame.
      __tile_frame(w=TILE_WIDTH, h=TILE_HEIGHT, r=TILE_CORNER_RADIO);
      // Let subtract the inner part to make the tile frame hollow.
      resize([TILE_WIDTH-2*TILE_WALL_THICKNESS, TILE_WIDTH-2*TILE_WALL_THICKNESS,
            TILE_HEIGHT+10])
        __tile_frame(w=TILE_WIDTH, h=TILE_HEIGHT, r=TILE_CORNER_RADIO);
    }

    // Flanges.
    for (i = [0,90,180,270])
    {
      rotate([0,0,i])
      {
        // External flanges.
        translate([-(TILE_WIDTH/2 + FLANGE_HEAD_RADIO + FLANGE_BASE_HEIGHT),0,0])
          rotate([90,0,0])
            __tile_flange(head_r=FLANGE_HEAD_RADIO, base_h=FLANGE_BASE_HEIGHT,
                          base_w=FLANGE_BASE_WIDTH, 
                          base_l=OUT_FLANGE_BASE_LENGTH,
                          headlet_l=FLANGE_HEADLET_LENGTH);
        // Internal flanges.
        translate([TILE_WIDTH/2 - (TILE_WALL_THICKNESS + FLANGE_HEAD_RADIO + 
                  FLANGE_BASE_HEIGHT), 0, 0])
          __tile_flange(head_r=FLANGE_HEAD_RADIO, base_h=FLANGE_BASE_HEIGHT,
                        base_w=FLANGE_BASE_WIDTH, base_l=IN_FLANGE_BASE_LENGTH,
                        headlet_l=FLANGE_HEADLET_LENGTH);
      }
    }
  }

  // Make notchs.
  copy_mirror([0,0,1])
    for (i = [0,90])
    {
      rotate([0,0,i])
        translate([0,0,TILE_HEIGHT/2-1])
          rotate([90,0,0])
            linear_extrude(height=TILE_WIDTH+10, center=true)
              polygon(NOTCH_POINTS);
    }
}

