//
// Creates a hollow cylinder.
// Params:
//  r -- Radio.
//  h -- Height.
//  t -- Thickness.
//  top -- [true, false]
//         true: Cylinder has a closed top.
//         false: Cylinder has an opened top.
//  bottom -- [true, false]
//            true: Cylinder has a closed bottom.
//            false: Cylinder has an opened bottom.
//  center -- If true it centers the object in origin [0,0,0].
//  inwards -- [true, false] If true, the cylinder has r radio and thickness
//             goes inwards. If false, the cylinder has r+t radio (thickness
//             goes outwards).
//
module hollow_cylinder(r=10, h=20, t=3, top=false, bottom=false, center=false, 
                       inwards=true, $fn=10) 
{

  // Main cylinder height.
  height = (inwards) ? h : h + 2 * t;
  
  // Compute hollow cylinder height. If closed top and bottom then hollow 
  // cylinder leaves t (thickness) on top and bottom. If not let hollow
  // cylinder be a bit higher than main cylinder.
  h_height = (top && bottom)? height - 2 * t : height + 2;

  // Compute main cylinder radio. Thickness goes inwards or outwards.
  radio = (inwards) ? r : r + t;

  // Compute hollow cylinder radio.
  h_radio = radio - t;

  // Compute hollow cylinder Z move to "open" if top and/or bottom are false.
  sign = (top)? -1 : +1;
  z = ((top && bottom) || (!top && !bottom)) ? 0 : sign * (t + 1);
  
  difference() 
  {
    // Main cylinder.
    cylinder(r=radio, h=height, center=center, $fn=$fn);
    // Lets compute the negative of the hollow.
    translate([0,0,z])
      cylinder(r=h_radio, h=h_height, center=center, $fn=$fn);
  }

}

// Hollow cylinder with opened top and bottom.
hollow_cylinder(center=true, $fn=30);

// Hollow cylinder with closed top and opened bottom. 
translate([30,0,0])
  hollow_cylinder(top=true, center=true, $fn=30);

// Hollow cylinder with opened top and closed bottom. 
translate([60,0,0])
  hollow_cylinder(bottom=true, center=true, $fn=30);

// Hollow cylinder with closed top and bottom. 
translate([90,0,0])
  hollow_cylinder(top=true, bottom=true, center=true, $fn=30);

// Hollow cylinder with closed top and bottom. 
translate([-30,0,0])
  hollow_cylinder(inwards=false, center=true, $fn=30);

// Hollow cylinder with closed top and bottom. 
translate([-60,0,0])
  hollow_cylinder(inwards=false, t=6, top=true, bottom=true, 
                  center=true, $fn=30);

