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

shrink = true;
add_padding = true;

b_z = 2.0;
face_height = 2.5;
face_suspend = 1.0;

svg_scale = 0.10;
t_d_x = 47.8;
t_d_y = 66.898;

d_x = 70.59 ;
d_y = 108.512 ;
// Intended for plating extruded design 1.0 mm above bed/base
d_z = (b_z - face_suspend) + face_height;


pad_x = add_padding ? 4 : 0;
pad_y = add_padding ? 4 : 0;

scale_x = shrink ? 0.86 : 1.0;
scale_y = shrink ? 0.86 : 1.0;

module position() {
  // difference () {
  //   square([d_x, d_y]);
  translate([t_d_x, t_d_y])
  scale ([svg_scale, svg_scale])
  import("sticker1-trace.svg", center = true);
  //}

}

module extruded(h = 3.0) {
  linear_extrude(height=h)
    position();
}


print_face = true;
print_base = !print_face;
base_as_circle = !true;

if (print_face) {
  echo ("Face extruded height: ", d_z);
 }

scale([scale_x, scale_y, 1.00])
if (print_base) {
      translate([d_x / 2, d_y / 2, 0])
      linear_extrude(height=b_z)
      roundedSquare(pos=[d_x + 2*pad_x, d_y + 2*pad_y], r=3.5);
 }

scale([scale_x, scale_y, 1.00])
if (print_face) {
  translate([0,0, face_suspend])
    extruded(h = d_z);
 }
