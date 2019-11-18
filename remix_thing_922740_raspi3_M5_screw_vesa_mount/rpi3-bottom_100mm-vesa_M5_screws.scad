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

ORIGINAL_MODEL = "rpi3-bottom_100mm-vesa_netfabb.stl";

e = 1/128; // small number

M4_to_M5_diameter_increase = 1.0;

original_cutout_diameter = 4.5;  // cylinder "cutout" diameter for screw holes
updated_for_M5_cutout_diameter = original_cutout_diameter + M4_to_M5_diameter_increase + 0.2;

original_surrounding_diameter = original_cutout_diameter + 4.0;  // material surrouding screw holes
updated_for_M5_surrounding_diameter = original_surrounding_diameter + M4_to_M5_diameter_increase + 0.5;

base_thickness = 3.5;
vesa_size = 100.0;

module cutout_solid (cylinder_diameter = original_cutout_diameter, cylinder_length = base_thickness) {

  translate([0,0,-e])
    linear_extrude(height = cylinder_length + 2*e, center = false) {
    circle(r=cylinder_diameter / 2);
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
module enlarge_vesa_holes  () {

  // the hardcodes values were empirically iterated upon
  origin_center_inset_x = 4.25;
  origin_center_inset_y = 4.25;

  origin = [origin_center_inset_x,  origin_center_inset_y];

  vesa_corner_positions = [[origin.x + 0,         origin.y + 0],
                           [origin.x + vesa_size, origin.y + 0],
                           [origin.x + 0,         origin.y + vesa_size],
                           [origin.x + vesa_size, origin.y + vesa_size]];

  difference() {
    union() {
      import(ORIGINAL_MODEL);
      // add additional material around VEAS screw hole locations
      for (p = vesa_corner_positions) {
        translate([p[0], p[1], 0])
          //enlarge_surrounding_solid(cylinder_diameter = original_surrounding_diameter);
          enlarge_surrounding_solid(cylinder_diameter = updated_for_M5_surrounding_diameter);
      }
    }


    for (p = vesa_corner_positions) {
      translate([p[0], p[1], 0])
        cutout_solid(cylinder_diameter = updated_for_M5_cutout_diameter);
    }
  }

}



$fn = $preview ? 30 : 100;
enlarge_vesa_holes();
