///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2019-Dec-28
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
//
// Revisions/Notes:
//
//   2019-Dec-28: Initial PCB dimensions
//
//   2019-Dec-29: Printed
//
///////////////////////////////////////////////////////////////////////////////

// on ubuntu: export OPENSCADPATH=/usr/share/openscad/libraries
use <MCAD/2Dshapes.scad>

e = 1/128; // small number

// determines whether model is instantiated by this file; set to false for
// using as an include file
DEVELOPING_elp_usbfhd01m_l28_dummy = false;

pcb_thickness = 1.7;
pcb_length = 32.0;
pcb_height = 32.0;
pcb_length_extra = pcb_length + 1.0; // castellated extra where outer pieces snapped off
pcb_height_extra = pcb_height + 1.0; // castellated extra where outer pieces snapped off
pcb_keepout_back = 3.5 + 0.2 + 0.3 - pcb_thickness;

hole_diameter = 2.3;
hole_spacing = 28.0;
hole_pos_x = 2.0;
hole_pos_y = 2.0;

spacer_pos_x = 2.5;
spacer_pos_y = 2.5;
keepout_spacer_half = spacer_pos_x;
keepout_spacer_side = 2 * keepout_spacer_half;
keepout_spacing = pcb_length - 2*spacer_pos_x;


usb_connector_length = 10;
usb_connector_width = 5;
usb_connector_above_board = 6.1;
usb_from_x = 5.5;
usb_from_y = 0.2;
usb_pth_protrusion_length = 7.3;
usb_pth_protrusion_width = 1.4;
usb_pth_protrusion_height = 2.5;
usb_pth_protrusion_from_x = 7.3;
usb_pth_protrusion_from_y = 2.1;
usb_pth_protrusion_from_tol = 0.3;

sensor_housing_base_length = 16.2 ; // x dimension
sensor_housing_base_width = 16.3 ; // y dimension
sensor_housing_base_height = 8.0 ; // z dimension
sensor_from_x = 8.0;
sensor_from_y = 8.0;

sensor_screw_bracket_width = 4.0;
sensor_screw_bracket_extant = 3.7;
sensor_screw_bracket_height = 4.0;
sensor_screw_bracket_radius = (1/2) * sensor_screw_bracket_width;

module cutout_solid (cylinder_diameter = hole_diameter, cylinder_length = pcb_thickness) {
  translate([0,0,-e])
    linear_extrude(height = cylinder_length + 2*e, center = false) {
    circle(r=cylinder_diameter / 2);
  }
}

module keepout_spacer (block_side = keepout_spacer_side , block_height = pcb_keepout_back) {
  translate([0,0,-e])
    linear_extrude(height = block_height + 2*e, center = false) {
    square(size = block_side, center = false);
  }
}


module usb_connector (length = usb_connector_length, width = usb_connector_width, height = usb_connector_above_board) {

  pth_length = usb_pth_protrusion_length + 2*usb_pth_protrusion_from_tol;
  pth_width = usb_pth_protrusion_width + 2*usb_pth_protrusion_from_tol;
  pth_height = usb_pth_protrusion_height;
  pth_width_wires_offset = (3/5) * usb_connector_width; // not centered half-way in connector
  pth_t_x = (1/2) * (length - pth_length);
  pth_t_y = pth_width_wires_offset - (1/2) * (pth_width);
  pth_t_z = pcb_thickness;

  // connector insert
  mirror([0,0,1])
    cube([length, width, height], center = false);

  // through-hole wire protrusion
  color("Red")
    translate([pth_t_x, pth_t_y, pth_t_z])
    cube([pth_length, pth_width, pth_height], center = false);


}

module sensor_housing () {
  base_length = sensor_housing_base_length;
  base_width = sensor_housing_base_width;
  base_height = sensor_housing_base_height;

  screw_bracket_translate_x = 0.0 - sensor_screw_bracket_extant ;
  screw_bracket_translate_y = (1/2) * base_width - (1/2) * sensor_screw_bracket_width;

