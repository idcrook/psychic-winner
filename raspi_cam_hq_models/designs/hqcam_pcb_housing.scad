///////////////////////////////////////////////////////////////////////////////
// Initial Revision: 2020-May-07
// Author: David Crook <idcrook@users.noreply.github.com>
// Description: Design for Raspberry Pi HQ Camera pcb housing
//
// Revisions/Notes:
//
//   2020-May-07: Initial dimensions
//
//   2020-May-08: test 1: get rid of lip, change footprint of pads (interfere
//     with components), get rid of "slot" on upper pads (they were too narrow
//     anyway)
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
DEVELOPING_HQ_Camera_pcb_housing = false;

hqcam_pcb_housing_add_top_lip = !true;

hqcam_pcb_housing_front_face_lip_overhang_width = 1.0;
hqcam_pcb_housing_front_face_lip_overhang_thickness = 1.0;

hqcam_pcb_housing_rear_thickness = 3.5;
hqcam_pcb_housing_sidewall_thickness = 2.0;
hqcam_pcb_housing_lower_sidewall_thickness = 2.0;
hqcam_pcb_housing_upper_sidewall_thickness = hqcam_pcb_housing_lower_sidewall_thickness;
z_delta_lip = (hqcam_pcb_housing_add_top_lip ? hqcam_pcb_housing_front_face_lip_overhang_thickness : 0);
hqcam_pcb_housing_z_height = 9 + tol_e + z_delta_lip;

// positioning reference
hqcam_pcb_z_height = hqcam_pcb_housing_z_height - z_delta_lip -
    pcb_thickness + 0 - tol_e;

hqcam_pcb_housing_rear_face_width = pcb_width + 2*hqcam_pcb_housing_rear_thickness + 0 ;
hqcam_pcb_housing_rear_face_height = pcb_height + 2*hqcam_pcb_housing_rear_thickness + 0 ;


hqpcb_hole_diameter_pad = hqpcb_hole_diameter - 0.3;

module attach_arms_directly_to_pcb_housing (attach_flush_to_bottom = true,
                                            use_subdir_stl = false)
{
    flush_attach = attach_flush_to_bottom;
    position_z = flush_attach
        ? 0 : (1/2)*(hqcam_pcb_housing_z_height - 8 - tol_e) - e;

    housing_model_path = (!use_subdir_stl)
        ? "camera_housing.STL"
        : "designs/camera_housing.STL";

    // position model
    translate([(1/2)*(38 - 30) + hqcam_pcb_housing_sidewall_thickness,
               -13,
               position_z])
    {
        intersection ()
        {
            import(housing_model_path);
            translate([0, -e, -e])
                cube([30,13+2*e,10]);
        }
    }
}

