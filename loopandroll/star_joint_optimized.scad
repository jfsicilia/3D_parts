// Radio of the flange's head.
FLANGE_HEAD_RADIO = 2.1;

// Height of the flange's base.
FLANGE_BASE_HEIGHT = 2;

// Width of the flange's base.
FLANGE_BASE_WIDTH = 2.2;

// Wall's thickness.
WALL_THICKNESS=1.8;

// Width of the tile.
TILE_WIDTH=48;

// Height of the tile.
TILE_HEIGHT=16;

//
// 2D hollow rectangle with rounded corners.
// Params:
//   width -- Rectangle width.
//   height -- Rectangle height.
//   thickness -- Thickness of the rectangle walls and radio of the corners.
//
module __rounded_hollow_rectangle(width, height, thickness)
{
  // Create the external wall of the piece (rounded square shape).
  difference()
  {
    // External rounded rectangle.
    hull()
    {
      for (i=[-width/2 + thickness, 
              width/2 - thickness])
        for (j=[-height/2 + thickness, 
                height/2 - thickness])
          translate([i, j, 0])
            circle(r=thickness, $fn=30);
    }
    // Internal rounded rectangle.
    hull()
    {
      for (i=[-width/2 + 2*thickness, 
              width/2 -2*thickness])
        for (j=[-height/2 + 2*thickness, 
                height/2 - 2*thickness])
          translate([i, j, 0])
            circle(r=thickness, $fn=30);
    }
  }
}

//
// A wedge is a 3D shape with a cubed base and a pyramid sphaped top.
// Params:
//   base_l -- Length of the base cube.
//   base_w -- Width of the base cube.
//   base_h -- Height of the base cube.
//   wedge_h -- Wedge's total height.
//
module __wedge(base_l, base_w, base_h, wedge_h)
{
  hull()
  {
    translate([0,0, wedge_h])
      sphere(r=1, center=true);
    linear_extrude(base_h)
      __rounded_hollow_rectangle(base_l, base_w, WALL_THICKNESS);
  }
}

//
// Create the joint with sockets and then subtract 2 wedges on each extreme
// of the joint to make it lighter.
//
difference()
{
  // Joint with sockets for flanges.
  linear_extrude(TILE_WIDTH)
  {
    // Create external walls and the sockets for the flanges.
    difference()
    {
      union()
      {
        // External walls of the joint.
        __rounded_hollow_rectangle(TILE_HEIGHT, TILE_HEIGHT, WALL_THICKNESS);
        // Inner structure to keep together the walls.
        for (i = [45, 135])
        {
          rotate([0, 0, i])
            square([WALL_THICKNESS, 
                  sqrt(2) * TILE_HEIGHT - 2 * WALL_THICKNESS], center=true);
        }
      }

      // Let make the flanges' sockets.
      for (i = [0, 90, 180, 270])
      {
        rotate([0,0,i])
          translate([TILE_HEIGHT/2 - FLANGE_BASE_HEIGHT - FLANGE_HEAD_RADIO, 
                    0, 0])
            union()
            {
              translate([FLANGE_HEAD_RADIO + FLANGE_BASE_HEIGHT/2, 0, 0])
                square([FLANGE_BASE_HEIGHT+2, FLANGE_BASE_WIDTH], center=true);
            }
      }
    }
  }

  // Let subtract 2 wedges to make joint lighter.
  // The height of each wedge will be 40% of the joint height.
  // The wedge has a squared base and a pyramid sphaped top.
  // The base's height will be 40% of the total wedge's height.
  wedge_height= 2/5 * TILE_WIDTH;
  // First wedge.
  __wedge(TILE_HEIGHT-2*WALL_THICKNESS, TILE_HEIGHT-2*WALL_THICKNESS, 
          wedge_height * 2/5, wedge_height);
  // Second wedge.
  translate([0,0,TILE_WIDTH])
    rotate([180,0,0])
    __wedge(TILE_HEIGHT-2*WALL_THICKNESS, TILE_HEIGHT-2*WALL_THICKNESS, 
            wedge_height * 2/5, wedge_height);
}
