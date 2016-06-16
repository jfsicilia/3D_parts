use <negative_cylinder.scad>


module round_cube(size=10, roundness=3, center=false, $fn=20)
{
  // Get width, depth and height from size parameter.
  width = (size[0] != undef) ? size[0] : size;
  depth = (size[1] != undef) ? size[1] : size;
  height = (size[2] != undef) ? size[2] : size;

  difference() 
  {
    cube(size=size, center=center);

    for (i = [0, 180])
      for (j = [-1, 1])
        rotate([0, 0, i])
          translate([width/2-(roundness-2), 0, j * (height/2-(roundness-2))])
            rotate([0, -45 - j*45, 0])
            rotate([90, 0, 0])
              negative_cylinder(r=roundness-2, h=depth+2, t=2, angle=90, center=true, $fn=30);
    for (i = [90, 270])
      for (j = [-1, 1])
        rotate([0, 0, i])
          translate([depth/2-(roundness-2), 0, j * (height/2-(roundness-2))])
            rotate([0, -45 - j*45, 0])
            rotate([90, 0, 0])
              negative_cylinder(r=roundness-2, h=width+2, t=2, angle=90, center=true, $fn=30);

    for (i = [0, 180])
      rotate([0, 0, i])
        translate([width/2-(roundness-2), -depth/2+(roundness-2), 0])
          negative_cylinder(r=roundness-2, h=height+2, t=2, angle=90, center=true, $fn=30);

    for (i = [90, 270])
      rotate([0, 0, i])
        translate([-depth/2+(roundness-2), width/2-(roundness-2),  0])
          rotate([0,0,180])
          negative_cylinder(r=roundness-2, h=height+2, t=2, angle=90, center=true, $fn=30);
  }
}

SIZE = [10, 20, 30];


ROUNDNESS = 3;

round_cube(size=SIZE, roundness=ROUNDNESS, center=true, $fn=$fn);
