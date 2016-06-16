use <hollow_cube.scad>

//
// Returns a frame with n_blocks. A block has width x width x width size.
// A frame with n_blocks will have a height of n_blocks x width.
// Params:
//   n_blocks -- Number of blocks in one side of the frame.
//   width -- Total width of the frame (frame has square footprint).
//   roundness -- If greater than 0 is used as the radio for smoothing edges.
//   hole_offset -- Distance of the hole to borders of the frame.
//
module frame(n_blocks=3, width=30, roundness=1, hole_offset=0) 
{
  if (roundness > 0) 
  {
    minkowski() 
    {
      _frame(n_blocks, width, roundness, hole_offset);
      sphere(r=roundness, center=true, $fn=10);
    }
  }
  else 
  {
    _frame(n_blocks, width, roundness, hole_offset);
  }
}

// Frame's blocks.
BLOCKS = 2;

// Frame's width.
WIDTH=48;

// Frame's border radio roundness.
ROUNDNESS=0;

// Frame's hole offset from inner sides.
HOLE_OFFSET=2;

// Show debug info on output console and draw auxiliary geometry to check.
DEBUG=false;

// Create a frame with global parameters.
frame(n_blocks=BLOCKS, 
      width=WIDTH, 
      roundness=ROUNDNESS, 
      hole_offset=HOLE_OFFSET);

// --------------------- Private modules and functions ---------------------

//
// Create bayonet joint flanges (will use spheres as flanges). This spheres 
// will be placed in a invisible cylinder with specified radio and height.
// The center of the spheres will be at the border of this invisible
// cylinder, and sphere_offset from the top/bottom. There will be
// to rings of spheres one at sphere_offset from the top and the other
// one sphere_offset from the bottom. The number of spheres in a ring
// will be defined by n_angles. If n_spheres is 2 then the spheres will
// be placed at 0º and 180º. If n_spheres is 4 then the spheres will be
// placed at 0º, 90º, 180º and 270º.
// Params:
//   r -- Radio of the invisible cylinder.
//   h -- Height of the invisible cylinder.
//   sphere_radio -- Radio of the spheres.
//   sphere_offset -- Offset of the sphere from top/bottom of the invisible
//                    cylinder.
//   n_angles -- [2,4] If 2, spheres will be placed at 0º and 180º.
//                     If 4, spheres will be placed at 0º, 90º, 180º and 270º.
//
module _bayonet_cylinder(r=11, h=22, sphere_radio=2, sphere_offset=4, 
                         n_angles=2) 
{
  
  union() 
  {
    // Use spheres only at 0 and 180 degrees instead of 0, 90, 180, 270,
    // optimized for 3D layer printing.

    angles = (n_angles == 2) ? [0,180] : [0,90,180,270];
    for (i = angles) 
    {
        rotate([0,0,i])
          translate([r,0,h/2-sphere_offset])
            sphere(r=sphere_radio, center=true, $fn=$fn);
        rotate([0,0,i])
          translate([r,0,-h/2+sphere_offset])
            sphere(r=sphere_radio, center=true, $fn=$fn);
    }
  }
}

//
// Translates children in the top and bottom of a cube([width,width,height])
// in a 3x3 fashion.
// Param:
//   width -- Width of the cube.
//   height -- Height of the cube.
//
module _top_bottom_3x3(width=0, height=0) 
{
        for (i = [-1:1])
          for (j = [-1:1])
            for (k = [-1,1])
              translate([i*width/2, j*width/2, k*height/2])
                children();
}

//
// Translates children in the front and back of a cube([width,width,height])
// in a 3Nx3 fashion. N is height/width times.
// Param:
//   width -- Width of the cube.
//   height -- Height of the cube.
//
module _front_back_3Nx3(width=0, height=0) 
{
  for (h = [-height/2+width/2:width:+height/2-width/2])
    for (i = [-1:1])
      for (j = [-1:1])
        for (k = [-1,1]) 
          translate([0, k*width/2, h])
            rotate([90, 0, 0])
              translate([i*width/2, j*width/2, 0])
                children();
}

