//
// Creates a hollow cube.
// Params:
//  r -- Size. Can be a single value (same value will be used for width, 
//       depth and height) or a list [width,depth,height].
//  t -- Thickness.
//  top -- [true, false]
//         true: Cube has a closed top.
//         false: Cube has an opened top.
//  bottom -- [true, false]
//            true: Cube has a closed bottom.
//            false: Cube has an opened bottom.
//  center -- If true it centers the object in origin [0,0,0].
//  inwards -- [true, false] If true, the cube has r radio and thickness
//             goes inwards. If false, the cube has r+t radio (thickness
//             goes outwards).
//
module hollow_cube(size=10, t=3, top=false, bottom=false, 
                   inwards=true, center=false) 
{

  // Get width, depth and height from size parameter.
  w = (size[0] != undef) ? size[0] : size;
  d = (size[1] != undef) ? size[1] : size;
  h = (size[2] != undef) ? size[2] : size;

  // Main cube height.
  height = (inwards) ? h : h + 2 * t;
  // Compute hollow cube height. If closed top and bottom then hollow 
  // cube leaves t (thickness) on top and bottom. If not let hollow
  // cube be a bit higher than main cube.
  h_height = (top && bottom)? height - 2 * t : height + 2;

  // Compute cube width. Thickness goes inwards or outwards.
  width = (inwards) ? w : w + 2 * t;
  // Hollow cube width.
  h_width = width - 2 * t;

  // Compute cube depth. Thickness goes inwards or outwards.
  depth = (inwards) ? d : d + 2 * t;
  // Hollow cube depth.
  h_depth = depth - 2 * t;

  // Compute hollow cube Z move to "open" if top and/or bottom are false.
  sign = (top)? -1 : +1;
  z = ((top && bottom) || (!top && !bottom)) ? 0 : sign * (t + 1);
  
  difference() 
  {
    // Main cube.
    cube([width, depth, height], center=center);
    // Lets compute the negative of the hollow.
    translate([0,0,z])
      cube([h_width, h_depth, h_height], center=center);
  }

}

// Hollow cube with opened top and bottom.
hollow_cube([10,20,30], center=true);

// Hollow cube with closed top and opened bottom. 
translate([30,0,0])
  hollow_cube([10,20,30],  top=true, center=true);

// Hollow cube with opened top and closed bottom. 
translate([60,0,0])
  hollow_cube([10,20,30], bottom=true, center=true);

// Hollow cube with closed top and bottom. 
translate([90,0,0])
  hollow_cube([10,20,30], top=true, bottom=true, center=true);

// Hollow cube with closed top and bottom. 
translate([-30,0,0])
  hollow_cube([10,20,30], inwards=false, center=true);

// hollow_cube([48,48,96], inwards=false, center=true, t=48);
// color("red")
// cube([48,49,96], center=true);

