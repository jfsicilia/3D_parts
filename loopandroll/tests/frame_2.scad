// Frame's holes (must be odd).
n_holes = 9;

// Frame's width.
width=30;


// Frame's border radio roundness.
roundness=1;

// Frame's thickness
thickness=2;

// Frame's hole offset to inner sides.
hole_offset=1;

// Hole diameter.
hole_diam=width-2*(thickness+hole_offset);
echo("Hole diameter: ", hole_diam);

// Real remaining hole diameter.
real_hole_diam=hole_diam-2*thickness/2;


hole_dist = hole_diam*2/5;

// Frame's height.
height=(n_holes-1)*hole_dist + hole_diam + 2*hole_offset + 2*thickness;

module hole_cylinders(z=0) {
  translate([0,0,z])
  union() {
    rotate([90,0,0])
      difference() {
        cylinder(r=hole_diam/2, h=100, $fn=50, center=true);

        color("red")
          rotate_extrude(angle=360)
            translate([hole_diam/2,(width/2)-(thickness/2)])  
              circle(r=thickness/2, $fn=20);
        color("red")
          rotate_extrude(angle=360)
            translate([hole_diam/2,-((width/2)-(thickness/2))])  
              circle(r=thickness/2, $fn=20);
      }
    rotate([90,0,90])
      difference() {
        cylinder(r=hole_diam/2, h=100, $fn=50, center=true);

        color("red")
          rotate_extrude(angle=360)
            translate([hole_diam/2,(width/2)-(thickness/2)])  
              circle(r=thickness/2, $fn=20);
        color("red")
          rotate_extrude(angle=360)
            translate([hole_diam/2,-((width/2)-(thickness/2))])  
              circle(r=thickness/2, $fn=20);
      }
  }
}

difference() {
  difference() {
    minkowski() { 
      cube([width-2*roundness,width-2*roundness,height-2*roundness], center=true);
      sphere(r=roundness, $fn=20);
    }
    minkowski() { 
      cube([width-2*(roundness+thickness),width-2*(roundness+thickness),height], center=true);
      sphere(r=roundness, $fn=20);
    }
  }
  for (i = [-(n_holes-1)/2:(n_holes-1)/2])
    hole_cylinders(i*hole_dist);
}
*difference() {
  cube([10,10,100], center=true);

  color("blue") 
    minkowski() { 
      cube([8,8,80], center=true);
      sphere(r=1.05, $fn=20, center=true);
    }
}
*color("red")
  cube([width-0.3,width-0.3,height+10], center=true);
*color("blue")
  cube([width+2,width+2,height+10], center=true);

*color("green")
  cube([width+1,width+1,height+15], center=true);
