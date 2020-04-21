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

/* pi_pcb_rect_inset_right = 39.6; */
/* pi_pcb_rect_inset_top = 25.0; */
/* pi_pcb_rect_inset_left = 39.6; */
/* pi_pcb_rect_inset_bottom = 25.0; */

// assume instead position is center of rectangular PCB region
pi_pcb_rect_inset_right = (1/2) * (pcb_rectangular_width - pi_width);
pi_pcb_rect_inset_top = (1/2) * (pcb_rectangular_height - pi_height);
pi_pcb_rect_inset_left = pi_pcb_rect_inset_right;
pi_pcb_rect_inset_bottom = pi_pcb_rect_inset_top;
pi_pcb_riser_z_height = 7.4 - pi_pcb_thickness;

gift_foot_length = 60.0;
gift_foot_width = 12.3;
gift_foot_leg_height = 7.0;
gift_foot_angle_degrees = 45;

gift_foot_screw_slot_base_to_peak_height = 12.7;
gift_foot_screw_slot_start_to_front_face = 14.0;
gift_foot_screw_slot_face_height = 13.0;
gift_foot_screw_slot_length_delta = 0.2;
gift_foot_screw_slot_length = 6.5 + gift_foot_screw_slot_length_delta;
gift_foot_screw_slot_width = 8.0; // cut into gift_foot_width
gift_foot_screw_slot_hole_diameter = 2.5;
gift_foot_screw_slot_hole_center_from_edge = 3.0;



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



module gift_stand_foot (total_length = gift_foot_length,
                        total_width = gift_foot_width,
                        leg_height = gift_foot_leg_height,
                        angle_slot_total_length = gift_foot_screw_slot_start_to_front_face,
                        angle_slot_total_height = gift_foot_screw_slot_base_to_peak_height,
                        angle_degrees = gift_foot_angle_degrees ,
                        screw_hole_diameter = gift_foot_screw_slot_hole_diameter,
                        screw_hole_center = gift_foot_screw_slot_hole_center_from_edge,
                        screw_hole_slot_length = gift_foot_screw_slot_length,
                        screw_hole_slot_width = gift_foot_screw_slot_width) {

    // back leg portion
    leg_length = total_length - angle_slot_total_length;
    leg_radius = 0.5;


    // face
    side_face_length = gift_foot_screw_slot_face_height;
    side_face_width = leg_height;
    side_face_radius_top = leg_radius;
    side_face_radius_bottom = (1/2)*side_face_width ;
    side_face_radius_subtract = 0.0;

    side_face_translate_x = leg_length ;// + cos(angle_degrees)*side_face_length;
    side_face_translate_y_delta = 1.5;
    side_face_translate_y = sin(angle_degrees)*side_face_length - side_face_translate_y_delta;
    side_face_subtract_translate_x = cos(angle_degrees)*side_face_length;

    // screw slot
    slot_thickness = pcb_thickness;
    slot_width =  screw_hole_slot_width;
    slot_height = screw_hole_slot_length;
    slot_radius =  3.25; //(1/2)*slot_width;

    slot_hole_diameter = screw_hole_diameter;
    slot_hole_center = screw_hole_center;
    slot_hole_depth = 5.0;

    difference () {

        hull() {
            // position face at angle
            translate([side_face_translate_x, side_face_translate_y , 0])
                rotate([0,0, (360- (90 - angle_degrees))])

                // side facing
                linear_extrude(height = total_width, center = false)
                complexRoundSquare([side_face_length, side_face_width],
                                   [side_face_radius_top, side_face_radius_top],
                                   [side_face_radius_bottom, side_face_radius_bottom],
                                   [side_face_radius_bottom, side_face_radius_bottom],
                                   [side_face_radius_top, side_face_radius_top],
                                   center = false);
            // leg portion side
            translate([0, 0, 0])
                // side facing
                linear_extrude(height = total_width, center = false)
                complexRoundSquare([leg_length, leg_height],
                                   [leg_radius, leg_radius],
                                   [leg_radius, leg_radius],
                                   [leg_radius, leg_radius],
                                   [leg_radius, leg_radius],
                                   center = false);
        } // positive part

        /* start of cuts */

        // top profile
        translate([0, leg_height, -e]) //-2*e])
            union () {
            // position face at angle
            translate([side_face_translate_x - side_face_subtract_translate_x, side_face_translate_y + side_face_translate_y_delta, 0])
                rotate([0,0, (360- (90 - angle_degrees))])
                // side facing
                linear_extrude(height = total_width + 2*e, center = false)
                complexRoundSquare([side_face_length, side_face_width + side_face_translate_y_delta],
                                   [side_face_radius_subtract, side_face_radius_subtract],
                                   [side_face_radius_subtract, side_face_radius_subtract],
                                   [side_face_radius_subtract, side_face_radius_subtract],
                                   [side_face_radius_subtract, side_face_radius_subtract],
                                   center = false);
            // leg portion side
            translate([0, 0, 0])
                // side facing
                linear_extrude(height = total_width + 2*e, center = false)
                complexRoundSquare([leg_length, leg_height],
                                   [leg_radius, leg_radius],
                                   [leg_radius, leg_radius],
                                   [leg_radius, leg_radius],
                                   [leg_radius, leg_radius],
                                   center = false);
        }

        distance_to_center_slot = (1/2)*(total_width - slot_width) ;
        // screw slot and hole
        translate([5.25, (1/2)*gift_foot_screw_slot_length - gift_foot_screw_slot_length_delta, distance_to_center_slot-e]) //-2*e])
            union () {
            // position face at angle
            translate([side_face_translate_x, side_face_translate_y + side_face_translate_y_delta, 0])
                rotate([0,0, (360- (90 - angle_degrees))])
                rotate([90,0,0]) {
                // side facing
                linear_extrude(height = slot_thickness + 2*e, center = false)
                complexRoundSquare([slot_height, slot_width],
                                   [leg_radius, leg_radius],
                                   [slot_radius, slot_radius],
                                   [slot_radius, slot_radius],
                                   [leg_radius, leg_radius],
                                   center = false);
            translate([slot_hole_center, (1/2)*slot_width, 0])
                linear_extrude(height = slot_hole_depth + slot_thickness + 2*e, center = false)
                    circle(r=(1/2)*slot_hole_diameter);
            }
        }

    }
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
    // TODO: "gift" legs
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

        translate([0,  rectangular_pcb_y_origin, 0 ])
            translate([pcb_rectangular_width - pi_pcb_rect_inset_left,    pi_pcb_rect_inset_bottom, -pi_pcb_riser_z_height])
            rotate([0, 180, 0])

            // from https://www.thingiverse.com/thing:1701186/
            // "Raspberry Pi 3 Reference Design Model B Rpi Raspberrypi"
            import ("Raspberry_Pi_3_Light_Version.STL");
    }


    if (true)  {  // (showLegs) {

        translate([ -(60 + 10), 0, 0])
            rotate([0, 0, 0])
            gift_stand_foot();
    }


}



// $preview requires version 2019.05
$fn = $preview ? 30 : 100;


if (DEVELOPING_HDMI_7inch_touchscreen__dummy) {
    HDMI_7inch_touchscreen__dummy();
}
