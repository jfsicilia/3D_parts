use <cylinder_with_notch.scad>

// 
// Makes a hollow sphere with a hole and a notch. The sphere can be truncated
// using the percentage of sphere that is wanted to be showed.
// Params:
//   radio -- Sphere's radio.
//   thickness -- Sphere's thickness.
//   hole_radio -- Sphere's hole radio.
//   hole_notch_radio -- Sphere's hole has a notch with this radio.
//   percentage -- Sphere's percentage (0 - no sphere, 0.5 half sphere, 
//   0.75 3/4 sphere).
//
module _sphere_with_notched_hole(radio=10, thickness=2, hole_radio=2,
                                 hole_notch_radio=0.5, 
                                 percentage=0.5) 
{

  union() 
  {
    difference () 
    {
      // Main sphere.
      sphere(r=radio, $fn=100, center=true);
      // Make sphere hollow.
      sphere(r=radio-thickness, $fn=100, center=true);
      // Erase (1-percentage) of the lower half of the sphere.
      translate([0, 0, -(2*radio) + (1-percentage)*radio*2])
        cube([2*radio+10, 2*radio+10, 2*radio], center=true);
      // Make hole on top of sphere.
      cylinder_with_notch(radio=hole_radio, height=radio*2+10, 
                          notch_radio=hole_notch_radio, $fn=30);
    }
  }
}

// 
// Makes a hollow sphere with a hole and a notch. The sphere can be truncated
// using the percentage of sphere that is wanted to be showed.
// Params:
//   radio -- Sphere's radio.
//   thickness -- Sphere's thickness.
//   roundness -- Sphere's roundness.
//   hole_radio -- Sphere's hole radio.
//   hole_notch_radio -- Sphere's hole has a notch with this radio.
//   percentage -- Sphere's percentage (0 - no sphere, 0.5 half sphere, 
//   0.75 3/4 sphere).
//
module sphere_with_notched_hole(radio=10, roundness=1, thickness=2, 
                                hole_radio=2, hole_notch_radio=0.5,
                                percentage=0.5) 
{

  if (DEBUG) 
  {
    echo ("Radio=", radio);
    echo ("Roundness=", roundness);
    echo ("Thickness=", thickness);
    echo ("Hole radio=", hole_radio);
    echo ("Hole notch_radio=", hole_notch_radio);
    echo ("Percentage=", percentage); 
  }

  if (roundness > 0) 
  {
    minkowski() 
    {
      _sphere_with_notched_hole(radio-roundness, thickness-2*roundness, 
                              hole_radio+roundness,
                              hole_notch_radio-roundness, percentage);
      sphere(r=roundness, $fn=10, center=true);
    }
  }
  else 
  {
    _sphere_with_notched_hole(radio, thickness, hole_radio, hole_notch_radio,
                            percentage);
  }
}

// sphere's radio.
RADIO = 8.5;

// sphere's thickness
THICKNESS = 2;

// sphere's roundness
ROUNDNESS = 0;

// sphere's hole radio.
HOLE_RADIO = 2.5;

// sphere's hole has a notch with this radio.
HOLE_NOTCH_RADIO = 0.7;

// sphere's percentage (0 - no sphere, 0.5 half sphere, 0.75 3/4 sphere, 
// 1 whole sphere)
PERCENTAGE = 0.6;

// Show debug info on output console and draw auxiliary geometry to check.
DEBUG=true;

// Example 1.
sphere_with_notched_hole(radio=RADIO, roundness=ROUNDNESS, 
                         thickness=THICKNESS,
                         hole_radio=HOLE_RADIO, 
                         hole_notch_radio=HOLE_NOTCH_RADIO, 
                         percentage=PERCENTAGE);

