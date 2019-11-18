///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2019-Nov-13
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//   I decided to remix this for applying to VESA mount (75 mm X 75 mm, 100 mm
//   X 100 mm) that uses M5 bolts instead of the more common M4 bolts that
//   original design uses
//
// Revisions/Notes:
//
//   2019-Nov-13: Import .STL from original model and directly overlay changes
//
///////////////////////////////////////////////////////////////////////////////

ORIGINAL_MODEL = "pitft35-top_V2.stl";

e = 1/128; // small number

ribbon_cable_width = 33.0;
case_thickness = 4.0;
original_hole_distance_from_model_top = 9.0;

module cutout_solid (width = ribbon_cable_width + case_thickness, height = original_hole_distance_from_model_top) {

  translate([0,0,-e])
    linear_extrude(height = height, center = false) {
    square(size=[width, case_thickness], center = false);
  }
}


module enlarge_surrounding_solid (cylinder_diameter = original_surrounding_diameter,
                                  cylinder_length = base_thickness) {

  translate([0,0,0])
    linear_extrude(height = cylinder_length, center = false) {
    circle(r=cylinder_diameter / 2);
  }
}

// translate and rotate to achieve goal
module add_ribbon_cable_slot  () {

  // the hardcodes values were empirically iterated upon
  original_cable_slot_x = -11.48;
  original_cable_slot_y = 50.5;
  original_cable_slot_z = 8.52;

  origin = [original_cable_slot_x,
            original_cable_slot_y,
            original_cable_slot_z];

  slot_instead_of_hole = true;
  slot_instead_of_hole = false;

  cutout_height = slot_instead_of_hole ? 9.0 : 4.0;

  difference() {
    union() {
      import(ORIGINAL_MODEL);
      // TODO: add additional material ?
    }

    translate([origin[0], origin[1], origin[2]])
      cutout_solid(height=cutout_height);
  }

}



$fn = $preview ? 30 : 100;
add_ribbon_cable_slot();
