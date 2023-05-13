///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2023-05-12
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//   Needed a utility clip to pull rabbit fencing alongside a gardening metal
//   raised bed
//
// Revisions/Notes:
//
//   2023-May-12: Import .STL from s-clip model and apply transformations
//
///////////////////////////////////////////////////////////////////////////////

ORIGINAL_MODEL = "s_shaped_cable_clip.stl";

e = 1/128; // small number

dia = 10;
circle_center_cut = 3;
cut_size = circle_center_cut + dia;
print_height =  7.5+2*e;

translate_hook_x = dia/2+0.5;
hook_width = 3.2;


// translate and rotate to achieve goal
module modify_clip  () {


  // add additional material for loopoing around fence wire
  translate([translate_hook_x, -circle_center_cut-e, -e])
    cube([hook_width, 5, print_height]);


  translate([translate_hook_x+0.8, -0.5, -e])
    rotate([0,0,50])
    cube([hook_width, 5, print_height]);


  difference() {
    union() {
      import(ORIGINAL_MODEL);
    }

    translate ([-circle_center_cut, -circle_center_cut, -e]) {
      cube([cut_size, cut_size, print_height]);
    }

    translate ([dia-e, 0, -e]) {
      cube([dia+2*e, dia, print_height]);
    }
    translate ([2*dia, 0, -e]) {
      cube([dia, dia, print_height]);
    }
    translate ([dia-e, -dia-e, -e]) {
      cube([dia+2*e, dia+2*e, print_height]);
    }
    translate ([2*dia, -dia-e, -e]) {
      cube([dia, dia+2*e, print_height]);
    }

  }

}



$fn = $preview ? 30 : 100;
modify_clip();
