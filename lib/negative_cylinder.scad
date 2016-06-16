//
// Create the negative of a cylinder with a hollow cube.
// The cube will be of size [2*r + t, 2*r + t, h], and the cylinder will
// be subtracted from it. You could specify an angle for the cylinder. For
// example 360 will make a whole cylinder, 180 half cylinder and 90 quarter 
// of a cylinder.
// Params:
//   r -- Radio of the cylinder.
//   h -- Height of the cylinder.
//   t -- Thickness of the cube that will hold the negative of the cylinder.
//   angle -- [0-360] How much cylinder to build (360 whole cylinder, 
//            180 half cylinder, 90 quarter of cylinder, 0 no cylinder).
//   center -- [true, false] Center the object on origin [0, 0, 0]. 
//
module negative_cylinder(r=10, h=20, t=2, angle=360, center=false, $fn=10) 
{
  difference() 
  {
    cube([2*r + t, 2*r + t, h], center=center); 
    cylinder(r=r, h=h+2, center=center, $fn=$fn);
    translate([0, 0, -h])
      rotate_extrude(angle=360-angle)
        square([2*(r+t), 2*h]);
  }
}


negative_cylinder(r=10, h=20, t=2, center=true, $fn=50);

translate([30, 0, 0])
  negative_cylinder(r=5, h=20, t=5, angle=90, center=true, $fn=50);

translate([60, 0, 0])
  negative_cylinder(r=8, h=20, t=1, angle=180, center=true, $fn=50);

translate([90, 0, 0])
  negative_cylinder(r=3, h=20, t=9, angle=270, center=true, $fn=50);

