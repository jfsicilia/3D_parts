use <cylinder_with_notch.scad>
// 
//
//
module _ball(radio=10, thickness=2, hole_radio=2) {

  union() {
    difference () {
      // Main sphere.
      sphere(r=radio, $fn=100, center=true);
      // Make sphere hollow.
      sphere(r=radio-thickness, $fn=100, center=true);
      // Erase 60% of the lower half of the sphere.
      translate([0,0, -2*radio/2*1.4])
        cube([2*radio+10, 2*radio+10, 2*radio], center=true);
      // Make hole on top of sphere.
      cylinder_with_notch(radio=hole_radio, height=radio*2+10, 
                          notch_radio=0.5);
    }
  }
}

//
//
//
module ball(radio=10, roundness=1, thickness=2, hole_radio=2, 
            hole_notch_radio) {

  if (DEBUG) {
    echo ("Radio=", radio);
    echo ("Roundness=", roundness);
    echo ("Thickness=", thickness);
    echo ("Hole radio=", hole_radio);
  }

  if (roundness > 0) {
    minkowski() {
      _ball(radio-roundness, thickness-2*roundness, hole_radio+roundness, 
            hole_notch_radio-roundness);
      sphere(r=roundness, $fn=10, center=true);
    }
  }
  else {
    _ball(radio, thickness, hole_radio, hole_notch_radio);
  }
}

// ball's radio.
RADIO = 8.5;

// ball's thickness
THICKNESS = 2;

// ball's roundness
ROUNDNESS = 0;

// ball's hole radio.
HOLE_RADIO = 2.5;

// ball's hole has a notch with this radio.
HOLE_NOTCH_RADIO = 0.5;

// Show debug info on output console and draw auxiliary geometry to check.
DEBUG=true;

ball(radio=RADIO, roundness=ROUNDNESS, thickness=THICKNESS,
     hole_radio=HOLE_RADIO, hole_notch_radio=HOLE_NOTCH_RADIO);

