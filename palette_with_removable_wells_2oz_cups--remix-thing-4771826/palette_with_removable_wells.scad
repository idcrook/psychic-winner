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

use <../libraries/misc/2dWedge.scad>
// 2dWedge(radius, startAngle, endAngle, stepsOverride)

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

bounding_box_inset_x = 4.5;
bounding_box_inset_y = 4.5;
bounding_box_crop_y = 145;

leg_height = 23.5;
leg_width_x = 12;
leg_width_y = well_padding - bounding_box_inset_y;

module material_trim_triangle () {
  // equilateral triangle with side length 100
  polygon(points = [ [0,0],
                     [100, 0],
                     [cos(60) * 100, sin(60) * 100]]);
}

module material_trim_sector () {
  segment_outer_radius = well_cutout_radius + (3/4)*well_padding;
  segment_inner_radius = well_cutout_radius + (1/3)*well_padding;
  segment_arc_degrees = 25;

  difference ()
    {
      2dWedge(radius = segment_outer_radius, startAngle = 0, endAngle = segment_arc_degrees);

      // subtract inside circular segment
      translate([0, 0, 0])
        rotate([0, 0, -e])
        2dWedge(radius = segment_inner_radius+2*e, startAngle = 0, endAngle = segment_arc_degrees+1);
    }
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

    triangle1_x = 2*well_padding + 1*well_outer_brim_r - 5.0;
    triangle1_y = (1/2)*well_padding + (3/2)*well_outer_brim_r-1.5;

    triangle2_x = triangle1_x + 2*well_padding +  1*well_outer_brim_r;
    triangle2_y = triangle1_y;

    triangle3_x  = (1/2)* (triangle1_x+triangle2_x) + triangle_size;
    triangle3_y = triangle1_y + (1/2)*well_padding;


    // use these objects to trim material
    if (trim_material) {
      translate([0,0,-e])
        linear_extrude(height=palette_thickness+2*e)

        // triangles
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

        // sectors
        // ROW 1:
        translate([0*well_padding + 1*well_outer_brim_r,
                   1*well_outer_brim_r,
                   0])
          union() {
          rotate([0,0,60]) material_trim_sector    ();
          rotate([0,0,90]) material_trim_sector    ();
          rotate([0,0,120]) material_trim_sector    ();
          rotate([0,0,180 + 15]) material_trim_sector    ();
          rotate([0,0,180 + 45]) material_trim_sector    ();
          rotate([0,0,180 + 105]) material_trim_sector    ();
          rotate([0,0,180 + 135]) material_trim_sector    ();
        }

        translate([2*well_padding + 2*well_outer_brim_r,
                   well_outer_brim_r,
                   0])
          union() {
          /* rotate([0,0,60]) material_trim_sector    (); */
          /* rotate([0,0,90]) material_trim_sector    (); */
          /* rotate([0,0,120]) material_trim_sector    (); */
          rotate([0,0,180 + 15]) material_trim_sector    ();
          rotate([0,0,180 + 45]) material_trim_sector    ();
          rotate([0,0,180 + 105]) material_trim_sector    ();
          rotate([0,0,180 + 135]) material_trim_sector    ();
        }

        translate([4*well_padding + 3*well_outer_brim_r,
                   well_outer_brim_r,
                   0])
          union() {
          rotate([0,0,30]) material_trim_sector    ();
          rotate([0,0,60]) material_trim_sector    ();
          rotate([0,0,90]) material_trim_sector    ();
          /* rotate([0,0,120]) material_trim_sector    (); */
          rotate([0,0,180 + 15]) material_trim_sector    ();
          rotate([0,0,180 + 45]) material_trim_sector    ();
          rotate([0,0,180 + 105]) material_trim_sector    ();
          rotate([0,0,180 + 135]) material_trim_sector    ();
        }
        // ROW 2:
        translate([-(1/2)*well_padding + 1*well_outer_brim_r,
                   -(3/4)*well_padding, 0]) {
          translate([0*well_padding + 1*well_outer_brim_r,
                     2*well_padding + 2*well_outer_brim_r,
                     0])
            union() {
            rotate([0,0,110]) material_trim_sector    ();
            rotate([0,0,140]) material_trim_sector    ();
            rotate([0,0,170]) material_trim_sector    ();
            rotate([0,0, 15]) material_trim_sector    ();
            rotate([0,0, 45]) material_trim_sector    ();
          }
        }

        translate([-(1/2)*well_padding + 1*well_outer_brim_r,
                   -(3/4)*well_padding, 0]) {
          translate([2*well_padding + 2*well_outer_brim_r,
                     2*well_padding + 2*well_outer_brim_r,
                     0])
            union() {
            rotate([0,0,110]) material_trim_sector    ();
            rotate([0,0,140]) material_trim_sector    ();
            /* rotate([0,0,170]) material_trim_sector    (); */
            rotate([0,0, -15]) material_trim_sector    ();
            rotate([0,0, 15]) material_trim_sector    ();
            rotate([0,0, 45]) material_trim_sector    ();
          }
        }
      }
    }


  }
}