//
// Translates children in the left and right of a cube([width,width,height])
// in a 3Nx3 fashion. N is height/width times.
// Param:
//   width -- Width of the cube.
//   height -- Height of the cube.
//
module _left_right_3Nx3(width=0, height=0) 
{
  for (h = [-height/2+width/2:width:+height/2-width/2])
    for (i = [-1:1])
      for (j = [-1:1])
        for (k = [-1,1]) 
          translate([k*width/2, 0, h])
            rotate([0, 90, 0])
              translate([i*width/2, j*width/2, 0])
                children();
}

//
// Returns a frame with n_blocks. A block has width x width x width size.
// A frame with n_blocks will have a height of n_blocks x width.
// Params:
//   n_blocks -- Number of blocks in one side of the frame.
//   width -- Total width of the frame (frame has square footprint).
//   roundness -- If greater than 0 is used as the radio for smoothing edges.
//   hole_offset -- Distance of the hole to borders of the frame.
//
module _frame(n_blocks=3, width=30, roundness=1, hole_offset=0) 
{
  // Hole's radio.
  hole_radio = (width-2*hole_offset)/4;
  // Hole's diameter.
  hole_diam = 2*hole_radio;
  // Frame's height.
  height = width*n_blocks;
  // Holes' distance.
  hole_dist = width/2;

  if (DEBUG) 
  {
    echo ("frame(num=", n_blocks, ", wdt=", width, ", rnd=", roundness, 
          "off=", hole_offset);
    echo ("Hole radio: ", hole_radio);
    echo ("Hole diam: ", hole_diam);
    echo ("Hole offset: ", hole_offset);
    echo ("Width: ", width);
    echo ("Height: ", height);
  }

  difference() 
  {
    union() 
    {
      // Create initial hollow frame.
      difference() 
      {
        // Main cube for the frame.
        cube([width, width, height], center=true);
        // Subtract cube to make core as hollow as possible (less weight).
        cube([hole_diam, hole_diam, height-4*hole_radio-2*hole_offset], 
             center=true);

        // Make holes on the top and bottom.
        _top_bottom_3x3(width, height)
          cylinder(r=hole_radio, h=2*hole_radio, center=true);

        // Make holes in front and back.
        _front_back_3Nx3(width, height)
          cylinder(r=hole_radio, h=2*hole_radio, center=true);

        // Make holes on left and right.
        _left_right_3Nx3(width, height)
          cylinder(r=hole_radio, h=2*hole_radio, center=true);

        // Pass through holes.
        // Top/bottom hole.
        cylinder(r=hole_radio, h=height+10, center=true);
        for (h = [-height/2 + width/2 : width/2 : +height/2-width/2]) {
          // Fron/back holes.
          translate([0, 0 , h])
            rotate([90, 0, 0])
              cylinder(r=hole_radio, h=height+10, center=true);
          // Left/right holes.
          translate([0, 0 , h])
            rotate([0, 90, 0])
              cylinder(r=hole_radio, h=height+10, center=true);
        }
      }

      // Add spheres for bayonet joints.
      
      // Top and bottom joints.
      _top_bottom_3x3(width, height)
        color("blue")
          _bayonet_cylinder(r=hole_radio, h=2*hole_radio, sphere_offset=4, 
                           sphere_radio=2, center=true);

      // Front and back joints.
      _front_back_3Nx3(width, height)
        color("green")
          _bayonet_cylinder(r=hole_radio, h=2*hole_radio, sphere_offset=4, 
                           sphere_radio=2, center=true);

      // Left and right joints.
      _left_right_3Nx3(width, height)
        color("red")
          rotate([0, 0, 90])
            _bayonet_cylinder(r=hole_radio, h=2*hole_radio, sphere_offset=4, 
                              sphere_radio=2, center=true);
    }
    // Subtract all beyond main frame.
    hollow_cube([width,width,height], 
                inwards=false, t=width, top=true, bottom=true, center=true);
  }    

  // Show debug geometry.
  if (DEBUG) 
  {
    %rotate([90,0,90])
      cylinder(r=hole_radio, h=200, $fn=100, center=true);
    %rotate([90,0,0])
      cylinder(r=hole_radio, h=200, $fn=100, center=true);
    %cylinder(r=hole_radio, h=200, $fn=100, center=true);
  }
}

