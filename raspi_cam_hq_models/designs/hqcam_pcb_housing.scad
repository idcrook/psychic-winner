///////////////////////////////////////////////////////////////////////////////
// Initial Revision: 2020-May-07
// Author: David Crook <idcrook@users.noreply.github.com>
// Description: Design for Raspberry Pi HQ Camera pcb housing
//
// Revisions/Notes:
//
//   2020-May-07: Initial dimensions
//
//
//
///////////////////////////////////////////////////////////////////////////////

use <MCAD/2Dshapes.scad>
// module complexRoundSquare()

use <../../libraries/wedge.scad>
// module wedge(h, r, d, fn = $fn)

// import PCB dimensions and camera model
include <../models/HQ_Camera_model.scad>

e = 1/128; // small number
tol_e = 0.25;

// If true, model is instantiated by this file
DEVELOPING_HQ_Camera_pcb_housing = !false;

hqcam_pcb_housing_front_face_lip_overhang_width = 1.0;
hqcam_pcb_housing_front_face_lip_overhang_thickness = 1.0;

hqcam_pcb_housing_rear_thickness = 3.5;
hqcam_pcb_housing_sidewall_thickness = 2.0;
hqcam_pcb_housing_lower_sidewall_thickness = 2.0;
hqcam_pcb_housing_z_height = 8 + hqcam_pcb_housing_front_face_lip_overhang_thickness + tol_e;

// positioning reference
hqcam_pcb_z_height = hqcam_pcb_housing_z_height -
    pcb_thickness - hqcam_pcb_housing_front_face_lip_overhang_thickness - tol_e;

hqcam_pcb_housing_rear_face_width = pcb_width + 2*hqcam_pcb_housing_rear_thickness + 0 ;
hqcam_pcb_housing_rear_face_height = pcb_height + 2*hqcam_pcb_housing_rear_thickness + 0 ;

module hqcam_pcb_housing (instantiate_reference_hqcam_model = false,
                          install_tripod_mount = false) {


    if (instantiate_reference_hqcam_model) {
        translate([pcb_width + hqcam_pcb_housing_sidewall_thickness,
                   pcb_height + hqcam_pcb_housing_lower_sidewall_thickness,
                   hqcam_pcb_z_height])
            /* hqcam_pcb_housing_rear_thickness + pcb_thickness]) */
            rotate([0,0,180])
            %raspi_hq_camera_model(install_tripod_mount = install_tripod_mount);
    }

    beyond_upper = 4;
    cutout_x =  pcb_width + 2*tol_e;
    cutout_y =  pcb_height + hqcam_pcb_housing_lower_sidewall_thickness + beyond_upper;
    cutout_z = hqcam_pcb_housing_z_height
        - hqcam_pcb_housing_rear_thickness
        - hqcam_pcb_housing_front_face_lip_overhang_thickness + 2*e;

    lip_translate_x = tol_e + hqcam_pcb_housing_front_face_lip_overhang_width;
    lip_translate_y = tol_e + hqcam_pcb_housing_front_face_lip_overhang_width;
    lip_inside_cutout_x = cutout_x - 2*lip_translate_x;
    lip_r = 1;

    pad_x = 7;
    pad_y = 8;
    pad_z = hqcam_pcb_housing_z_height - cutout_z - pcb_thickness;


    hole_origin = [hqpcb_hole_pos_x,  hqpcb_hole_pos_y]; // relative to PCB "corner"
    hole_distance = hqpcb_hole_spacing;
    hole_offset_x = - 4;
    hole_offset_x_far = - (2.5 + tol_e);
    hole_offset_y = - 4;

    corner_hole_positions = [[hole_origin.x,                 hole_origin.y],
                             [hole_origin.x + hole_distance, hole_origin.y + 0],
                             [hole_origin.x + 0,             hole_origin.y + hole_distance],
                             [hole_origin.x + hole_distance, hole_origin.y + hole_distance]];

    corner_pad_positions = [[corner_hole_positions[0].x + hole_offset_x,
                             corner_hole_positions[0].y + hole_offset_y],
                            [corner_hole_positions[1].x + hole_offset_x_far,
                             corner_hole_positions[1].y + hole_offset_y],
                            [corner_hole_positions[2].x + hole_offset_x,
                             corner_hole_positions[2].y + hole_offset_y],
                            [corner_hole_positions[3].x + hole_offset_x_far,
                             corner_hole_positions[3].y + hole_offset_y]];
    // main body
    difference ()
    {
        linear_extrude(height = hqcam_pcb_housing_z_height)
            square(pcb_width + 2* hqcam_pcb_housing_sidewall_thickness);

        // cut out slot to slide camera pcb into place
        translate([hqcam_pcb_housing_sidewall_thickness - tol_e,
                   hqcam_pcb_housing_lower_sidewall_thickness - tol_e,
                   hqcam_pcb_housing_rear_thickness])
        {
            linear_extrude(height = cutout_z)
                square([cutout_x, cutout_y]);

            // lip overhang
            translate([lip_translate_x, lip_translate_y, hqcam_pcb_housing_sidewall_thickness - tol_e]) // start higher
                linear_extrude(height = cutout_z)
                complexRoundSquare([lip_inside_cutout_x, cutout_y], rads1=[lip_r,lip_r], rads2=[lip_r,lip_r], rads3=[lip_r,lip_r], rads4=[lip_r,lip_r], center=false);
        }
    }

    // add pads for screw holes
    translate([hqcam_pcb_housing_sidewall_thickness - tol_e,
               hqcam_pcb_housing_lower_sidewall_thickness - tol_e,
               hqcam_pcb_housing_rear_thickness]) {
        difference () {
            for (p = corner_pad_positions) {
                translate([p[0] , p[1] , 0])
                    linear_extrude(height = pad_z)
                    square([pad_x + tol_e, pad_y + tol_e], center=false);
            }
            // SUBTRACTIVE - Holes
            for (p = corner_hole_positions) {
                translate([p[0], p[1], -e])
                    cutout_solid(cylinder_diameter = hqpcb_hole_diameter,
                                 cylinder_length = pad_z + 2*e);
            }

            // slots so back bracket outcrops can slide by
            translate([corner_hole_positions[2].x + 1.5,
                       corner_pad_positions[2].y - e,
                       (1/4)* pad_z])
                linear_extrude(height = pad_z)
                square([pad_x + tol_e, pad_y + tol_e + 2*e], center=false);

            translate([corner_hole_positions[3].x - 1.5 - pad_x - tol_e,
                       corner_pad_positions[3].y - e,
                       (1/4)* pad_z])
                linear_extrude(height = pad_z)
                square([pad_x + tol_e, pad_y + tol_e + 2*e], center=false);


        }
    }

}



// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

if (DEVELOPING_HQ_Camera_pcb_housing)  {

    translate_y = true ? 0 : 90 ;

    translate([0,translate_y,0])
    {
        hqcam_pcb_housing(instantiate_reference_hqcam_model = true);

        translate([50,0,0])
        {
            %translate([(1/2)*(38 - 30) + hqcam_pcb_housing_sidewall_thickness, -13, 0])
                import("camera_housing.STL");
            %hqcam_pcb_housing(instantiate_reference_hqcam_model = false);
        }
    }
}
