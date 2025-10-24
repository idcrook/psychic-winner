///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2025-Oct-23
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by: Gridfinity
//
// Description:
//
//   wanted to transfer small items out of boxes an into bins
//
// Revisions/Notes:
//
//   2023-May-12: Import .STL from original gridfinity baseplates
//
///////////////////////////////////////////////////////////////////////////////

frame_1x3_stl = "Frame 1x3.stl";
frame_2x3_stl = "Frame 2x3.stl";

weighted_1x3_stl = "Weighted Baseplate 1x3.stl";
weighted_2x3_stl = "Weighted Baseplate 2x3.stl";

drawer_distance_between_insert_pillars = 124;

grid_u_planar = 42;
by3_extent = 3 * grid_u_planar;
by3x1_minor_extent = 1 * grid_u_planar;
by3x2_minor_extent = 2 * grid_u_planar;
frame_height = 5;
weighted_height = 10.8;

weighted_bottom_below_origin = 6.4;

half_distance_to_shrink = (1/2)*(by3_extent - drawer_distance_between_insert_pillars);

notch_depth = half_distance_to_shrink;
notch_length = 6;
notch_cutout_length = 1.6;

/* [Hidden] */
e = 1/128; // small number

show_assembly = !true;



module single_look () {
  //modify_2x3();
  modify_2x3(stl = weighted_2x3_stl, frameQ = false,
             bottom_below_origin = weighted_bottom_below_origin);
  //divider_notch();
}

module divider_notch () {

  start_cutout = (1/2)*(notch_length - notch_cutout_length);

  a = (1/2)*notch_depth;
  b = (1/2)*start_cutout;


  difference() {
    square(size = [notch_depth, notch_length], center = false);

    translate([+e, start_cutout])
      square(size = [notch_depth, notch_cutout_length], center = false);

    translate([a, -e])
      polygon(points = [[0,0], [a,0], [a,b]]);

    translate([a, notch_length+e])
      polygon(points = [[0,0], [a,0], [a,-b]]);

  }
}

module modify_2x3(stl = frame_2x3_stl, frameQ = true, bottom_below_origin = 0.0) {

  start_notch = grid_u_planar - (1/2)*notch_length;
  notch_removal_height = 12;
  z_raise = bottom_below_origin;

  difference() {
    translate([0,0,z_raise])
      import (stl);

    // cut notches
    // x origin, y axis
    translate([-e, start_notch,-e])
      linear_extrude(h = notch_removal_height)
      divider_notch();


    // x extent, y axis
    translate([3*grid_u_planar + e, start_notch + notch_length, -e])
       rotate([0,0,180])
      linear_extrude(h = notch_removal_height)
      divider_notch();

  }
}

// translate and rotate to achieve goal
module modify_clip  () {

  // add additional material for hooking fence wire
  translate ([-7.7,-2,0]) {
    difference () {
      union() {
        translate([translate_hook_x, translate_hook_y, 0])
          cube([hook_width, 5+5, print_height]);

        // hard-code some values here; tweak as needed
        translate([translate_hook_x-4, translate_hook_y, 0])
          rotate([0,0,-40])  // sets the angle of the "hook" part
          cube([hook_width-0.5, 5+2, print_height]);
      }

      translate([translate_hook_x, translate_hook_y -0.7, -e])
        rotate([0,0,-40])  // sets the angle of the "hook" part
        cube([hook_width-0.5, 5+2, print_height+2*e]);
    }
  }

  // modify sacrificial imported model here
  difference() {
    union() {
      import(ORIGINAL_MODEL);
    }

    translate ([-circle_center_cut, -circle_center_cut, -e]) {
      cube([cut_size, cut_size, print_height+2*e]);
    }

    // trim remaining center circle piece
    translate ([0, -circle_center_cut - 3, -e]) {
      cube([cut_size, cut_size, print_height+2*e]);
    }

    // cut away far loop side
    translate ([dia-e, 0, -e]) {
      cube([dia+2*e, dia, print_height+2*e]);
    }
    translate ([2*dia, 0, -e]) {
      cube([dia, dia, print_height+2*e]);
    }
    translate ([dia-e, -dia-e, -e]) {
      cube([dia+2*e, dia+2*e, print_height+2*e]);
    }
    translate ([2*dia, -dia-e, -e]) {
      cube([dia, dia+2*e, print_height+2*e]);
    }

  }

}



$fn = $preview ? 30 : 100;

if (show_assembly) {
  assembly();
} else {
  single_look();
}
