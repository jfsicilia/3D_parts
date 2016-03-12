//
// Makes a joint (cylinder with slots).
// Params:
//   radio -- Cylinder radio.
//   height -- Height of the cylinder.
//   thickness -- Thickness of cylinder.
//   slot_width -- Width of the slots of the cylinder.
//   slot_offset -- Offset from top or bottom where the slot starts.
//
module _joint(radio=10, height=60, thickness=2, slot_width=1, slot_offset=6) {

  difference () {
    // Solid part.
    cylinder(r=radio, h=height, center=true, $fn=100);
    // Subtract cylinder to make part hollow. 
    cylinder(r=radio-thickness, h=height+10, center=true, $fn=100);
    // Make 4 slots (90º separation) in the upper side and 4 slots in the
    // bottom side. Upper and bottom slots are shifted 45º.
    for (i = [0, 1])
      for (j = [-1, 1]) {
        // Subtract cube to make slot. 
        translate([0,0,j*slot_offset])
          rotate([0, 0, 22.5 + 90*i + 22.5*j])
            cube([2*radio+10, slot_width, height], center=true);
        // Subtract cylinder to let slot end in semi-circle.
        translate([0, 0, (-j)*height/2+j*slot_offset])
          rotate([90, 0, 22.5 + 90*i + 22.5*j])
            cylinder(r=slot_width/2,h=2*radio+10,center=true, $fn=100);
      }
  }
}

//
// Makes a joint (cylinder with slots).
// Params:
//   radio -- Cylinder radio.
//   height -- Height of the cylinder.
//   roundness -- If greater than 0 is used as the radio for smoothing edges.
//   thickness -- Thickness of cylinder.
//   slot_width -- Width of the slots of the cylinder.
//   slot_offset -- Offset from top or bottom where the slot starts.
//
module joint(radio=10, height=38, roundness=1, thickness=2, slot_width=3, 
             slot_offset=6) {

  if (DEBUG) {
    echo ("Radio=", radio);
    echo ("Height=", height);
    echo ("Roundness=", roundness);
    echo ("Thickness=", thickness);
    echo ("Slot width=", slot_width);
    echo ("Slot offset=", slot_offset);
    echo ("Sphere radio=", radio-thickness+1);
  }

  difference() {
    if (roundness > 0) {
      minkowski() {
        _joint(radio-roundness, height-2*roundness, thickness-2*roundness, 
              slot_width+2*roundness, slot_offset-2*roundness);
        sphere(r=roundness, $fn=10, center=true);
      }
    }
    else {
      _joint(radio, height, thickness, slot_width, slot_offset);
    }
    // Makes sockets for ball bearing.
    for (i = [-1, 1]) { 
        translate([0,0, i*(height/2-1-sqrt(2*(radio-thickness)+1))])
          sphere(r=radio-thickness+1, $fn=100, center=true);
    }
  }

  if (DEBUG) {
    // Shows sphere that makes sockets for ball bearing.
    for (i = [-1, 1]) { 
      %translate([0,0, i*(height/2-1-sqrt(2*(radio-thickness)+1))])
        sphere(r=radio-thickness+1, $fn=100, center=true);
    }
  }
}

// joint's radio.
RADIO = 11;

// joint's height.
HEIGHT = 60;

// joint's thickness
THICKNESS =  2.5 ;

// joint's roundness
ROUNDNESS = 0;

// joint's slot width.
SLOT_WIDTH = 1;

// joint's slot offset.
SLOT_OFFSET = HEIGHT / 3;

// Show debug info on output console and draw auxiliary geometry to check.
DEBUG=true;

joint(radio=RADIO, height=HEIGHT, roundness=ROUNDNESS, 
      thickness=THICKNESS, slot_width=SLOT_WIDTH, 
      slot_offset=SLOT_OFFSET);
