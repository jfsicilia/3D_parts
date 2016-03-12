use <cylinder_with_notch.scad>

module link(radio = 10, height = 30, notch_radio = 2,
            slot_width=0.5, slot_height=10) {
  
  difference() {
    cylinder_with_notch(radio, height, notch_radio);
    for (i = [-1, 1])
      for (j = [-1, 1]) {
        // Subtract cube to make slot. 
        translate([0,0,i*(-height/2-(slot_height+10)/2+slot_height)])
          rotate([0, 0, j*45])
            cube([2*radio+10, slot_width, slot_height+10], center=true);
        // Subtract cylinder to let slot end in semi-circle.
        translate([0, 0, i*(-height/2+slot_height)])
          rotate([90, 0, j*45])
            cylinder(r=slot_width/2,h=2*radio+10,center=true, $fn=10);
      }
  }
} 
// link's radio.
RADIO = 2.5;

// link's height.
HEIGHT = 40;

// link's notch radio.
NOTCH_RADIO = 0.6;

// Link's slot width.
SLOT_WIDTH = 0.5;

// Link's slot height.
SLOT_HEIGHT = 10;

// Show debug info on output console and draw auxiliary geometry to check.
DEBUG=true;

if (DEBUG) {
  echo ("Radio=", RADIO);
  echo ("Height=", HEIGHT);
  echo ("Notch radio=", NOTCH_RADIO);
}

link(radio=RADIO, height=HEIGHT, notch_radio=NOTCH_RADIO,
     slot_width=SLOT_WIDTH, slot_height=SLOT_HEIGHT);
