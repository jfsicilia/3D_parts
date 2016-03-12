use <cylinder_with_notch.scad>

module copy_mirror(vec=[0,1,0]) {
  children();
  mirror(vec) children();
}

module support(length=80, link_radio=2.5, link_slot_height=10, thickness=2, gap=2,
               flange_length=8, notch_radio = 0.5) {

  socket_width = link_radio + thickness;
  socket_height = link_slot_height + thickness;  
  flange_radio = thickness + gap;

  copy_mirror([1,0,0]) {
    // Top part or the support's border flanges.
    translate([-length/2+flange_length/2,0,socket_height/2-thickness/2+2*flange_radio])
      cube([flange_length,2*socket_width,thickness], center=true);
    // Half cylinder to make support's border flanges
    translate([-length/2,0,socket_height/2+flange_radio])
      rotate([90,0,0])
        difference() {
          cylinder(r=flange_radio, h=2*socket_width, $fn=50, center=true);
          cylinder(r=gap, h=2*socket_width+10, $fn=50, center=true);
          translate([(flange_radio+10)/2,0,0])
            cube([flange_radio+10,flange_radio+10,2*socket_width+10], center=true);
        }
  }
  // Base of the support.
  translate([0,0,thickness/2+socket_height/2])
    cube([length, 2*socket_width, thickness], center=true);
  // Hollow cylinder to receive link.
  difference() {
    cube([2*socket_width, 2*socket_width, socket_height], center=true);
//    cylinder(r=socket_width, h=socket_height, $fn=50, center=true);
    translate([0,0,-(link_slot_height+10)/2+link_slot_height/2])
      rotate([0,0,-90])
        cylinder_with_notch(radio=link_radio, height=link_slot_height+10, notch_radio=notch_radio);
  }
  
}

// Support's length.
LENGTH = 80;

// Support's thickness
THICKNESS = 2;

// Support's paper gap.
GAP = 2;

// Support's roundness
ROUNDNESS = 0;

// Support's flange length.
FLANGE_LENGTH = 8;

// Support's socket link radio.
LINK_RADIO = 2.5;

// Support's socket link slot height.
LINK_SLOT_HEIGHT = 10;

// Support's socket link notch radio.
NOTCH_RADIO = 0.5;

// Show debug info on output console and draw auxiliary geometry to check.
DEBUG=true;

support(length=LENGTH, link_radio=LINK_RADIO, 
        link_slot_height=LINK_SLOT_HEIGHT, thickness=THICKNESS, gap=GAP, 
        flange_length=FLANGE_LENGTH, notch_radio=NOTCH_RADIO);
