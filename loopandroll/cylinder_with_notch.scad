//
// Makes a cylinder with a notch.
// Params:
//   radio -- Radio of the cylinder.
//   height -- Height of the cylinder.
//   notch_radio -- Radio of the notch.
//
module cylinder_with_notch(radio = 10, height = 30, notch_radio = 2) {
  
  difference() {
    cylinder(r=radio, h=height, $fn=50, center=true);
    translate([radio, 0, 0])
      cylinder(r=notch_radio, h=height+10, $fn=20, center=true);
  }
} 
