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

as_coaster = true;
add_padding = false;

b_z = 2.5;
face_height = 3.0;
face_suspend = 1.0;

d_x = 107.9 ;
d_y = 107.9 ;
// Intended for plating extruded design 1.0 mm above bed/base
d_z = (b_z - face_suspend) + face_height;


pad_x = add_padding ? 5 : 0;
pad_y = add_padding ? 5 : 0;

scale_x = as_coaster ? 0.86 : 1.0;
scale_y = as_coaster ? 0.86 : 1.0;

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


print_face = true;
print_base = !print_face;
base_as_circle = !true;

if (print_face) {
  echo ("Face extruded height: ", d_z);
 }

scale([scale_x, scale_y, 1.00])
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
 }

scale([scale_x, scale_y, 1.00])
if (print_face) {
  translate([0,0, face_suspend])
    extruded(h = d_z);
 }
