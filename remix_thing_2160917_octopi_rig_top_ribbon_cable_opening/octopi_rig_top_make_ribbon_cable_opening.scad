///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2019-Nov-18
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//
// Revisions/Notes:
//
//   2019-Nov-18: Import .STL from original model and directly overlay changes
//
///////////////////////////////////////////////////////////////////////////////


// Octoprint raspberry pi rig remix - https://www.thingiverse.com/thing:2160917
ORIGINAL_MODEL = "pitft35-top_V2.stl";

e = 1/128; // small number

ribbon_cable_width = 33.0;
case_thickness = 4.0;
original_hole_distance_from_model_top = 9.0;
cutout_width = ribbon_cable_width + 5.0;

module cutout_solid (width = cutout_width,
                     height = original_hole_distance_from_model_top) {

  translate([0,0,-e])
    linear_extrude(height = height, center = false) {
    square(size=[width, case_thickness], center = false);
  }
}


// translate and rotate to achieve goal
module add_ribbon_cable_slot  () {

  // the hardcodes values were empirically iterated upon
  original_cable_slot_x = -11.48 - 10.0 + 3;  // move closer to center of end length
  original_cable_slot_y = 50.5;
  original_cable_slot_z = 8.52 + 5 - 1.5;

  origin = [original_cable_slot_x,
            original_cable_slot_y,
            original_cable_slot_z];

  slot_instead_of_hole = true;
  //slot_instead_of_hole = false;

  cutout_height = slot_instead_of_hole ? 9.0 : 4.0;

  difference() {
    union() {
      import(ORIGINAL_MODEL);
    }

    translate([origin[0], origin[1], origin[2]]) {

      cutout_solid(height=cutout_height);
      // reference for relative spacing
      %translate([cutout_width, 0, 0]) { square(10, center=false); }
    }
  }

}



$fn = $preview ? 30 : 100;
add_ribbon_cable_slot();
