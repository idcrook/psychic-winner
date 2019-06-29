////////////////////////////////////////////////////////////////////////
// Initial Revision:
//  2019-Jun-27
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
//   - Necessity
//
// Description:
//
//
//
//
// Revisions/Notes:
//
//  - Developed on OpenSCAD 2019.05
//
////////////////////////////////////////////////////////////////////////


use <../libraries/scad-utils/morphology.scad>


e = 0.02; // small number


// Measurements
//

shower_wall_top_interior_width = 24.5;
shower_wall_top_interior_valley_width = 19.0;
shower_wall_top_interior_valley_depth = 3.0;
shower_wall_rear_side_straight_height = 24.5;
shower_wall_rear_side_full_height = 34.0;
shower_wall_rear_side_extension_height = 5.0;
shower_wall_front_side_extension_height = 17.0;

shower_wall_rear_side_taper_distance = shower_wall_rear_side_full_height - shower_wall_rear_side_straight_height;
shower_wall_rear_side_taper_round_radius = 1.0;

caddy_groove_diameter = 22.6;
caddy_groove_height = 17.0;
caddy_thickness_front_to_back = 29.5 + 3;

// Other dimensions
mount_thickness = 3.5;
mount_width_thickness_scale = 3;
mount_width_thickness_scaled = mount_width_thickness_scale*mount_thickness;
mount_width_across = caddy_groove_diameter + mount_width_thickness_scaled;

module shower_caddy_hanging_mount () {

  top_bracket() ;

  translate([shower_wall_top_interior_width + mount_thickness - 2*e + caddy_thickness_front_to_back,
             32,
              caddy_groove_diameter + (1/2)*mount_width_thickness_scaled])
    rotate(a = [0, 90, 180])
    rotate(a = [0, 0, 0])
    caddy_support_knob () ;

}


module top_bracket () {

  top_interior_width = shower_wall_top_interior_width;
  groove_width = shower_wall_top_interior_valley_width;
  groove_depth = shower_wall_top_interior_valley_depth;
  straight_height = shower_wall_rear_side_straight_height;
  full_rear_height = shower_wall_rear_side_full_height;
  rear_height_extension = shower_wall_rear_side_extension_height;
  front_lip_height = shower_wall_front_side_extension_height;
  taper_radius =  shower_wall_rear_side_taper_round_radius;
  bracket_thickness = mount_thickness;
  bracket_height = mount_width_across;
  //bracket_height = 12;  // for test prints

  // assume its symmetrical
  groove_gap = (1/2)*(top_interior_width - groove_width);
  groove_slant = 0.7;

  origin = [0,0];
  groove_start = origin.x + groove_gap;
  groove_stop =  origin.x + groove_gap + groove_width;
  opposite_side = groove_stop + groove_gap ;
  extra_front_padding = 1.0;

  minus_square = [(opposite_side - taper_radius) - (origin.x + taper_radius) - extra_front_padding,
                  rear_height_extension + front_lip_height];

  // 2d outline of bracket interior
  bracket_crossxn_points = [
    [origin.x + 0, origin.y + 0],
    [groove_start, origin.y + 0],
    [groove_start + groove_slant, origin.y + groove_depth],
    [groove_stop  - groove_slant,  origin.y + groove_depth],
    [groove_stop,  origin.y + 0],
    // start on front
    [opposite_side,  origin.y + 0],
    [opposite_side,  origin.y + straight_height],
    [opposite_side,                 origin.y + full_rear_height - taper_radius],
    [opposite_side - taper_radius,  origin.y + full_rear_height],
    // jump back to rear
    [origin.x + taper_radius,  origin.y + full_rear_height + rear_height_extension],
    [origin.x + taper_radius,  origin.y + full_rear_height],
    [origin.x + 0,             origin.y + full_rear_height - taper_radius],
    [origin.x + 0, origin.y + 0]];


  linear_extrude(height = bracket_height)
    difference() {
    union() {
      shell(d=bracket_thickness)
        polygon(points = bracket_crossxn_points);
      // front lip
      translate([opposite_side - taper_radius, origin.y + full_rear_height])
        square([bracket_thickness, front_lip_height]);
    }
    // cut out bridging piece that is an artifact from polygon contruction
    translate([origin.x + taper_radius, origin.y + full_rear_height])
      square([minus_square.x, minus_square.y]);
  };

}


module caddy_support_knob () {

  knob_diameter = caddy_groove_diameter;
  knob_sidewall_height = caddy_groove_height;

  knob_length = caddy_thickness_front_to_back;
  // knob_length = 15;  // for test prints

  // trim some off the sides
  square_width = knob_diameter - 0.9;
  flange_length = 0.7;

  support_knob_prism(height = knob_length,
                     knob_diameter = knob_diameter,
                     knob_width = square_width,
                     sidewall_height = knob_sidewall_height);

  // create a flange, using projections
  hull() {
    // scale projection outline
    linear_extrude(center = true, height = 0.5)
      scale([1.15,1.15]) /* spitballed these */
      translate([-1.55,-1.0])
      projection(cut = false)
      support_knob_prism(height = knob_length,
                         knob_diameter = knob_diameter,
                         knob_width = square_width,
                         sidewall_height = knob_sidewall_height);

    // shift up same projection
    translate([0, 0, flange_length])
      linear_extrude(center = true, height = 0.5)
      projection(cut = false)
      support_knob_prism(height = knob_length,
                         knob_diameter = knob_diameter,
                         knob_width = square_width,
                         sidewall_height = knob_sidewall_height);
  }


// create a flange, using projections
  translate([0, 0, caddy_thickness_front_to_back])
  hull() {
    // scale projection outline
    linear_extrude(center = true, height = 0.5)
      scale([1.15,1.15]) /* spitballed these */
      translate([-1.55,-1.0])
      projection(cut = false)
      support_knob_prism(height = knob_length,
                         knob_diameter = knob_diameter,
                         knob_width = square_width,
                         sidewall_height = knob_sidewall_height);

    // shift up same projection
    translate([0, 0, -flange_length])
      linear_extrude(center = true, height = 0.5)
      projection(cut = false)
      support_knob_prism(height = knob_length,
                         knob_diameter = knob_diameter,
                         knob_width = square_width,
                         sidewall_height = knob_sidewall_height);
  }

}

module support_knob_prism (height, knob_diameter, knob_width, sidewall_height) {
  knob_radius = knob_diameter/2;

  square_corner = [0 + (1/2)*(knob_diameter - knob_width), 0];
  knob_center = [knob_radius, (2/7)*sidewall_height];

  linear_extrude (height = height, center = false)
    // kinda like a bread loaf-- with a rounded top
    intersection() {
    translate([square_corner.x, square_corner.y])
      square([knob_width, sidewall_height]);
    translate([knob_center.x, knob_center.y])
      scale([0.89,0.90])
      circle(r=knob_radius*1.1);
  }

}

$fn = $preview ? 30 : 100;
shower_caddy_hanging_mount();
