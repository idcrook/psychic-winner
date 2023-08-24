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
include <../libraries/BOSL2/std.scad>

e = 1/128;

as_coaster = true;
add_padding = false;
add_fill_concentric = true;
add_music_notes = true;

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

center_svg = [d_x/2 - 1.75, d_y/2 - 1.35];

module invert() {
  difference () {
    square([d_x, d_y]);
    translate([-1.05, -1.05])
    import("cam-logo2-retina-trace.svg", center = true);
  }

}

module fill_concentric () {
  // right half
  path1 = arc(cp = center_svg, n=15, start=15 - 90, r=40, angle=180 - 2*15);
  stroke(path1);

  path2 = arc(cp = center_svg, n=15, start=10 - 90, r=44, angle=180 - 2*10);
  stroke(path2);

  path3 = arc(cp = center_svg, n=15, start=5 - 90, r=48, angle=180 - 2*5);
  stroke(path3);

  path4 = arc(cp = center_svg, n=36, start=0 - 90, r=52 + 1.4, angle=180 - 2*0);
  stroke(path4);

  // left half
  path5 = arc(cp = center_svg, n=15, start=15 - 90 + 180, r=40, angle=180 - 2*15);
  stroke(path5);

  path6 = arc(cp = center_svg, n=15, start=10 - 90 + 180, r=44, angle=180 - 2*10);
  stroke(path6);

  path7 = arc(cp = center_svg, n=15, start=5 - 90 + 180, r=48, angle=180 - 2*5);
  stroke(path7);

  path8 = arc(cp = center_svg, n=36, start=0 - 90 + 180, r=52 + 1.4, angle=180 - 2*0);
  stroke(path8);
}

module musical_notes () {
    translate([72.5, 32.2])
      scale([0.122, 0.122])
      import("quarter-notes.svg", center = true);
}

module extruded(h = 5) {
  linear_extrude(height=h)
    union () {
    invert();
    if (add_fill_concentric) {
      fill_concentric();
    }
    if (add_music_notes) {
      musical_notes();
    }
  }
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
      translate(center_svg)
      linear_extrude(height=b_z)
      circle(d = d_x + 2*pad_x, $fn = 50);
  } else {
    translate([-pad_x, -pad_y, 0])
      translate(center_svg)
      linear_extrude(height=b_z)
      roundedSquare(pos=[d_x + 2*pad_x, d_y + 2*pad_y], r=4.5);
  }
 }

scale([scale_x, scale_y, 1.00])
if (print_face) {
  translate([0,0, face_suspend])
    extruded(h = d_z);
 }
