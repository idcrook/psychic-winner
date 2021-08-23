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
//palette_thickness = 3;
palette_thickness = 2.67;

well_cutout_radius   = get_2oz_settle_diameter() / 2;
plastic_2oz_cutout_z_height = get_2oz_settle_depth() - palette_thickness;
plastic_2oz_projection_diameter = get_2oz_max_diameter();

well_padding = 7.25*2;
well_inner_r = well_cutout_radius - 2; // the actual will be result of cup subtraction
well_outer_brim_r = (plastic_2oz_projection_diameter/2)  + well_padding;

module palette_rough () {

  cutout_size_r  = well_cutout_radius;
  cutout_size_d  = cutout_size_r * 2;
  start_inset_x = 10;
  start_inset_y = 10;
  space_between = 15;
  center_gap = 15;

  echo ("The well cutout diameter is d=", cutout_size_d);

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

module material_trim_triangle () {
  // equilateral triangle with side length 100
  polygon(points = [ [0,0],
                     [100, 0],
                     [cos(60) * 100, sin(60) * 100]]);
}


module palette (trim_material = false) {
    difference () {
    translate([0, 0, 0]) {

      // ROW 1
      translate([0*well_padding + 1*well_outer_brim_r,
                 0*well_padding + 1*well_outer_brim_r, 0])
        single_2oz_well();

      translate([2*well_padding + 2*well_outer_brim_r,
                 0*well_padding + 1*well_outer_brim_r, 0])
        single_2oz_well();

      translate([4*well_padding + 3*well_outer_brim_r,
                 0*well_padding + 1*well_outer_brim_r, 0])
        single_2oz_well();

      // ROW 2
      // shift to be more closely spaced
      translate([-(1/2)*well_padding + 1*well_outer_brim_r,
                 -(3/4)*well_padding, 0]) {
        translate([0*well_padding + 1*well_outer_brim_r,
                   2*well_padding + 2*well_outer_brim_r, 0])
          single_2oz_well();

        translate([2*well_padding + 2*well_outer_brim_r,
                   2*well_padding + 2*well_outer_brim_r, 0])
          single_2oz_well();

        /* translate([4*well_padding + 3*well_outer_brim_r, */
        /*            2*well_padding + 2*well_outer_brim_r, 0]) */
        /*   single_2oz_well(); */
      }
    }

    triangle_rot = -60;
    triangle_size = 27; //

    triangle1_x = 2*well_padding + 1*well_outer_brim_r - 4.7;
    triangle1_y = (1/2)*well_padding + (3/2)*well_outer_brim_r;

    triangle2_x = triangle1_x + 2*well_padding +  1*well_outer_brim_r;
    triangle2_y = triangle1_y;

    triangle3_x  = (1/2)* (triangle1_x+triangle2_x) + triangle_size;
    triangle3_y = triangle1_y + (1/2)*well_padding;


    // use these objects to trim material
    if (trim_material) {
      translate([0,-2,-e])
        linear_extrude(height=palette_thickness+2*e)

        union () {
        translate([triangle1_x, triangle1_y, 0])
          rotate([0,0, triangle_rot])
          scale([triangle_size/100, triangle_size/100, 1])
          material_trim_triangle();

        translate([triangle2_x, triangle2_y, 0])
          rotate([0,0, triangle_rot])
          scale([triangle_size/100, triangle_size/100, 1])
          material_trim_triangle();

        translate([triangle3_x, triangle3_y, 0])
          rotate([0,0, triangle_rot + 180])
          scale([triangle_size/100, triangle_size/100, 1])
          material_trim_triangle();

      }
    }


  }
}

module single_2oz_well() {
  padding = well_padding;
  inner_r = well_inner_r;
  outer_brim_r = well_outer_brim_r;
  spacing = 2 * outer_brim_r + padding;

  difference () {
    linear_extrude (height = palette_thickness)
      difference () {
      circle (r = outer_brim_r);
      circle (r = inner_r);
    }

    // subtract cup from center
    place_solid_plastic_cup_2oz();
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

module place_solid_plastic_cup_2oz () {
  translate([0, 0, -(plastic_2oz_cutout_z_height + 0)]) {
      plastic_cup_2oz_model(solid=true);
    }
}

module showTogether() {
    %scale ([1.0,1.0,1.0])
      translate([220 + 152, 141.4/2, 0])
      rotate([90, 0, 0])
      original_model();

    scale ([1.0,1.0,1.0])
      translate([0, 0, -(palette_thickness+e)])
      %palette_rough();

    scale ([1.0,1.0,1.0])
      translate([0, 0, 0]) {

      intersection () {
        palette(trim_material = true);
        // trim to fit more reliably on beds
        translate([4.5,4.5,-e])
          cube([227,143,palette_thickness + 2*e]);
      }

    }

}

show_everything = true ;
p_ex1 = false;
p_ex2 = !false;

if (show_everything) {
    showTogether();
} else {
    // $preview requires version 2019.05
    fn = $preview ? 30 : 100;
    //palette_only();
    //single_2oz_well();
    //material_trim_triangle    ();

    if (p_ex1) {
      intersection () { // print experiment (for smaller bed)
        palette();
        translate([4.5,4.5,-e])
          //cube([230,145,palette_thickness + 2*e]);
          cube([130,145,palette_thickness + 2*e]);
      }
    }

    if (p_ex2) {
      intersection () { // print experiment (for smaller bed)
        palette(trim_material=true);
        translate([4.5,4.5,-e])
          //cube([230,145,palette_thickness + 2*e]);
          cube([130,145,palette_thickness + 2*e]);
      }
    }

}
