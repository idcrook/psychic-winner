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
add_center_pivot = true;

face_thickness = 1.8;
face_suspend = 0.5;
face_R = 52 + 1.4 + 0.5;
face_recessed = true;

base_thickness = 0.8; // needs to be more than face_suspend
assert(base_thickness > face_suspend, "Need the overlap to be less than the base thickness");


base_ring_height = 1.4;
base_ring_r = 48.8;
base_ring_w = 3.6;
base_ring_a = base_ring_r - (1/2)*base_ring_w;

center_pivot_height = base_ring_height;
center_pivot_r = 0.4 * 7;
center_pivot_r1 = 0.4 * 5;
center_pivot_r2 = center_pivot_r;
center_pivot_rc = 0.4 * 2.2;

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
recessed_scale = 0.68;

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
  arc_width = 0.4*2;

  // right half
  arc_sizes_r = [[15   - 90,   40,             180 - 2*15],
                 [11.5 - 90,   42,             180 - 2*11.5],
                 [9   - 90,   44,              180 - 2*9],
                 [6.5  - 90,   46,             180 - 2*6.5],
                 [ 4   - 90,   48,             180 - 2* 4],
                 [ 0   - 90,   face_R, 180 - 2*0]];

  for (arc_size =  [0:len(arc_sizes_r)-2]) {
    let (arc = arc_sizes_r[arc_size])  {
      path = arc(cp = center_svg, n=36, start=arc[0], r=arc[1], angle=arc[2]);
      stroke(path, width = arc_width);
    }
  }
  if (!face_recessed) {
    let (arc = arc_sizes_r[len(arc_sizes_r)-1])  {
      path = arc(cp = center_svg, n=36, start=arc[0], r=arc[1], angle=arc[2]);
      stroke(path, width = arc_width);
    }
  }

  // left half
  arc_sizes_l = [[15 - 90 + 180,   40,             180 - 2*15],
                 [11.5 - 90 + 180, 42,             180 - 2*11.5],
                 [ 9 - 90 + 180,   44,             180 - 2*9],
                 [6.5 - 90 + 180,  46,             180 - 2*6.5],
                 [ 4 - 90 + 180,   48,             180 - 2* 4],
                 [ 0 - 90 + 180,   face_R, 180 - 2*0]];

  for (arc_size =  [0:len(arc_sizes_l)-2]) {
    let (arc = arc_sizes_l[arc_size])  {
      path = arc(cp = center_svg, n=36, start=arc[0], r=arc[1], angle=arc[2]);
      stroke(path, width = arc_width);
    }
  }
  if (!face_recessed) {
    let (arc = arc_sizes_l[len(arc_sizes_l)-1])  {
      path = arc(cp = center_svg, n=36, start=arc[0], r=arc[1], angle=arc[2]);
      stroke(path, width = arc_width);
    }
  }


}


module outer_ring_face(r = face_R) {
  arc_width = 0.4*2;

  path = arc(cp = center_svg,  n=36*2, start=0, r=r, angle=361);
  stroke(path, width = arc_width);

}

// module recessed_cutout(r = face_R) {

//   translate(center_svg) {
//     cylinder(r=face_R - 2, h = 5);
//   }
// }

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

print_face = true;
print_face_recessed = print_face;
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

  // center pivot
  if (add_center_pivot) {
    translate ([0,0,-(base_thickness+base_ring_height)+e])
      translate(center_svg)
      difference () {
      cylinder(h = center_pivot_height, r1 = center_pivot_r1, r2 = center_pivot_r2, $fn=50);
      translate ([0,0,-e]) {
        cylinder(h = center_pivot_height + 2*e, r1 = center_pivot_rc, r2 = center_pivot_rc, $fn=50);
      }
    }
  }

}


module gen_face (recessed_part = true) {

  height = face_recessed ? recessed_scale * d_z : d_z;

  if (face_recessed) {
    if (recessed_part) {
      translate([0,0, 0]) {
        extruded(h = height);
      }
    } else {
      echo ("Face (recessed?) extruded height: ", height);
      linear_extrude(height = d_z)
        outer_ring_face(r=face_R);
    }
  } else {
      translate([0,0, 0]) {
        extruded(h = height);
      }
  }

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


 } else {  // Main renders

  scale([scale_x, scale_y, 1.00])
    if (print_base) {
      gen_base ();
    }

  scale([scale_x, scale_y, 1.00])
    if (print_face) {
      if (face_recessed) {
        if (print_face_recessed) {
          gen_face(recessed_part = true);
        } else {
          gen_face(recessed_part = false);
        }
      } else {
        gen_face();
      }
    }
 }


if (show_coasters) {

 }
