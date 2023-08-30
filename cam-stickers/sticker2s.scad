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

face_thickness = 1.8;
face_suspend = 0.5;

base_thickness = 0.8; // needs to be more than face_suspend
assert(base_thickness > face_suspend, "Need the overlap to be less than the base thickness");

base_ring_height = 1.4;
base_ring_r = 48.8;
base_ring_w = 3.6;
base_ring_a = base_ring_r - (1/2)*base_ring_w;

base_outer_r = 54.4;
//base_outer_r = 53.95;
base_ring_outer_r = base_outer_r - 1.2;
base_ring_inner_r = base_ring_outer_r - 3.4;
base_ring_outer_s_r = base_ring_outer_r - 1.7;
base_ring_inner_s_r = base_ring_inner_r;


d_x = 107.9 ;
d_y = 107.9 ;
// Intended for plating extruded design 0.5 mm into base since openscad cannot
// generate an STL with both base and face, but slicer can overlap them
d_z = face_thickness + face_suspend;

total_height = face_thickness + base_thickness + base_ring_height;

pad_x = add_padding ? 5 : 0;
pad_y = add_padding ? 5 : 0;

scale_x = as_coaster ? 0.86 : 1.0;
scale_y = as_coaster ? 0.86 : 1.0;

center_svg_natural = [d_x/2 , d_y/2 ];
center_svg_offset = [- 1.75, - 1.35];
center_svg = center_svg_natural + center_svg_offset;

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

  path4 = arc(cp = center_svg, n=36, start=0 - 90, r=52 + 1.4 + 0.5, angle=180 - 2*0);
  stroke(path4);

  // left half
  path5 = arc(cp = center_svg, n=15, start=15 - 90 + 180, r=40, angle=180 - 2*15);
  stroke(path5);

  path6 = arc(cp = center_svg, n=15, start=10 - 90 + 180, r=44, angle=180 - 2*10);
  stroke(path6);

  path7 = arc(cp = center_svg, n=15, start=5 - 90 + 180, r=48, angle=180 - 2*5);
  stroke(path7);

  path8 = arc(cp = center_svg, n=36, start=0 - 90 + 180, r=52 + 1.4 + 0.5, angle=180 - 2*0);
  stroke(path8);
}

module base_ring () {

  path0 = arc(cp = center_svg, n=50, start=0, r=base_ring_r, angle=360);
  stroke(path0, width=base_ring_w);


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


show_coasters = !true;
debug_stacking = false;

print_face = !true;
print_base = !print_face ;

echo ("Face extruded height: ", d_z);
echo ("base thickness ",  base_ring_height + base_thickness );
echo ("base ring height ",  base_ring_height );
echo ("Face suspend height: ", base_ring_height + base_thickness - face_suspend);
echo ("Coaster thickness: ", total_height);
echo ("base_outer_r ", base_outer_r);
echo ("base_ring_inner_s_r ", base_ring_inner_s_r);


module gen_base () {
  // main base
  translate ([0,0,-(base_thickness+0)+e]) {
    translate(center_svg)
      linear_extrude(height = base_thickness)
      circle(r=base_outer_r, $fn = 50);

  }

  // ring
  translate ([0,0,-(base_thickness+base_ring_height)+e])
  translate(center_svg)
  difference () {
    cylinder(h = base_ring_height, r1 = base_ring_outer_s_r, r2 = base_ring_outer_r, $fn=50);
    translate ([0,0,-e]) {
      cylinder(h = base_ring_height + 2*e, r1 = base_ring_inner_s_r, r2 = base_ring_inner_r, $fn=50);
    }
  }

}


module gen_face () {
  translate([0,0, 0])
    extruded(h = d_z);
 }


module coaster () {

  scale([scale_x, scale_y, 1.00])
    {
    gen_base ();
    gen_face();
    }


}

stack_distance = total_height - base_ring_height + base_thickness;

if (debug_stacking) {
  intersection() {
    coaster();

    translate([0,0, stack_distance]) {
      coaster();
    }
 }
 }

if (show_coasters) {

    coaster();

    translate([0,0, stack_distance]) {
      coaster();
    }

    translate([0,0, 2 * stack_distance]) {
      coaster();
    }

    translate([0,0, 3 * stack_distance]) {
      coaster();
    }


 } else {

  scale([scale_x, scale_y, 1.00])
    if (print_base) {
      gen_base ();
    }

  scale([scale_x, scale_y, 1.00])
    if (print_face) {
      gen_face();
    }
 }


if (show_coasters) {

 }
