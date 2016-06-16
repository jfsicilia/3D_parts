WIDTH=2;

HEIGHT=100;

SIDES_HEIGHT=8;

SIDES_RADIO=2;

SIDES_WIDTH=4;

CYLINDER_DIAM = 36;

CYLINDER_RADIO = CYLINDER_DIAM / 2;

// 2D points of the cylinder section.
SECTION_POINTS = [[0, -HEIGHT/2],
                  [-SIDES_WIDTH, -HEIGHT/2],
                  [-SIDES_WIDTH, -HEIGHT/2 + SIDES_HEIGHT],
                  [-(SIDES_WIDTH-WIDTH), 
                    -HEIGHT/2 + SIDES_HEIGHT + 2*(SIDES_WIDTH-WIDTH)],
                  [-(SIDES_WIDTH-WIDTH), 
                    +HEIGHT/2 - SIDES_HEIGHT - 2*(SIDES_WIDTH-WIDTH)],
                  [-SIDES_WIDTH, +HEIGHT/2 - SIDES_HEIGHT],
                  [-SIDES_WIDTH, +HEIGHT/2],
                  [0, +HEIGHT/2]];


SECTOR_ANGLE = 360/12;    

SECTOR_POINTS = [[0, -HEIGHT/2-1], 
                 [-SIDES_WIDTH/2 - 1, -HEIGHT/2-1],
                 [-SIDES_WIDTH/2 - 1, +HEIGHT/2+1],
                 [0, +HEIGHT/2+1]];

difference()
{
rotate_extrude($fn=60)
  translate([CYLINDER_RADIO,0,0])
    polygon(SECTION_POINTS);

for (i = [0, 90, 180, 270])
{
rotate([0,0,i])
  rotate([0,0,-SECTOR_ANGLE/2])
    rotate_extrude(angle=SECTOR_ANGLE, $fn=60)
      translate([CYLINDER_RADIO - SIDES_WIDTH/2, 0, 0])
        polygon(SECTOR_POINTS);
}
}
      
        
          
            
//*rotate_extrude($fn=60)
//{
//  translate([CYLINDER_RADIO - WIDTH/2,0,0])
//  {
//    square([WIDTH, HEIGHT], center=true);
//    for (i = [-1, 1])
//    {
//      translate([-WIDTH/2 - (SIDES_WIDTH-WIDTH)/2, i * (-HEIGHT/2 + SIDES_HEIGHT/2), 0])
//        square([(SIDES_WIDTH-WIDTH), SIDES_HEIGHT], center=true);
//      translate([-WIDTH/2, i * (-HEIGHT/2 + SIDES_HEIGHT), 0])
//        circle(SIDES_RADIO, $fn=30);
//    }
//  }
//}
