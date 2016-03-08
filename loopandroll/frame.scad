//
// Returns the union of two perpendicular cylinders placed on the origin,
// resting on the XY plane. z parameter lets move the cylinders on the Z axe.
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
// Private function. Returns a frame with n_holes.
//
module _frame(n_holes=3, width=30, roundness=1, thickness=2, hole_offset=0) {
  // Hole diameter.
  //hole_diam=width-2*(thickness+hole_offset+roundness);
  hole_diam=width-2*(thickness+hole_offset);

  // Hole radio.
  hole_radio=hole_diam/2;

  // Distance between holes.
  //hole_dist = (hole_radio-roundness)*1.5;
  hole_dist = (hole_radio)*1.75;
  //hole_dist = (hole_radio-2*roundness)*sqrt(2);

  // Frame's height.
  height=(n_holes-1)*hole_dist + hole_diam + 2*hole_offset + 2*thickness;
  
  if (debug) {
    echo ("frame(num=", n_holes, ", wdt=", width, ", rnd=", roundness, ", thk=", thickness, "off=", hole_offset);
    echo ("Hole diam: ", hole_diam);
    echo ("Hole radio: ", hole_radio);
    echo ("Hole distance: ", hole_dist);
    echo ("Hole offset: ", hole_offset);
    echo ("Width: ", width);
    echo ("Height: ", height);
  }

  difference() {
    union() {
      // Create initial hollow frame.
      difference() {
        cube([width-2*roundness, width-2*roundness, height-2*roundness], center=true);
        cube([width+2*roundness-2*thickness, width+2*roundness-2*thickness, height+10], center=true);
      }
      // Create inner flanges.
      difference() {
        // Inner flanges are 4 cilinders intersected with diagonal narrow cubes.
        union () {
          cyl_center=width/2-(2*roundness+(thickness-2*roundness)+hole_offset);
          cyl_radio=hole_radio*(sqrt(2)-1)-roundness;
          for (i = [-1, 1])
            for (j = [-1, 1]) {
              union() {
                intersection() {
                    translate([i*cyl_center,j*cyl_center,0])
                      cylinder(r=cyl_radio, h=height-2*roundness, center=true, $fn=100);
                    rotate([0, 0, (90-i*90)+(45*i*j)])
                      translate([width/4*sqrt(2),0,0])
                        cube([width/2*sqrt(2), thickness-2*roundness, height-2*roundness], center=true);
                }
                rotate([0, 0, (90-i*90)+(45*i*j)])
                  translate([width/4*sqrt(2)+hole_radio+cyl_radio,0,0])
                    cube([width/2*sqrt(2), thickness-2*roundness, height-2*roundness], center=true);
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
      hole_cylinders(z=i*hole_dist, radio=hole_radio+roundness, height=width+10);
  }

  // Show a pair of cylinders to check geometry.
  if (debug) {
    #color("red")
      rotate([90,0,90])
      cylinder(r=hole_radio, h=200, $fn=100, center=true);
    #color("red")
      rotate([90,0,0])
      cylinder(r=hole_radio, h=200, $fn=100, center=true);
    #color("red")
      cylinder(r=hole_radio, h=200, $fn=100, center=true);
  }
}

//
// Returns a frame with n_holes.
//
module frame(n_holes=3, width=30, roundness=1, thickness=2, 
             hole_offset=0) {
  if (roundness > 0) {
    minkowski() { 
      _frame(n_holes, width, roundness, thickness, hole_offset);
      sphere(r=f_roundness, center=true, $fn=10);
    }
  }
  else {
    _frame(n_holes, width, roundness, thickness, hole_offset);
  }
}

// Frame's holes.
f_holes = 4;

// Frame's width.
f_width=30;

// Frame's border radio roundness.
f_roundness=0;

// Frame's thickness
f_thickness=2.5;

// Frame's hole offset from inner sides.
f_hole_offset=0;

// Show debug info on output console and draw auxiliary geometry to check.
debug=false;

// Create a frame with global parameters.
frame(n_holes=f_holes, 
      width=f_width, 
      roundness=f_roundness, 
      thickness=f_thickness, 
      hole_offset=f_hole_offset);

