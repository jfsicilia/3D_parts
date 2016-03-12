//
// Returns the union of two perpendicular cylinders placed on the origin,
// resting on the XY plane. z parameter lets move the cylinders on the Z axe.
// Params:
//   z -- Z offset of the cylinders.
//   radio -- Radio of the cylinders.
//   height -- Height of the cylinders.
//
module hole_cylinders(z=0, radio=20, height=100) {
  translate([0,0,z])
  union() {
    rotate([90,0,0])
        cylinder(r=radio, h=height, $fn=100, center=true);
    rotate([90,0,90])
        cylinder(r=radio, h=height, $fn=100, center=true);
  }
}

//
// Returns a frame with n_holes.
// Params:
//   n_holes -- Number of holes in one side of the frame.
//   width -- Total width of the frame (frame has square footprint).
//   roundness -- If greater than 0 is used as the radio for smoothing edges.
//   thickness -- Thickness of the frame.
//   hole_offset -- Distance of the hole to borders of the frame.
//   hole_radio -- Hole's radio.
//   hole_dist -- Distance between two hole centers.
//
module __frame(n_holes=3, width=30, roundness=1, thickness=2, hole_offset=0,
               hole_radio, hole_dist) {

  // Frame's height.
  height=(n_holes-1)*hole_dist + 2*hole_radio + 2*hole_offset + 2*thickness;
  
  if (DEBUG) {
    echo ("frame(num=", n_holes, ", wdt=", width, ", rnd=", roundness, 
          ", thk=", thickness, "off=", hole_offset);
    echo ("Hole diam: ", hole_radio*2);
    echo ("Hole radio: ", hole_radio);
    echo ("Hole distance: ", hole_dist);
    echo ("Hole offset: ", hole_offset);
    echo ("Width: ", width);
    echo ("Height: ", height);
  }

  difference() {
    // Hollow frame and inner flanges.
    union() {
      // Create initial hollow frame.
      difference() {
        cube([width-2*roundness, width-2*roundness, height-2*roundness],
             center=true);
        cube([width+2*roundness-2*thickness, 
              width+2*roundness-2*thickness, 
              height+10], 
             center=true);
      }
      // Create inner flanges.
      difference() {
        // Inner flanges are 4 cilinders intersected with diagonal narrow 
        // cubes.
        union () {
          cyl_center=width/2-(2*roundness+thickness-2*roundness+hole_offset);
          cyl_radio=hole_radio*(sqrt(2)-1)-roundness;
          for (i = [-1, 1])
            for (j = [-1, 1]) {
              union() {
                intersection() {
                    translate([i*cyl_center,j*cyl_center,0])
                      cylinder(r=cyl_radio, h=height-2*roundness, 
                               center=true, $fn=100);
                    rotate([0, 0, (90-i*90)+(45*i*j)])
                      translate([width/4*sqrt(2),0,0])
                        cube([width/2*sqrt(2), 
                              thickness-2*roundness, 
                              height-2*roundness], 
                             center=true);
                }
                rotate([0, 0, (90-i*90)+(45*i*j)])
                  translate([width/4*sqrt(2)+hole_radio+cyl_radio,0,0])
                    cube([width/2*sqrt(2), 
                          thickness-2*roundness, 
                          height-2*roundness], 
                         center=true);
              }
            }
        }
        // Erase everything beyond the frame.
        difference() {
          cube([2*width,2*width,height+8], center=true);
          cube([width-2*roundness,width-2*roundness,height+10], center=true);
        }
      }
    }
    // Let subtract the hole_cylinders.
    for (i = [-(n_holes-1)/2:(n_holes-1)/2])
      hole_cylinders(z=i*hole_dist, radio=hole_radio+roundness, 
                     height=width+10);
  }
}

//
// Returns a frame with n_holes.
// Params:
//   n_holes -- Number of holes in one side of the frame.
//   width -- Total width of the frame (frame has square footprint).
//   roundness -- If greater than 0 is used as the radio for smoothing edges.
//   thickness -- Thickness of the frame.
//   hole_offset -- Distance of the hole to borders of the frame.
//   hole_separation -- Type of hole separation:
//     single: hole_radio*2 + thickness
//     double: hole_radio*2 + thickness*2
//     none: hole_radio * 1.75
//
module _frame(n_holes=3, width=30, roundness=1, thickness=2, hole_offset=0,
              hole_separation="none") {
  // Hole radio.
  hole_radio=(width-2*(thickness+hole_offset))/2;

  // Distance between holes.
  if (hole_separation == "none")
    __frame(n_holes, width, roundness, thickness, hole_offset, 
            hole_radio, hole_radio*1.75); 
  else if (hole_separation == "single")
    __frame(n_holes, width, roundness, thickness, hole_offset, 
            hole_radio, hole_radio*2+thickness); 
  else 
    __frame(n_holes, width, roundness, thickness, hole_offset, 
            hole_radio, hole_radio*2+thickness*2); 

  // Show debug geometry.
  if (DEBUG) {
    %rotate([90,0,90])
      cylinder(r=hole_radio, h=200, $fn=100, center=true);
    %rotate([90,0,0])
      cylinder(r=hole_radio, h=200, $fn=100, center=true);
    %cylinder(r=hole_radio, h=200, $fn=100, center=true);
  }
}

//
// Returns a frame with n_holes.
// Params:
//   n_holes -- Number of holes in one side of the frame.
//   width -- Total width of the frame (frame has square footprint).
//   roundness -- If greater than 0 is used as the radio for smoothing edges.
//   thickness -- Thickness of the frame.
//   hole_offset -- Distance of the hole to borders of the frame.
//   hole_separation -- Type of hole separation:
//     single: hole_radio*2 + thickness
//     double: hole_radio*2 + thickness*2
//     none: hole_radio * 1.75
//
module frame(n_holes=3, width=30, roundness=1, thickness=2, 
             hole_offset=0, hole_separation="none") {
  if (roundness > 0) {
    minkowski() { 
      _frame(n_holes, width, roundness, thickness, hole_offset,
             hole_separation);
      sphere(r=roundness, center=true, $fn=10);
    }
  }
  else {
    _frame(n_holes, width, roundness, thickness, hole_offset, 
           hole_separation);
  }
}

// Frame's holes.
HOLES = 3;

// Frame's width.
WIDTH=30;

// Frame's border radio roundness.
ROUNDNESS=0;

// Frame's thickness
THICKNESS=4;

// Frame's hole offset from inner sides.
HOLE_OFFSET=0;

// Frame's hole separation: 
//   single: hole_radio*2 + thickness
//   double: hole_radio*2 + thickness*2
//   none: hole_radio * 1.75
HOLE_SEPARATION="double";

// Show debug info on output console and draw auxiliary geometry to check.
DEBUG=true;

// Create a frame with global parameters.
frame(n_holes=HOLES, 
      width=WIDTH, 
      roundness=ROUNDNESS, 
      thickness=THICKNESS, 
      hole_offset=HOLE_OFFSET,
      hole_separation=HOLE_SEPARATION);

