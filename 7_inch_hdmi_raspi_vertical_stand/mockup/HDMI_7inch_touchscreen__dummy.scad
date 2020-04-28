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

// Normally set to 'false' - for use as include file (variables are exported)
// setting to 'true' and opening file in Openscad will instantiate models
DEVELOPING_HDMI_7inch_touchscreen__dummy = false;

pcb_thickness = 1.7;
pcb_width = 165.05 + 1.2 - 1.33;
pcb_height = 122.9 + 0.5;

pcb_rectangular_width = pcb_width;
pcb_rectangular_height = 107.4;

pcb_rectangular_x_origin = 0 ;
pcb_rectangular_y_origin = (1/2) * (pcb_height - pcb_rectangular_height) ;

pcb_corner_screw_pad_width = 7.95;
pcb_corner_screw_pad_to_screw_pad = 149;

pcb_side_leg_height = pcb_height;
pcb_side_leg_width = pcb_corner_screw_pad_width;

pcb_keepout_back = 4 - pcb_thickness;

lcd_width = pcb_width;
lcd_height = 101.3 - 0.3;
lcd_screen_inset_left   = 3.0;
lcd_screen_inset_top    = 4.0;
lcd_screen_inset_right  = 6.5;
lcd_screen_inset_bottom = 7.5;

pcb_to_lcd_glass = 8.5;
pcb_to_edge_lcd_top = 3.0;
pcb_to_edge_lcd_bottom = 3.0 + 2.0;

hole_diameter = 2.9;
hole_center_x_from_origin = pcb_corner_screw_pad_width / 2;
hole_center_y_from_origin = 4; // 3.1;
first_hole_pos_x = hole_center_x_from_origin;
first_hole_pos_y = hole_center_y_from_origin;
spacing_width_fudge = +0.7;
spacing_height_fudge = +1.05;
hole_spacing_width = pcb_corner_screw_pad_to_screw_pad + 2 * (1/2) * pcb_corner_screw_pad_width + spacing_width_fudge ;
hole_spacing_height = pcb_height - (2 * hole_center_y_from_origin) + spacing_height_fudge ;

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

microusb_keepout_width = 15;
microusb_keepout_height = 10;
microusb_keepout_z_height = 20;

flex_keepout_height = 4;
flex_keepout_z_height = 2.5;

flex1_distance_from_edge = 5.0;
flex1_width = 26.5;
flex1_height = 5.5;

flex2_distance_from_edge = 69.0;
flex2_width = 30;

pipower_distance_from_edge = 42.5;
pipower_distance_below_pcb =  2.5;


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

module microusb_keepout (height = microusb_keepout_height, width = microusb_keepout_width,
                         length = microusb_keepout_z_height, mycolor = "Red") {
    radius = 1.0;

    color(mycolor)
    translate([0, 0, 0])
        linear_extrude(height = length, center = false)
        complexRoundSquare([width, height],
                           [radius, radius],
                           [radius, radius],
                           [radius, radius],
                           [radius, radius],
                           center = false);
}


