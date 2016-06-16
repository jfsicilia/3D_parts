//
// Makes a copy of the children and a mirror of them.                       
// Params:
//  vec -- [x,y,z] mirror plane.
//
module copy_mirror(vec=[0,1,0]) {
  children();
  mirror(vec) children();
}


// Example.
copy_mirror([1,1,0])
  translate([10,10,0])
    cube([10,20,30]);
