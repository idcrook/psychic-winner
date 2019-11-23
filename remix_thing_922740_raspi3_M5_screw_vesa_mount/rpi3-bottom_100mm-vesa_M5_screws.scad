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
//   2019-Nov-23: Also make 75mm VESA holes M5 sized
//
///////////////////////////////////////////////////////////////////////////////

ORIGINAL_MODEL = "rpi3-bottom_100mm-vesa_netfabb.stl";

e = 1/128; // small number

M4_to_M5_diameter_increase = 1.0;

original_cutout_diameter = 4.5;  // cylinder "cutout" diameter for screw holes
updated_for_M5_cutout_diameter = original_cutout_diameter + M4_to_M5_diameter_increase + 0.2;

original_surrounding_diameter = original_cutout_diameter + 4.0;  // material surrounding screw holes
updated_for_M5_surrounding_diameter = original_surrounding_diameter + M4_to_M5_diameter_increase + 0.5;

base_thickness = 3.5;
vesa_100mm_size = 100.0;
vesa_75mm_size  =  75.0;

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
  origin_100mm_center_inset_x = 4.25;
  origin_100mm_center_inset_y = 4.25;

  origin_100mm = [origin_100mm_center_inset_x,  origin_100mm_center_inset_y];

  vesa_100mm_corner_positions = [[origin_100mm.x + 0,               origin_100mm.y + 0],
                                 [origin_100mm.x + vesa_100mm_size, origin_100mm.y + 0],
                                 [origin_100mm.x + 0,               origin_100mm.y + vesa_100mm_size],
                                 [origin_100mm.x + vesa_100mm_size, origin_100mm.y + vesa_100mm_size]];

  // found empirically but makes sense since (100-75)/2 = 12.5
  origin_75mm_center_inset_x = origin_100mm_center_inset_x + 12.5;
  origin_75mm_center_inset_y = origin_100mm_center_inset_y + 12.5;

  origin_75mm = [origin_75mm_center_inset_x,  origin_75mm_center_inset_y];

  vesa_75mm_corner_positions = [[origin_75mm.x + 0,              origin_75mm.y + 0],
                                [origin_75mm.x + vesa_75mm_size, origin_75mm.y + 0],
                                [origin_75mm.x + 0,              origin_75mm.y + vesa_75mm_size],
                                [origin_75mm.x + vesa_75mm_size, origin_75mm.y + vesa_75mm_size]];

  difference() {
    union() {
      import(ORIGINAL_MODEL);
      // add additional material around VEAS screw hole locations
      for (p = vesa_100mm_corner_positions) {
        translate([p[0], p[1], 0])
          //enlarge_surrounding_solid(cylinder_diameter = original_surrounding_diameter);
          enlarge_surrounding_solid(cylinder_diameter = updated_for_M5_surrounding_diameter);
      }
    }

    // Holes
    for (p = vesa_100mm_corner_positions) {
      translate([p[0], p[1], 0])
        cutout_solid(cylinder_diameter = updated_for_M5_cutout_diameter);
    }

    for (p = vesa_75mm_corner_positions) {
      translate([p[0], p[1], 0])
        //cutout_solid(cylinder_diameter = original_cutout_diameter);
        cutout_solid(cylinder_diameter = updated_for_M5_cutout_diameter);
    }

  }

}



$fn = $preview ? 30 : 100;
enlarge_vesa_holes();
