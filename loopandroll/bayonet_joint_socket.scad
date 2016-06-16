use <copy_mirror.scad>

module _single_socket(radio=11, height=16, sphere_radio=1.8, offset=1, $fn=50) {

  rotate([0,0,45])
    rotate_extrude(angle=45) 
      translate([radio,0,0])
        circle(r=sphere_radio, $fn=$fn);
  for (i = [0:1]) 
    rotate([0,0,i*(-45)])
      translate([0,radio,0])
        sphere(r=SPHERE_RADIO, center=true, $fn=$fn);
  translate([0,radio,-(height/2-2)/2-offset])
    cylinder(r=sphere_radio, h=height/2+offset, center=true, $fn=$fn);
}

module bayonet_joint_socket(radio=11, height=16, sphere_radio=1.8, $fn=20) {
  OFFSET=1;

  difference() {
    union() {
      _single_socket(radio=radio, height=height, sphere_radio=sphere_radio, offset=OFFSET, $fn=$fn);
      mirror([1,0,0])
        mirror([0,1,0])
          _single_socket(radio=radio, height=height, sphere_radio=sphere_radio, offset=OFFSET, $fn=$fn);
    }
    // Delete inner part.
    cylinder(r=radio-OFFSET, h=height+10, center=true);
  }

}

RADIO=11;

HEIGHT=8;

SPHERE_RADIO=2;

DEBUG=true;

bayonet_joint_socket(radio=RADIO, height=HEIGHT, sphere_radio=SPHERE_RADIO);


