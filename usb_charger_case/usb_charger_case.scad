//-------------------------------------------------------------------- 
// WARNING: This script makes use of minkowski algorithm to compute
// the shell of the case. This requires lots of math computation, it
// will take time to get the result. After computation has finished
// press F6 to view case rendered.
//-------------------------------------------------------------------- 
use <rcylinder.scad>

// Number of usb connectors/slots.
n_slots = 5;

// Dimensions of the slot for the dev.
dev_slot_width = 20;
dev_slot_height = 32;
dev_slot_sep = 10;

// Dimensions of the slot for the usb cable.
cable_slot_width = 10;
cable_slot_height = 20;

// Distance from de first/last slot to the border.
border_length = 12;

// Inner thickness of the case.
thickness = 3;

// Case width.
width = 180;
// Case length.
length = 2 * border_length + (n_slots-1) * dev_slot_sep + 
  n_slots * dev_slot_width;
// Cover height.
cover_height = dev_slot_height + 2*thickness;
// Base height.
base_height = 36;
// Height.
height = cover_height + base_height;

// Roundness of edges.
corner_radio = 5;

// Case limits.
min_X = -length/2;
min_Y = -width/2;
max_X = length/2;
max_Y = width/2;
cover_min_Z = -cover_height/2;
cover_max_Z = cover_height/2;
base_min_Z = cover_min_Z-base_height/2;
base_max_Z = base_min_Z+base_height/2;

// Roundness hull construction points.
cylinder_points = [
  [max_X-corner_radio, max_Y-corner_radio],
  [min_X+corner_radio, max_Y-corner_radio],
  [min_X+corner_radio, min_Y+corner_radio],
  [max_X-corner_radio, min_Y+corner_radio]
];

//--------------------------------------------------------------------- 
// Cube big enough to keep inside the case. Useful to get the negative
// of the case.
//--------------------------------------------------------------------- 
module universe() {
  cube([length+2,width+2,height+2], center=true);
}

//--------------------------------------------------------------------- 
// It returns the shell of the child object. Instead of an all solid
// object, it will make a hollow object with "width" thick walls.
// Params:
//   width -- Width of the walls of the shell.
//--------------------------------------------------------------------- 
module shell(width=1, $fn=4) {
  // Subtract from the original object, the "width" smaller one, to get
  // the shell.
  difference() {
    children(0);
    // Get again the original object, but "width" smaller.
    difference() {
      universe();
      // Grow the negative inwards.
      minkowski() {
        // Get the negative of the object.
        difference() {
            universe();
            children(0);
        }
        sphere(width);
      }
   }
  }
}


//--------------------------------------------------------------------- 
// Cover of the base.
//--------------------------------------------------------------------- 
module cover() {

  //------------------------------------------------------------------ 
  // Cover of the case. Solid, not hollow. 
  //------------------------------------------------------------------ 
  module cover_solid() {
    difference () {
      hull () {
        for (pos = cylinder_points)
          translate(pos)
            rcylinder(r=corner_radio, h=cover_height, both=false, center=true);
      }
      
      // Create the pieces that will create the slots.
      for (i = [0:n_slots-1]) 
        color("red")
          translate([min_X+border_length+i*(dev_slot_width+dev_slot_sep), min_Y, cover_max_Z-dev_slot_height])
            cube([dev_slot_width, width, dev_slot_height]);
    }
  }

  // Create the shell of the solid base with specified thickness,
  // then open the bottom of the shell.
  difference() {  
    shell(width=thickness)
      cover_solid();

     resize([length-6*thickness,width-2*thickness,0])
       translate([0,0,cover_min_Z])
         linear_extrude(height=thickness)
           projection() 
             cover_solid();
   }
}

//-------------------------------------------------------------------- 
// Base of the case.
//-------------------------------------------------------------------- 
module base() {
  //------------------------------------------------------------------ 
  // Base of the case. Solid, not hollow. 
  //------------------------------------------------------------------ 
  module base_solid() {
    hull () {
      for (pos = cylinder_points)
        translate(pos)
          cylinder(r=corner_radio, h=base_height, $fn=30, center=true);
    }
  }

  // It creates the hollow base ot the case and attachs 4 flanges.
  union() {
    // Base of the case.
    translate([0,0,base_min_Z]) {
      rotate([180,0,0])
        // Create the shell of the solid base with specified thickness,
        // then open the bottom of the shell.
        difference() {  
          shell(width=thickness)
            base_solid();

          resize([length-2*thickness,width-2*thickness,0])
            translate([0,0,-base_height/2])
              linear_extrude(height=thickness)
                projection() 
                  base_solid();
        }
    } 

    // Add 4 flanges to the base.
    flange_width = thickness;
    flange_length = 20;
    flange_height = base_height+3;
    flange_offset = 25;

    pos_flange_cube = [
      [min_X+thickness, min_Y+flange_offset, base_max_Z-base_height],
      [min_X+thickness, max_Y-flange_offset-flange_length, base_max_Z-base_height],
      [max_X-thickness-flange_width, max_Y-flange_offset-flange_length, base_max_Z-base_height],
      [max_X-thickness-flange_width, min_Y+flange_offset, base_max_Z-base_height]
    ];

    pos_flange_cylinder = [
      [min_X+thickness+flange_width/2, min_Y+flange_offset, base_max_Z-base_height+flange_height],
      [min_X+thickness+flange_width/2, max_Y-flange_length-flange_offset, base_max_Z-base_height+flange_height],
      [max_X-thickness-flange_width/2, max_Y-flange_offset-flange_length, base_max_Z-base_height+flange_height],
      [max_X-thickness-flange_width/2, min_Y+flange_offset, base_max_Z-base_height+flange_height]
    ];

    for (i = [0:3]) {
      translate(pos_flange_cube[i]) 
        cube([flange_width, flange_length, flange_height]);
      translate(pos_flange_cylinder[i])
        rotate([-90,0,0])  
          cylinder(r=flange_width/2, h=flange_length, $fn=20);
    }
  }
}

//-------------------------------------------------------------------- 
// Returns round cubes to drill the cable slots on the base.
// Params:
//   roundness -- Roundness of the cubes.
//-------------------------------------------------------------------- 
module cable_slots(roundness = 3) {
  // There are N+1 cable slots in the case (one more for power).
  cable_slot_sep = length/(n_slots+2);
  for (i = [1:n_slots+1])
    translate([min_X+cable_slot_sep*i, min_Y, base_min_Z])
      rotate([90,0,0])
        minkowski() { 
          cube([cable_slot_width-roundness, cable_slot_height-roundness, 20], center=true);
          sphere(r=roundness, $fn=20);
      }
}

debug = true;

// Debugging info.
if (debug) {
  echo("Width = ", width);
  echo("Length = ", length);
  echo("Height = ", height);
  echo("Cover_Height = ", cover_height);
  echo("Base_Height = ", base_height);
}

// Cover with the flanges slots.
difference() {
  cover();
  base();
}
// Base with the cable slots.
difference() {
  base();
  cable_slots();
}


