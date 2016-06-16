//
// Makes a cylinder with a notch.
// Params:
//   radio -- Radio of the cylinder.
//   height -- Height of the cylinder.
//   notch_radio -- Radio of the notch.
//   center -- [true, false] Center the cylinder in origin [0,0,0].
//
module cylinder_with_notch(
    radio = 10, height = 30, notch_radio = 2, center=false, $fn=$fn)
{
  
  difference() 
  {
    // Main cylinder.
    cylinder(r=radio, h=height, center=center);
    // Lets subtract notch.
    translate([radio, 0, 0])
      cylinder(r=notch_radio, h=height+10, center=center, $fn=$fn+10);
  }
} 

// Cylinder with notch.
cylinder_with_notch(radio=10, height=30, notch_radio=2, center=true);
