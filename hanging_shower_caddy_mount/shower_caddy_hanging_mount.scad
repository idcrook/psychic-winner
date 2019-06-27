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
caddy_thickness_front_to_back = 29.5;

// Other dimensions
mount_thickness = 3.5;
mount_width_across = caddy_groove_diameter + 4*mount_thickness;

module shower_caddy_hanging_mount () {

  top_bracket() ;

  caddy_support () ;


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
  //bracket_height = mount_width_across;
  bracket_height = 12;  // for test prints

  // assume its symmetrical
  groove_gap = (1/2)*(top_interior_width - groove_width);
  groove_slant = 0.7;

  origin = [0,0];
  groove_start = origin.x + groove_gap;
  groove_stop =  origin.x + groove_gap + groove_width;
  opposite_side = groove_stop + groove_gap ;

  minus_square = [(opposite_side - taper_radius) - (origin.x + taper_radius), rear_height_extension + front_lip_height];

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


// TODO:
module caddy_support () {

}

$fn = $preview ? 30 : 100;
shower_caddy_hanging_mount();