module lcd_flex_keepout (height = flex_keepout_height, width = 10,
                     length = flex_keepout_z_height) {
    radius = 1.0;

    color("Red")
    translate([0, 0, 0])
        linear_extrude(height = length, center = false)
        complexRoundSquare([width, height],
                           [radius, radius],
                           [radius, radius],
                           [radius, radius],
                           [radius, radius],
                           center = false);
}



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

    color("White")
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

        // Cut: screw slot and hole
        distance_to_center_slot = (1/2)*(total_width - slot_width) ;
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

    showLcdKeepouts = true;
    showPiPowerKeepouts = true;
    showUsbKeepouts = true;
    showPcbKeepouts = true;

    origin_center_inset_x = first_hole_pos_x;
    origin_center_inset_y = first_hole_pos_y;
    hole_distance_x = hole_spacing_width;
    hole_distance_y = hole_spacing_height;
    hole_D = hole_diameter;

    echo("hole_distance_x = ", hole_distance_x );
    echo("hole_distance_y = ", hole_distance_y );

    hole_origin = [origin_center_inset_x,  origin_center_inset_y];

    corner_hole_positions = [[hole_origin.x + 0,               hole_origin.y + 0],
                             [hole_origin.x + hole_distance_x, hole_origin.y + 0],
                             [hole_origin.x + 0,               hole_origin.y + hole_distance_y],
                             [hole_origin.x + hole_distance_x, hole_origin.y + hole_distance_y]];

    // TODO: misc. PCB keepout areas

    // PCB footprint
    difference() {

        intersection () {
            union() {

                // rectangular PCB portion
                translate([pcb_rectangular_x_origin, pcb_rectangular_y_origin, 0]) {
                    linear_extrude(height = pcb_thickness, center = false)
                        square(size = [pcb_rectangular_width, pcb_rectangular_height], center = false);
                }
                // two side "legs", screw hole on each corner for attachment
                translate([0, 0, 0]) {
                    pcb_side_leg();
                }

                translate([pcb_rectangular_width - pcb_side_leg_width, 0, 0]) {
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
    translate([pcb_rectangular_x_origin,
               pcb_rectangular_y_origin + pcb_to_edge_lcd_bottom ,
               pcb_thickness]) {
        lcd_assembly();
    }


    if (showPi) {

        translate([0,  pcb_rectangular_y_origin, 0 ])
            translate([pcb_rectangular_width - pi_pcb_rect_inset_left,    pi_pcb_rect_inset_bottom, -pi_pcb_riser_z_height])
            rotate([0, 180, 0])

            // from https://www.thingiverse.com/thing:1701186/
            // "Raspberry Pi 3 Reference Design Model B Rpi Raspberrypi"
            import ("Raspberry_Pi_3_Light_Version.STL");
    }

    flex1_x =  pcb_rectangular_width - flex1_distance_from_edge - flex1_width;
    flex1_y =   -flex_keepout_z_height + pcb_rectangular_y_origin + pcb_to_edge_lcd_bottom ;
    flex1_z =   pcb_thickness + flex1_height; // + flex_keepout_height;

    flex2_x =  pcb_rectangular_width - flex2_distance_from_edge - flex2_width;
    flex2_y =   -flex_keepout_z_height + pcb_rectangular_y_origin + pcb_to_edge_lcd_bottom ;
    flex2_z =   pcb_thickness + flex_keepout_height;

    // LCD keepout areas
    if (showLcdKeepouts) {
        translate([flex1_x, flex1_y, flex1_z])
            rotate([270, 0 ,0])
            translate([0, 0, 0])
            lcd_flex_keepout(width = flex1_width, height = flex1_height );

        translate([flex2_x, flex2_y, flex2_z])
            rotate([270, 0 ,0])
            translate([0, 0, 0])
            lcd_flex_keepout(width = flex2_width);
    }

    pipower_x = pcb_rectangular_width - pipower_distance_from_edge - microusb_keepout_width;
    pipower_y = -microusb_keepout_z_height + pcb_rectangular_y_origin;
    pipower_z = -pipower_distance_below_pcb;

    // Pi power keepout
    if (showPiPowerKeepouts) {
        translate([pipower_x, pipower_y, pipower_z])
            rotate([270, 0 ,0])
            microusb_keepout();
    }

    lcdusb_x = 0;
    lcdusb_y = pcb_rectangular_y_origin + 32.5 ;
    lcdusb_z = (1/2) * (microusb_keepout_height) - pcb_thickness;

    // Pi to LCD USB connector keepout
    if (showUsbKeepouts) {
        translate([lcdusb_x, lcdusb_y, lcdusb_z])
            rotate([-90, 0, 90])
            microusb_keepout();
    }


    // TODO: Raspi keepout area


}



// $preview requires version 2019.05
$fn = $preview ? 30 : 100;


if (DEVELOPING_HDMI_7inch_touchscreen__dummy) {
    HDMI_7inch_touchscreen__dummy(showPi = true);

    if (!true)  {  // (showLegs) {

        // left leg
        translate([10.2, 34.5, -45 + pcb_thickness])
            rotate([90, 0, 270])
            rotate([0, 0, 45])
            translate([0, 0, 0])
            gift_stand_foot();

        // right leg
        translate([10.2 + (pcb_rectangular_width - pcb_side_leg_width), 34.5, -45 + pcb_thickness])
            rotate([90, 0, 270])
            rotate([0, 0, 45])
            translate([0, 0, 0])
            gift_stand_foot();

    }


}
