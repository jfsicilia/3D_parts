// 
// Creates 4 rods set holder. The holder consists in a set of 4 sliced 
// cylinders that will clamp the rods. The cylinders are set in two pairs,
// one on top and the other on the bottom. The pairs are rotate 90º between
// them. On top of the top pair, is placed a half ring that will be used to
// attach a string.
//
use <../lib/hollow_cylinder.scad>
use <../lib/copy_mirror.scad>

// Rod radio.
RADIO = 5.8/2;

// Thickness of piece.
THICKNESS = 1.5;

// Height of the holder.
HEIGHT = 4*RADIO + 3*THICKNESS;

// The holder will be a percentage of a whole cylinder. 50: half cylinder,
// 100: whole cylinder, 75: 3/4 of cylinder.
PERCENTAGE = 70;

// Radio of the half ring for string attachment.
RING_RADIO = 4;

// Creates a rod holder, that is made of a hollow cylinder, sliced at the
// percentage set.
module rod_holder()
{
  difference()
  {
    hollow_cylinder(r=RADIO+THICKNESS, h=HEIGHT, t=THICKNESS, 
                    center=true, $fn=30);
    translate([0, PERCENTAGE/100 * 2*(RADIO+THICKNESS), 0])
      cube([2*(RADIO+THICKNESS)+2, 2*(RADIO+THICKNESS), HEIGHT+2], 
           center=true);
  }
}

// Rods set holder.
union()
{
  // Top rods pair holder.
  union() 
  {
    translate([-(RADIO+THICKNESS - THICKNESS/2), 
              RADIO+THICKNESS - THICKNESS/2, 0])
      rod_holder();
    translate([RADIO+THICKNESS - THICKNESS/2, 
              RADIO+THICKNESS - THICKNESS/2, 0])
      rod_holder();
  }

  // Bottom rods pair holder.
  rotate([0,90,0])
    mirror([0,1,0])
      union() 
      {
        translate([-(RADIO+THICKNESS - THICKNESS/2), 
                  RADIO+THICKNESS - THICKNESS/2, 0])
          rod_holder();
        translate([RADIO+THICKNESS - THICKNESS/2, 
                  RADIO+THICKNESS - THICKNESS/2, 0])
          rod_holder();
      }

  // Half ring for string attachment. Goes above top rods pair holder.
  rotate([0, 90, 0])
    translate([0, -1+PERCENTAGE/100 * 2*(RADIO+THICKNESS), 0])
      hollow_cylinder(r=RING_RADIO, h=THICKNESS, t=THICKNESS, 
                      center=true, $fn=30);
}
