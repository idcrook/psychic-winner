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
//   2019-Dec-28: First draft mount
//
///////////////////////////////////////////////////////////////////////////////

use <MCAD/2Dshapes.scad>

e = 1/128; // small number


pcb_thickness = 1.7;
pcb_length = 32.0;
pcb_height = 32.0;
pcb_height_extra = pcb_height + 1.0; // castellated extra where outer pieces snapped off


hole_diameter = 2.3;
hole_spacing = 28.0;
hole_pos_x = 2.0;
hole_pos_y = 2.0;

usb_connector_length = 10;
usb_connector_width = 5;
usb_connector_above_board = 6.1;
usb_from_x = 5.5;
usb_from_y = 0.2;

sensor_housing_base_length = 16.2 ; // x dimension
sensor_housing_base_width = 16.3 ; // y dimension
sensor_housing_base_height = 8.0 ; // z dimension
sensor_from_x = 8.0;
sensor_from_y = 8.0;

module cutout_solid (cylinder_diameter = hole_diameter, cylinder_length = pcb_thickness) {

  translate([0,0,-e])
    linear_extrude(height = cylinder_length + 2*e, center = false) {
    circle(r=cylinder_diameter / 2);
  }
}


module usb_connector (length = usb_connector_length, width = usb_connector_width, height = usb_connector_above_board) {
  cube([length, width, height], center = false);


}

module sensor_housing () {
  base_length = sensor_housing_base_length;
  base_width = sensor_housing_base_width;
  base_height = sensor_housing_base_height;


  color("DarkGrey")
  union() {
    cube([base_length, base_width, base_height], center = false);
  }
}


module elp_usbfhd01m_l28_dummy () {

  // the values were empirically iterated upon
  origin_center_inset_x = hole_pos_x;
  origin_center_inset_y = hole_pos_y;
  hole_distance = hole_spacing;
  hole_D = hole_diameter;

  usb_x_pos = pcb_length - usb_from_x - usb_connector_length;
  usb_y_pos = 0 + usb_from_y;

  sensor_x_pos = 0 + sensor_from_x - (1/2)*(sensor_housing_base_length-16);
  sensor_y_pos = 0 + sensor_from_y - (1/2)*(sensor_housing_base_width-16);
  sensor_z_pos = pcb_thickness;


  origin = [origin_center_inset_x,  origin_center_inset_y];

  corner_hole_positions = [[origin.x + 0,             origin.y + 0],
                           [origin.x + hole_distance, origin.y + 0],
                           [origin.x + 0,             origin.y + hole_distance],
                           [origin.x + hole_distance, origin.y + hole_distance]];



   difference() {
    union() {
      // main PCB
      linear_extrude(height = pcb_thickness, center = false)
        square(size = [pcb_length, pcb_height], center = false);

      // USB connector ("back" of PCB)
      translate([usb_x_pos, usb_y_pos, 0]) {
        mirror([0,0,1])
          usb_connector();
      }

      // sensor housing ("front" of PCB)
      translate([sensor_x_pos, sensor_y_pos, sensor_z_pos]) {
        mirror([0,0,0])
         sensor_housing();
      }


    }

    // Holes
    for (p = corner_hole_positions) {
      translate([p[0], p[1], 0])
        cutout_solid(cylinder_diameter = hole_D);
    }
   }



}



// $preview requires version 2019.05
$fn = $preview ? 30 : 100;


elp_usbfhd01m_l28_dummy();
