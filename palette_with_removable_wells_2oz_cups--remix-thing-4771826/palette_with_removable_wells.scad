///////////////////////////////////////////////////////////////////////////////
// Initial Revision: 2021-Aug-22
// Author: David Crook <idcrook@users.noreply.github.com>
//
// Description:
//
//   For holding small 2 oz. plastic cups, modeled after an artist's paint
//   palette
//
// Revisions/Notes:
//
// 2021-Aug-22: Start with STL from thing-4771826 as model
//
//
// TODO:
//
//
///////////////////////////////////////////////////////////////////////////////

/* Pi HQ camera model - include allows variables in that files scope */
//use <models/plastic_cup_2oz.scad>
include <models/plastic_cup_2oz.scad>


e = 1/128; // small number

palette_exterior_length = 220;
palette_exterior_width = 145;
palette_thickness = 3;

module palette () {

  cutout_size_d  = get_settle_diameter();
  cutout_size_r  = cutout_size_d / 2;
  start_inset_x = 10;
  start_inset_y = 10;
  space_between = 15;
  center_gap = 15;

  echo ("The cutout diameter is d=", cutout_size_d);

  difference () {
    cube([palette_exterior_length, palette_exterior_width, palette_thickness]);

    translate([start_inset_x,  start_inset_y, 0])
      translate([cutout_size_r,  cutout_size_r, -e])
      // cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);
      cylinder(h = palette_thickness + 2*e,
               // todo: calculate actual slope
               r1 = cutout_size_r, r2 = cutout_size_r + 0.5,
               center = false);

    translate([start_inset_x + cutout_size_d + space_between,  start_inset_y, 0])
      translate([cutout_size_r,  cutout_size_r, -e])
      cylinder(h = palette_thickness + 2*e,
               r1 = cutout_size_r, r2 = cutout_size_r + 0.5,
               center = false);

    translate([start_inset_x + 2*cutout_size_d + 2*space_between,  start_inset_y, 0])
      translate([cutout_size_r,  cutout_size_r, -e])
      cylinder(h = palette_thickness + 2*e,
               r1 = cutout_size_r, r2 = cutout_size_r + 0.5,
               center = false);

    translate([start_inset_x,
               start_inset_y + cutout_size_d + center_gap, 0])
      translate([cutout_size_r,  cutout_size_r, -e])
      cylinder(h = palette_thickness + 2*e,
               r1 = cutout_size_r, r2 = cutout_size_r + 0.5,
               center = false);

    translate([start_inset_x + cutout_size_d + space_between,
               start_inset_y  + cutout_size_d + center_gap, 0])
      translate([cutout_size_r,  cutout_size_r, -e])
      cylinder(h = palette_thickness + 2*e,
               r1 = cutout_size_r, r2 = cutout_size_r + 0.5,
               center = false);

    translate([start_inset_x + 2*cutout_size_d + 2*space_between,
               start_inset_y  + cutout_size_d + center_gap, 0])
      translate([cutout_size_r,  cutout_size_r, -e])
      cylinder(h = palette_thickness + 2*e,
               r1 = cutout_size_r, r2 = cutout_size_r + 0.5,
               center = false);

  }

}


module palette_only () {
    translate([0, 0, 0]) {
      palette();
    }
}

module original_model () {

  import ("designs/EconoPalette--thing-4771826.stl");


}

module plastic_cup_2oz () {
  translate([0, 0, 0]) {
      plastic_cup_2oz_model();
    }

}



module showTogether() {

    x_spacing = 40;
    y_spacing = 55;

    %scale ([1.0,1.0,1.0])
      translate([220 + 152, 141.4/2, 0])
      rotate([90, 0, 0])
      original_model();

    scale ([1.0,1.0,1.0])
      translate([0, 0, 0])
      palette();




}

show_everything = true ;

if (show_everything) {
    showTogether();
} else {

    // $preview requires version 2019.05
    fn = $preview ? 30 : 100;
    palette_only();

}
