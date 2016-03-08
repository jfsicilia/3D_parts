// 
// 
//
module _ball(radio=10, thickness=2) {

  union() {
    difference () {
      sphere(r=radio, $fn=100, center=true);
      sphere(r=radio-thickness, $fn=100, center=true);
      translate([0,0, -2*radio/2*1.25])
        cube([2*radio+10, 2*radio+10, 2*radio], center=true);
    }
    translate([0, 0, 1.5*radio-thickness])
      cube([4, thickness, radio], center=true);
    translate([0, 0, 1.5*radio-thickness])
      cube([thickness, 4, radio], center=true);
  }
}

//
//
//
module ball(radio=10, roundness=1, thickness=2) {

  if (debug) {
    echo ("Radio=", radio);
    echo ("Roundness=", roundness);
    echo ("Thickness=", thickness);
  }

  if (roundness > 0) {
    //minkowski() {
      _ball(radio-roundness, thickness-2*roundness);
      sphere(r=roundness, $fn=10, center=true);
    //}
  }
  else {
    _ball(radio, thickness);
  }

  if (debug) {
  }
}

// ball's radio.
b_radio = 11;

// joint's thickness
b_thickness = 2.5;

// joint's roundness
b_roundness = 0;

// joint's slot width.
b_slot_width = 1;

// Show debug info on output console and draw auxiliary geometry to check.
debug=true;

ball(radio=b_radio, roundness=b_roundness, thickness=b_thickness);
