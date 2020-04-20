///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2020-Apr-20
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
//   2020-Apr-20: Initial dimensions
//
//
///////////////////////////////////////////////////////////////////////////////

use <MCAD/2Dshapes.scad>
// defines complexRoundSquare()

e = 1/128; // small number

// determines whether model is instantiated by this file

// Normally set to false for using as an include file
DEVELOPING_HDMI_7inch_touchscreen__dummy = false;

pcb_thickness = 1.7;
pcb_width = 165.05;
pcb_height = 122.2;

pcb_rectangular_width = pcb_width;
pcb_rectangular_height = 107.0;

pcb_corner_screw_pad_width = 7.95;
pcb_corner_screw_pad_to_screw_pad = 149;

pcb_side_leg_height = pcb_height;
pcb_side_leg_width = pcb_corner_screw_pad_width;

pcb_keepout_back = 4 - pcb_thickness;

lcd_width = pcb_width;
lcd_height = 101.3;
lcd_screen_inset_left   = 3.0;
lcd_screen_inset_top    = 4.0;
lcd_screen_inset_right  = 6.5;
lcd_screen_inset_bottom = 7.5;

pcb_to_lcd_glass = 8.5;
pcb_to_edge_lcd_top = 3.0;
pcb_to_edge_lcd_bottom = 3.0;

hole_diameter = 2.9;
hole_center_x_from_origin = pcb_corner_screw_pad_width / 2;
hole_center_y_from_origin = 4; // 3.1;
first_hole_pos_x = hole_center_x_from_origin;
first_hole_pos_y = hole_center_y_from_origin;
hole_spacing_width = pcb_corner_screw_pad_to_screw_pad + 2 * (1/2) * pcb_corner_screw_pad_width ;
hole_spacing_height = pcb_height - 2 * hole_center_y_from_origin ;


pi_width = 85.0;
pi_height = 56.0;
pi_z_height = 17.0;
pi_pcb_thickness = 1.7;

pi_pcb_rect_inset_right = 39.6;
pi_pcb_rect_inset_top = 25.0;
pi_pcb_rect_inset_left = 39.6;
pi_pcb_rect_inset_bottom = 25.0;
pi_pcb_riser_z_height = 7.4 - pi_pcb_thickness;

module cutout_solid (cylinder_diameter = hole_diameter, cylinder_length = pcb_thickness) {
    translate([0,0,-e])
        linear_extrude(height = cylinder_length + 2*e, center = false) {
        circle(r=cylinder_diameter / 2);
    }
}

/* module keepout_spacer (block_side = keepout_spacer_side , block_height = pcb_keepout_back) { */
/*     translate([0,0,-e]) */
/*         linear_extrude(height = block_height + 2*e, center = false) { */
/*         square(size = block_side, center = false); */
/*     } */
/* } */


module pcb_side_leg (height = pcb_side_leg_height, width = pcb_side_leg_width, thickness = pcb_thickness) {

    radius = width / 2;

    // screw bracket "wings"
    translate([0, 0, 0])
        linear_extrude(height = thickness, center = false)
        complexRoundSquare([width, height],
                           [radius, radius],
                           [radius, radius],
                           [radius, radius],
                           [radius, radius],
                           center = false);
}



module lcd_assembly (width = lcd_width, height = lcd_height, thickness = pcb_to_lcd_glass) {

    active_area_x_start = lcd_screen_inset_left;
    active_area_y_start = lcd_screen_inset_bottom;

    color("DarkGrey")
        union() {

        // main
        cube([width, height, thickness], center = false);

    }

    active_area_width = width - active_area_x_start - lcd_screen_inset_right;
    active_area_height = height -  active_area_y_start - lcd_screen_inset_top;

    color("Black")
        union() {

        // active area
        translate([active_area_x_start, active_area_y_start, thickness])
            cube([active_area_width, active_area_height, e], center = false);

    }



}

module HDMI_7inch_touchscreen__dummy (showPi = false) {

    origin_center_inset_x = first_hole_pos_x;
    origin_center_inset_y = first_hole_pos_y;
    hole_distance_x = hole_spacing_width;
    hole_distance_y = hole_spacing_height;
    hole_D = hole_diameter;

    rectangular_pcb_x_origin = 0 ;
    rectangular_pcb_y_origin = (1/2) * (pcb_height - pcb_rectangular_height) ;


    hole_origin = [origin_center_inset_x,  origin_center_inset_y];

    corner_hole_positions = [[hole_origin.x + 0,               hole_origin.y + 0],
                             [hole_origin.x + hole_distance_x, hole_origin.y + 0],
                             [hole_origin.x + 0,               hole_origin.y + hole_distance_y],
                             [hole_origin.x + hole_distance_x, hole_origin.y + hole_distance_y]];

    // TODO: USB connector keepouts
    // TODO: Power (microUSB) connector keepout
    // TODO: Raspi keepout area
    // TODO: LCD keepout areas
    // TODO: misc. PCB keepout areas

    // PCB footprint
    difference() {

        intersection () {
            union() {

                // rectangular PCB portion
                translate([rectangular_pcb_x_origin, rectangular_pcb_y_origin, 0]) {
                    linear_extrude(height = pcb_thickness, center = false)
                        square(size = [pcb_rectangular_width, pcb_rectangular_height], center = false);
                }
                // two side "legs", screw hole on each corner for attachment
                translate([0, 0, 0]) {
                    pcb_side_leg();
                }

                translate([pcb_rectangular_width -  pcb_side_leg_width, 0, 0]) {
                    pcb_side_leg();
                }
            }
            // main PCB footprint / outline
            linear_extrude(height = pcb_thickness, center = false)
                square(size = [pcb_width, pcb_height], center = false);


        }

        // SUBTRACTIVE

        // Holes
        for (p = corner_hole_positions) {
            translate([p[0], p[1], 0])
                cutout_solid(cylinder_diameter = hole_D);
        }
    }

    // lcd screen on PCB
    translate([rectangular_pcb_x_origin,  rectangular_pcb_y_origin + pcb_to_edge_lcd_bottom, pcb_thickness]) {
        lcd_assembly();
    }


    if (showPi) {

        translate([0,  rectangular_pcb_y_origin + pi_pcb_rect_inset_bottom, 0])
        rotate([180, 0, 0])
        translate([rectangular_pcb_x_origin,  - rectangular_pcb_y_origin, 0 /* pcb_thickness */])
        translate([pi_pcb_rect_inset_left,    -2 * pi_pcb_rect_inset_bottom, pi_pcb_riser_z_height])

            // from https://www.thingiverse.com/thing:1701186/
            // "Raspberry Pi 3 Reference Design Model B Rpi Raspberrypi"
            import ("Raspberry_Pi_3_Light_Version.STL");
    }

}



// $preview requires version 2019.05
$fn = $preview ? 30 : 100;


if (DEVELOPING_HDMI_7inch_touchscreen__dummy) {
    HDMI_7inch_touchscreen__dummy();
}
