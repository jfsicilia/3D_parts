// Radio of the flange's head.
FLANGE_HEAD_RADIO = 2.1;

// Height of the flange's base.
FLANGE_BASE_HEIGHT = 1.9;

// Width of the flange's base.
FLANGE_BASE_WIDTH = 2.2;

// Wall's thickness.
WALL_THICKNESS=2;

// Width of the tile.
TILE_WIDTH=48;

// Height of the tile.
TILE_HEIGHT=20;


// Joint with sockets for flanges.
linear_extrude(TILE_WIDTH)
{
  difference()
  {
    // Create external walls and the sockets for the flanges.
    union()
    {
      // Create the external wall of the piece (rounded square shape).
      difference()
      {
        // External rounded square.
        hull()
        {
          for (i=[-TILE_HEIGHT/2 + WALL_THICKNESS, 
                  TILE_HEIGHT/2 - WALL_THICKNESS])
            for (j=[-TILE_HEIGHT/2 + WALL_THICKNESS, 
                    TILE_HEIGHT/2 - WALL_THICKNESS])
              translate([i, j, 0])
                circle(r=WALL_THICKNESS, $fn=30);
        }
        // Internal rounded square.
        hull()
        {
          for (i=[-TILE_HEIGHT/2 + 2*WALL_THICKNESS, 
                  TILE_HEIGHT/2 -2*WALL_THICKNESS])
            for (j=[-TILE_HEIGHT/2 + 2*WALL_THICKNESS, 
                    TILE_HEIGHT/2 - 2*WALL_THICKNESS])
              translate([i, j, 0])
                circle(r=WALL_THICKNESS, $fn=30);
        }
      }

      // Create the shapes of what would became the sockets for the flanges.
      for (i = [0, 90, 180, 270])
      {
        rotate([0,0,i])
          translate([TILE_HEIGHT/2 - FLANGE_BASE_HEIGHT - FLANGE_HEAD_RADIO,
                    0,0])
            // The shape of the socket will be a hull of two circles and
            // a square at the base.
            union()
            { 
              // Head of the flange (the head is made of a hull of 2 circles).
              hull()
              {
                // Head of the flange (the head is made of a hull of 2 
                // circles).
                difference()
                {
                  circle(r=FLANGE_HEAD_RADIO + WALL_THICKNESS, $fn=30);
                  // Make a semicircle?
                  if (half_head)
                  {
                  translate([-(FLANGE_HEAD_RADIO*2 + 2)/2, 0, 0])
                    square(FLANGE_HEAD_RADIO*2 + 2, center=true);
                  }
                }
                *translate([FLANGE_HEAD_RADIO,0,0])
                  circle(r=FLANGE_BASE_WIDTH/2+2, $fn=30);
              }
              // Base of the flange.
              translate([FLANGE_HEAD_RADIO + FLANGE_BASE_HEIGHT/2, 0, 0])
                square([FLANGE_BASE_HEIGHT, 
                       FLANGE_BASE_WIDTH+2*WALL_THICKNESS], center=true);
            }
      }
    }

    // Let make the flanges' sockets hollow.
    for (i = [0, 90, 180, 270])
    {
      rotate([0,0,i])
        translate([TILE_HEIGHT/2 - FLANGE_BASE_HEIGHT - FLANGE_HEAD_RADIO, 
                  0, 0])
        // The shape of the socket will be a hull of two circles and
        // a square at the base.
        union()
        {
          // Head of the flange (the head is made of a hull of 2 circles).
          hull()
          {
            // Head of the flange (the head is made of a hull of 2 circles).
            difference()
            {
              circle(r=FLANGE_HEAD_RADIO, $fn=30);
              // Make it a semicircle?
              if (half_head)
              {
              translate([-(FLANGE_HEAD_RADIO*2 + 2)/2, 0, 0])
                square(FLANGE_HEAD_RADIO*2 + 2, center=true);
              }
            }
            translate([FLANGE_HEAD_RADIO,0,0])
              circle(r=FLANGE_BASE_WIDTH/2, $fn=30);
          }
          // Base of the flange.
          translate([FLANGE_HEAD_RADIO + FLANGE_BASE_HEIGHT/2, 0, 0])
            square([FLANGE_BASE_HEIGHT+2, FLANGE_BASE_WIDTH], center=true);
        }
    }
  }
}