  screw_bracket_length = base_length + 2*sensor_screw_bracket_extant ;
  screw_bracket_width = sensor_screw_bracket_width;
  screw_bracket_height = sensor_screw_bracket_width;
  screw_bracket_radius = sensor_screw_bracket_radius;

  color("DarkGrey")
  union() {

    // main base
    cube([base_length, base_width, base_height], center = false);

    //screw bracket "wings")
    translate([screw_bracket_translate_x, screw_bracket_translate_y, 0])
      linear_extrude(height = screw_bracket_height, center = false)
      complexRoundSquare([screw_bracket_length, screw_bracket_width],
                         [screw_bracket_radius, screw_bracket_radius],
                         [screw_bracket_radius, screw_bracket_radius],
                         [screw_bracket_radius, screw_bracket_radius],
                         [screw_bracket_radius, screw_bracket_radius],
                         center = false);
  }

}


module elp_usbfhd01m_l28_dummy () {

  origin_center_inset_x = hole_pos_x;
  origin_center_inset_y = hole_pos_y;
  hole_distance = hole_spacing;
  hole_D = hole_diameter;

  keepout_center_inset_x = spacer_pos_x;
  keepout_center_inset_y = spacer_pos_y;
  keepout_side = keepout_spacer_side;
  keepout_offset = keepout_spacer_half;
  keepout_distance = keepout_spacing;

  usb_x_pos = pcb_length - usb_from_x - usb_connector_length;
  usb_y_pos = 0 + usb_from_y;

  sensor_x_pos = 0 + sensor_from_x - (1/2)*(sensor_housing_base_length-16);
  sensor_y_pos = 0 + sensor_from_y - (1/2)*(sensor_housing_base_width-16);
  sensor_z_pos = pcb_thickness;


  hole_origin = [origin_center_inset_x,  origin_center_inset_y];
  //spacer_origin = [keepout_center_inset_x,  keepout_center_inset_y];
  spacer_origin = [0,0];

  corner_hole_positions = [[hole_origin.x + 0,             hole_origin.y + 0],
                           [hole_origin.x + hole_distance, hole_origin.y + 0],
                           [hole_origin.x + 0,             hole_origin.y + hole_distance],
                           [hole_origin.x + hole_distance, hole_origin.y + hole_distance]];

  corner_spacer_positions = [[spacer_origin.x + 0,                spacer_origin.y + 0],
                             [spacer_origin.x + keepout_distance, spacer_origin.y + 0],
                             [spacer_origin.x + 0,                spacer_origin.y + keepout_distance],
                             [spacer_origin.x + keepout_distance, spacer_origin.y + keepout_distance]];


   difference() {
    union() {
      // main PCB
      linear_extrude(height = pcb_thickness, center = false)
        square(size = [pcb_length, pcb_height], center = false);

      // USB connector ("back" of PCB and through-hole)
      translate([usb_x_pos, usb_y_pos, 0]) {
          usb_connector();
      }

      // sensor housing ("front" of PCB)
      translate([sensor_x_pos, sensor_y_pos, sensor_z_pos]) {
        mirror([0,0,0])
         sensor_housing();
      }

      // spacers
      color("Green")
      mirror([0,0,1])
      for (p = corner_spacer_positions) {
        translate([p[0] , p[1] , 0])
          keepout_spacer();
      }
    }

    // SUBTRACTIVE

    // Holes
    for (p = corner_hole_positions) {
      translate([p[0], p[1], 0])
        cutout_solid(cylinder_diameter = hole_D);
    }
   }



}



// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

if (DEVELOPING_elp_usbfhd01m_l28_dummy && false) {
  // sizing up mount size
  intersection() {
    union() {
      translate([0,0,80])
        import( "../files/FronCover_NEW.stl");
    }
    translate([7-e,21-e,-24]) {
      cube([5+2*e,10+2*e,12], center=false);
      %translate([0, 6, 6.5])
         rotate([0,90,0])
         cutout_solid (cylinder_diameter = 3.6, cylinder_length = 5.0);
    }
  }
}

if (DEVELOPING_elp_usbfhd01m_l28_dummy) {
  elp_usbfhd01m_l28_dummy();
}