module single_leg() {

  cube([leg_width_x, leg_width_y, leg_height]);

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
  translate([0, 0, -(plastic_2oz_cutout_z_height + (1/2)*palette_thickness)]) {
      plastic_cup_2oz_model(solid=true);
    }
}

module showTogether(add_legs = false) {
    %scale ([1.0,1.0,1.0])
      translate([220 + 152, 141.4/2, 0])
      rotate([90, 0, 0])
      original_model();

    scale ([1.0,1.0,1.0])
      translate([0, 0, 0]) {

      intersection () {
        palette(trim_material = true);
        // trim to fit more reliably on beds
        translate([bounding_box_inset_x, bounding_box_inset_y,-e])
          cube([227,bounding_box_crop_y,palette_thickness + 2*e]);
      }

      if (add_legs) {
        // ROW 1
        translate([0*well_padding + 1*well_outer_brim_r - (1/2)*(leg_width_x),
                   bounding_box_inset_y,
                   -(leg_height-e)])
          single_leg();
        translate([4*well_padding + 3*well_outer_brim_r - (1/2)*(leg_width_x),
                   bounding_box_inset_y,
                   -(leg_height-e)])
          single_leg();

        // ROW 2
        translate([-(1/2)*well_padding + 0*well_padding + 2*well_outer_brim_r - (1/2)*(leg_width_x),
                   bounding_box_crop_y - (1/2)*(leg_width_y),
                   -(leg_height-e)])
          single_leg();
        translate([-(1/2)*well_padding + 2*well_padding + 3*well_outer_brim_r - (1/2)*(leg_width_x),
                   bounding_box_crop_y - (1/2)*(leg_width_y),
                   -(leg_height-e)])
          single_leg();
      }

    }

}

show_everything = !true ;
p_ex1 = false;
p_ex2 = false;
p_ex3 = !false;

if (show_everything) {
    showTogether(add_legs = true);
} else {
    // $preview requires version 2019.05
    fn = $preview ? 30 : 100;
    //palette_only();
    //single_2oz_well();
    //material_trim_triangle    ();
    /* translate([well_outer_brim_r, well_outer_brim_r, palette_thickness]) */
    /*   rotate([0,0,75]) material_trim_sector    (); */
    //single_leg();

    if (p_ex1) {
      intersection () { // print experiment (for smaller bed)
        palette();
        translate([4.5,4.5,-e])
          cube([130,bounding_box_crop_y,palette_thickness + 2*e]);
      }
    }

    if (p_ex2) {
      intersection () { // print experiment (for smaller bed)
        palette(trim_material=true);
        translate([bounding_box_inset_x, bounding_box_inset_y, -e])
          cube([130,bounding_box_crop_y,palette_thickness + 2*e]);
      }
    }

    if (p_ex3) {
      intersection () { // print experiment (for smaller bed)
        palette(trim_material=true);
        translate([bounding_box_inset_x, bounding_box_inset_y, -e])
          cube([132,bounding_box_crop_y, palette_thickness + 2*e]);
      }

      // ROW 1
      translate([1*well_outer_brim_r - (1/2)*(leg_width_x),
                 bounding_box_inset_y,
                 -(leg_height-e)])
        single_leg();

      translate([2*well_padding + 2*well_outer_brim_r - (1/2)*(leg_width_x),
                 bounding_box_inset_y,
                 -(leg_height-e)])
        single_leg();

      // ROW 2
      translate([-(1/2)*well_padding + 2*well_outer_brim_r - (1/2)*(leg_width_x),
                 bounding_box_crop_y - (1/2)*(leg_width_y),
                 -(leg_height-e)])
        single_leg();

    }



}
