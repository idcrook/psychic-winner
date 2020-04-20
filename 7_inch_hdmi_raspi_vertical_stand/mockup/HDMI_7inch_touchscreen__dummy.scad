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
DEVELOPING_HDMI_7inch_touchscreen__dummy = !false;

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


hole_diameter = 2.9;
hole_center_x_from_origin = pcb_corner_screw_pad_width / 2;
hole_center_y_from_origin = 4; // 3.1;
first_hole_pos_x = hole_center_x_from_origin;
first_hole_pos_y = hole_center_y_from_origin;
hole_spacing_width = pcb_corner_screw_pad_to_screw_pad + 2 * (1/2) * pcb_corner_screw_pad_width ;
hole_spacing_height = pcb_height - 2 * hole_center_y_from_origin ;

spacer_pos_x = 2.5;
spacer_pos_y = 2.5;
keepout_spacer_half = spacer_pos_x;
keepout_spacer_side = 2 * keepout_spacer_half;
keepout_spacing = pcb_width - 2*spacer_pos_x;


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


module HDMI_7inch_touchscreen__dummy () {

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
    // TODO: glass display
    // TODO: Raspi keepout area
    // TODO: misc. PCB keepout areas

    /* keepout_center_inset_x = spacer_pos_x; */
    /* keepout_center_inset_y = spacer_pos_y; */
    /* keepout_side = keepout_spacer_side; */
    /* keepout_offset = keepout_spacer_half; */
    /* keepout_distance = keepout_spacing; */

    /* usb_x_pos = pcb_width - usb_from_x - usb_connector_length; */
    /* usb_y_pos = 0 + usb_from_y; */

    /* sensor_x_pos = 0 + sensor_from_x - (1/2)*(sensor_housing_base_length-16); */
    /* sensor_y_pos = 0 + sensor_from_y - (1/2)*(sensor_housing_base_width-16); */
    /* sensor_z_pos = pcb_thickness; */

    difference() {

        intersection () {
            union() {

                // rectangular PCB portion
                translate([rectangular_pcb_x_origin, rectangular_pcb_y_origin, 0]) {
                    linear_extrude(height = pcb_thickness, center = false)
                        square(size = [pcb_rectangular_width, pcb_rectangular_height], center = false);
                }


                // the screw hole "legs" on each corner for attachment
                translate([0, 0, 0]) {
                    pcb_side_leg();
                }

                translate([pcb_rectangular_width -  pcb_side_leg_width, 0, 0]) {
                    pcb_side_leg();
                }


                /* // USB connector ("back" of PCB and through-hole) */
                /* translate([usb_x_pos, usb_y_pos, 0]) { */
                /*     usb_connector(); */
                /* } */

                /* // sensor housing ("front" of PCB) */
                /* translate([sensor_x_pos, sensor_y_pos, sensor_z_pos]) { */
                /*   mirror([0,0,0]) */
                /*    sensor_housing(); */
                /* } */

                /* // spacers */
                /* color("Green") */
                /*     mirror([0,0,1]) */
                /*     for (p = corner_spacer_positions) { */
                /*         translate([p[0] , p[1] , 0]) */
                /*             keepout_spacer(); */
                /*     } */
            }
            // main PCB footprint
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



    }



// $preview requires version 2019.05
    $fn = $preview ? 30 : 100;

/* if (DEVELOPING_HDMI_7inch_touchscreen__dummy && false) { */
/*   // sizing up mount size */
/*   intersection() { */
/*     union() { */
/*       translate([0,0,80]) */
/*         import( "../files/FronCover_NEW.stl"); */
/*     } */
/*     translate([7-e,21-e,-24]) { */
/*       cube([5+2*e,10+2*e,12], center=false); */
/*       %translate([0, 6, 6.5]) */
/*          rotate([0,90,0]) */
/*          cutout_solid (cylinder_diameter = 3.6, cylinder_length = 5.0); */
/*     } */
/*   } */
/* } */

    if (DEVELOPING_HDMI_7inch_touchscreen__dummy) {
        HDMI_7inch_touchscreen__dummy();
    }
