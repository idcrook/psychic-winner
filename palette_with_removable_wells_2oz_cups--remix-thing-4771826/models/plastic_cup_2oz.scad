///////////////////////////////////////////////////////////////////////////////
// Initial Revision: 2021-Aug-22
// Author: David Crook <idcrook@users.noreply.github.com>
// Description: Rough dummy model of two ounce platic cup
//
// Revisions/Notes:
//
//   2021-Aug-22: Initial dimensions
//
//
///////////////////////////////////////////////////////////////////////////////

use <MCAD/2Dshapes.scad>
// module complexRoundSquare()

e = 1/128; // small number

// If true, model is instantiated by this file
//DEVELOPING_SELF_model = true;
DEVELOPING_SELF_model = false;

lip_diameter_top_outer = 61.5;
lip_diameter_shelf_inner = 56.2;
lip_shelf_height = 4.0;
lip_diameter_below_shelf_outside = 56.3;

sidewall_thickness = 0.5;
base_thickness = sidewall_thickness;
lip_thickness = 2.0;

base_diameter_outside = 45.0;
sidewall_diameter_outside_at_lip_shelf = lip_diameter_below_shelf_outside;

height_total = 30.1;
height_sidewall = 26.0;
height_lip = lip_shelf_height;

diameter_at_seven_eighths_sidewall_2oz = base_diameter_outside + (7/8) * (sidewall_diameter_outside_at_lip_shelf - base_diameter_outside);
height_at_seven_eighths_sidewall_2oz = (7/8) * (height_sidewall);


module truncated_hollow_cone (h = height_sidewall, r1 = base_diameter_outside/2, r2 = sidewall_diameter_outside_at_lip_shelf/2, shell_thickness = sidewall_thickness, center = false) {

// cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);
//shell_thickness
  difference () {
    cylinder(h, r1, r2, center);

    translate([0,0,-e])
      cylinder(h+2*e, r1-shell_thickness, r2-shell_thickness, center);
  }

}

module plastic_cup_2oz_model (solid = false, include_base_surface = false,
                              include_top_lip_extras = false) {

  //echo("The 7/8 sidewall diameter is d=", diameter_at_seven_eighths_sidewall_2oz);

  //color( c = [r, g, b], alpha = 1.0 )
  if (solid) {
    color(c = [127/255, 127/255, 127/255], alpha = 1.0) {
      cylinder (h = height_sidewall,
                r1 = base_diameter_outside/2,
                r2 = sidewall_diameter_outside_at_lip_shelf/2,
                center = false);
      translate([0,0,height_sidewall - e])
        cylinder(h = height_lip,
                 r1 = lip_diameter_shelf_inner/2,
                 r2 = lip_diameter_top_outer/2,
                 center = false);
    }
  } else {
    color(c = [0, 0, 127/255], alpha = 0.2) {

      union () {
        // base
        linear_extrude (height = base_thickness)
          circle (d = base_diameter_outside);

        // sidewall
        truncated_hollow_cone(h = height_sidewall,
                              r1 = base_diameter_outside/2,
                              r2 = sidewall_diameter_outside_at_lip_shelf/2,
                              shell_thickness = sidewall_thickness, center = false);

        // lip
        translate([0,0,height_sidewall])
          truncated_hollow_cone(h = height_lip,
                                r1 = lip_diameter_shelf_inner/2,
                                r2 = lip_diameter_top_outer/2,
                                shell_thickness = lip_thickness, center = false);
      }
    }
  }

}

function get_2oz_max_diameter () = max(lip_diameter_top_outer, lip_diameter_shelf_inner, base_diameter_outside);
function get_2oz_settle_diameter () = diameter_at_seven_eighths_sidewall_2oz;
function get_2oz_settle_depth () = height_at_seven_eighths_sidewall_2oz;


// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

if (DEVELOPING_SELF_model)  {
    plastic_cup_2oz_model();
}
