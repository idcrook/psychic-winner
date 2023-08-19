////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2023-Aug-17
//
// Author:
//   David Crook
//
// Revisions/Notes:
//  - based on jpg from website
//
////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////
// RENDERS

use <../libraries/MCAD/2Dshapes.scad>

e = 1/128;

b_z = 2.5;

d_x = 107.9 ;
d_y = 107.9 ;
d_z = 6.5;

add_padding = !true;

pad_x = add_padding ? 5 : 0;
pad_y = add_padding ? 5 : 0;


module invert() {
  difference () {
    square([d_x, d_y]);
    translate([-1.05, -1.05])
    import("cam-logo2-retina-trace.svg", center = true);
  }

}

module extruded(h = 5) {
  linear_extrude(height=h)
    invert();
}


print_face = !true;
print_base = !print_face;
base_as_circle = !true;

if (print_base) {
  if (base_as_circle) {
    translate([d_x/2 , d_y/2 , 0])
      linear_extrude(height=b_z)
      circle(d = d_x + 2*pad_x, $fn = 50);
  } else {
    translate([-pad_x, -pad_y, 0])
      linear_extrude(height=b_z)
      roundedSquare(pos=[d_x + 2*pad_x, d_y + 2*pad_y], r=3.5);
  }
 } else {
  translate([0,0, b_z])
    extruded(h = d_z);
 }
