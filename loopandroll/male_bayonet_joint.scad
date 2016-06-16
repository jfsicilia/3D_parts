use <hollow_cylinder.scad>

//
//
//
module male_bayonet_joint(radio=11, height=16, thickness=2, 
                          inner_flanges=true, flanges_thickness=3,
                          flanges_separation=2,
                          sphere_radio=1.8, sphere_offset=4) 
{
  union() 
  {
    difference() 
    {
      union() 
      {
        hollow_cylinder(r=radio, h=height, t=thickness, center=true, $fn=30); 
        if (inner_flanges)
        {
          translate([0, flanges_thickness/2 + flanges_separation/2, 0])
            cube([2*radio, flanges_thickness, height], center=true);
          translate([0, -(flanges_thickness/2 + flanges_separation/2), 0])
            cube([2*radio, flanges_thickness, height], center=true);
        }
      }
      hollow_cylinder(r=radio, h=height, t=thickness, inwards=false, 
                      center=true, $fn=30);
    }

    for (i = [-1, 1])  
      for (j = [-1, 1])  
        translate([i*radio, 0, -j*height/2+j*sphere_offset])
          sphere(r=sphere_radio, center=true, $fn=20);

  }
}

RADIO=10.5;

HEIGHT=16;

THICKNESS=2;

INNER_FLANGES=true;

FLANGES_THICKNESS=3;

FLANGES_SEPARATION=2;

SPHERE_RADIO=1.8;

SPHERE_OFFSET=HEIGHT/4;

DEBUG=true;

male_bayonet_joint(radio=RADIO, height=HEIGHT, thickness=THICKNESS, 
                   inner_flanges=INNER_FLANGES, 
                   flanges_thickness=FLANGES_THICKNESS,
                   flanges_separation=FLANGES_SEPARATION,
                   sphere_radio=SPHERE_RADIO, sphere_offset=SPHERE_OFFSET);

if (DEBUG)
{
  translate([30, 0, 0])
    male_bayonet_joint(radio=8, height=22, thickness=4, 
                      inner_flanges=false, 
                      sphere_radio=3, sphere_offset=3);

  translate([60, 0, 0])
    male_bayonet_joint(radio=13, height=10, thickness=1, 
                      flanges_thickness=1,
                      flanges_separation=4,
                      sphere_radio=1, sphere_offset=3);
}