module hqcam_pcb_housing (instantiate_reference_hqcam_model = false,
                          attach_arms = true, use_subdir_stl = false,
                          install_tripod_mount = false) {


    if (instantiate_reference_hqcam_model) {
        translate([pcb_width + hqcam_pcb_housing_sidewall_thickness,
                   pcb_height + hqcam_pcb_housing_lower_sidewall_thickness,
                   hqcam_pcb_z_height])
            /* hqcam_pcb_housing_rear_thickness + pcb_thickness]) */
            rotate([0,0,180])
            %raspi_hq_camera_model(install_tripod_mount = install_tripod_mount);
    }

    cuffs_on_upper = true;
    beyond_upper = cuffs_on_upper ? 0 : 4;
    cutout_x =  pcb_width + 2*tol_e;
    cutout_y =  pcb_height + beyond_upper + 2*tol_e;
    cutout_z_w_lip = hqcam_pcb_housing_z_height
        - hqcam_pcb_housing_rear_thickness
        - hqcam_pcb_housing_front_face_lip_overhang_thickness + 2*e;
    cutout_z_wo_lip =  cutout_z_w_lip + hqcam_pcb_housing_front_face_lip_overhang_thickness;
    cutout_z = hqcam_pcb_housing_add_top_lip ? cutout_z_w_lip : cutout_z_wo_lip;

    lip_translate_x = tol_e + hqcam_pcb_housing_front_face_lip_overhang_width;
    lip_translate_y = tol_e + hqcam_pcb_housing_front_face_lip_overhang_width;
    lip_inside_cutout_x = cutout_x - 2*lip_translate_x;
    lip_inside_cutout_y = cutout_y - 2*lip_translate_x;
    lip_r = 1;

    upper_cuff_cutout_x = csi_connector_width + 2*tol_e;
    upper_cuff_cutout_y = hqcam_pcb_housing_upper_sidewall_thickness ;
    upper_cuff_cutout_z = cutout_z;

    upper_cuff_translate_x = (1/2)* (cutout_x - upper_cuff_cutout_x + tol_e) ;
    upper_cuff_translate_y = cutout_y - e;
    upper_cuff_translate_z = -e ;

    // hole centered 4mm from edge of pcb, pcb ring around hole is r=2.5mm
    pad_x = 4 + 3;
    pad_y = 4 + 2.5 ;
    pad_z_w_lip = hqcam_pcb_housing_z_height - cutout_z - pcb_thickness + 2*tol_e;
    pad_z_wo_lip =  hqcam_pcb_housing_z_height - cutout_z;
    pad_z = hqcam_pcb_housing_add_top_lip ? pad_z_w_lip : pad_z_wo_lip;


    // first hole (lower left) relative to PCB "corner"
    hole_origin = [hqpcb_hole_pos_x + tol_e,  hqpcb_hole_pos_y + tol_e];
    hole_distance = hqpcb_hole_spacing;
    hole_offset_x = - 4 - tol_e;
    hole_offset_x_far = - (2.5 + tol_e);
    hole_offset_y = - 4 - tol_e;
    hole_offset_y_far = 0 - 2.5 ;

    corner_hole_positions = [[hole_origin.x,                 hole_origin.y],
                             [hole_origin.x + hole_distance, hole_origin.y + 0],
                             [hole_origin.x + 0,             hole_origin.y + hole_distance],
                             [hole_origin.x + hole_distance, hole_origin.y + hole_distance]];

    corner_pad_positions = [[corner_hole_positions[0].x + hole_offset_x,
                             corner_hole_positions[0].y + hole_offset_y],
                            [corner_hole_positions[1].x + hole_offset_x_far,
                             corner_hole_positions[1].y + hole_offset_y],
                            [corner_hole_positions[2].x + hole_offset_x,
                             corner_hole_positions[2].y + hole_offset_y_far],
                            [corner_hole_positions[3].x + hole_offset_x_far,
                             corner_hole_positions[3].y + hole_offset_y_far]];

    if (attach_arms) {
        attach_arms_directly_to_pcb_housing(attach_flush_to_bottom = true,
                                            use_subdir_stl = use_subdir_stl);
    }

    // main body
    difference ()
    {
        linear_extrude(height = hqcam_pcb_housing_z_height)
            square(pcb_width + 2* hqcam_pcb_housing_sidewall_thickness);

        // cut out main area for camera pcb placement
        translate([hqcam_pcb_housing_sidewall_thickness - tol_e,
                   hqcam_pcb_housing_lower_sidewall_thickness - tol_e,
                   hqcam_pcb_housing_rear_thickness])
        {
            linear_extrude(height = cutout_z)
                complexRoundSquare([cutout_x, cutout_y], rads1=[lip_r,lip_r], rads2=[lip_r,lip_r], rads3=[lip_r,lip_r], rads4=[lip_r,lip_r], center=false);

            // lip overhang
            translate([lip_translate_x, lip_translate_y, hqcam_pcb_housing_sidewall_thickness - tol_e]) // start higher
                linear_extrude(height = cutout_z)
                complexRoundSquare([lip_inside_cutout_x, lip_inside_cutout_y], rads1=[lip_r,lip_r], rads2=[lip_r,lip_r], rads3=[lip_r,lip_r], rads4=[lip_r,lip_r], center=false);

            // cuff cutout
            translate([upper_cuff_translate_x, upper_cuff_translate_y, upper_cuff_translate_z])
                linear_extrude(height = upper_cuff_cutout_z)

                square([upper_cuff_cutout_x, upper_cuff_cutout_y],center=false);

            // screw holes
            for (p = corner_hole_positions) {
                translate([p[0], p[1], -hqcam_pcb_housing_rear_thickness -e])
                {
                    cutout_solid(cylinder_diameter = hqpcb_hole_diameter_pad,
                                 cylinder_length = hqcam_pcb_housing_rear_thickness + 2*e);

                    // guide rings
                    cutout_solid(cylinder_diameter = hqpcb_hole_pcb_ring_diameter,
                                 cylinder_length = 2*e);
                    %translate([0, 0, hqcam_pcb_housing_rear_thickness + pad_z])
                         cutout_solid(cylinder_diameter = hqpcb_hole_pcb_ring_diameter,
                                      cylinder_length = 2*e);
                }
            }
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
                    cutout_solid(cylinder_diameter = hqpcb_hole_diameter_pad,
                                 cylinder_length = pad_z + 2*e);
            }
            // cut a bevel in corner
            translate([corner_hole_positions[0].x,
                       corner_pad_positions[0].y ,
                       e])
                rotate([0,0,45])
                translate([hqpcb_hole_pcb_ring_diameter + (1+0)*tol_e,0,0])
                linear_extrude(height = pad_z + 2*e)
                square([pad_x + tol_e, pad_y + tol_e + 2*e], center=false);
            // cut a bevel in corner
            translate([corner_hole_positions[1].x - pad_x - tol_e,
                       corner_pad_positions[1].y + pad_y + tol_e,
                       e])
                rotate([0,0,-45])
                translate([-((1/2)*hqpcb_hole_pcb_ring_diameter+tol_e),0,0])
                linear_extrude(height = pad_z + 2*e)
                square([pad_x + tol_e, pad_y + tol_e + 2*e], center=false);
            // *NOT NEEDED: slots so back bracket outcrops can slide by
            *translate([corner_hole_positions[2].x + 1.5,
                        corner_pad_positions[2].y - e,
                        (1/4)* pad_z])
                linear_extrude(height = pad_z)
                square([pad_x + tol_e, pad_y + tol_e + 2*e], center=false);
            *translate([corner_hole_positions[3].x - 1.5 - pad_x - tol_e,
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
        hqcam_pcb_housing(instantiate_reference_hqcam_model = true,
                          attach_arms = true);

        // for testing/viewing in isolation
        %translate([50,0,0])
         {
             attach_arms_directly_to_pcb_housing(attach_flush_to_bottom = false);
             hqcam_pcb_housing(instantiate_reference_hqcam_model = false,
                               attach_arms = false);
         }
    }
}
