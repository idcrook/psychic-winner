///////////////////////////////////////////////////////////////////////////////
// Initial Revision: 2020-May-07
// Author: David Crook <idcrook@users.noreply.github.com>
//
// Description:
//
//   Various mount or stand options for HQ cam and lenses
//
// Revisions/Notes:
//
// 2020-May-07: Start with models for camera and a PoE VESA mount case
//
//
//
///////////////////////////////////////////////////////////////////////////////

use <MCAD/2Dshapes.scad>
// module complexRoundSquare()

/* Pi HQ camera model - include allows variables in that files scope */
//use <models/HQ_Camera_model.scad>
include <models/HQ_Camera_model.scad>

/* also includes Pi HQ camera model, so not needed above */
//use <designs/hqcam_pcb_housing.scad>
include <designs/hqcam_pcb_housing.scad>

//use <models/Lens_6mm_model.scad>
include <models/Lens_6mm_model.scad>

//use <models/Lens_16mm_model.scad>
include <models/Lens_16mm_model.scad>

e = 1/128; // small number

camera_zero_translate_y_with_tripod_mount = tripod_mount_base_height + (1/2) * (sensor_housing_base_outer_diameter - pcb_height) ;
camera_zero_translate_z = pcb_back_sensor_housing_fastener_z_height;

// center is middle of pcb
lens_6mm_translate_x = (1/2)*(pcb_width - body_diameter_6mm);
lens_6mm_translate_y = (1/2)*(pcb_height - body_diameter_6mm);
lens_6mm_translate_z = (pcb_thickness + back_focal_length_6mm);

lens_16mm_translate_x = (1/2)*(pcb_width - body_diameter_16mm);
lens_16mm_translate_y = (1/2)*(pcb_height - body_diameter_16mm);
// takes into account C/CS adapter ring
lens_16mm_translate_z = (pcb_thickness +  back_focal_length_16mm );

vesa_poe_case_top_extent_x = 96.2;
vesa_poe_case_top_extent_y = 73.8;
vesa_poe_case_top_extent_z = 15.5;
vesa_poe_case_top_translate_x = -vesa_poe_case_top_extent_x + 19.2;
vesa_poe_case_top_translate_y = -vesa_poe_case_top_extent_y + 5.7;
vesa_poe_case_top_translate_z = -vesa_poe_case_top_extent_z;

mount_footer_extent_x = 11.7;
mount_footer_extent_y = 62.1;
mount_footer_extent_z = 16.0;
mount_footer_translate_x = 96.2;
mount_footer_translate_y = 0;
mount_footer_translate_z = vesa_poe_case_top_extent_z;

original_picam_housing_extent_x = 30.0;
original_picam_housing_extent_y = 38.0;
original_picam_housing_extent_z =  8.0;
original_picam_housing_translate_x = 21.8; // -y in original
original_picam_housing_translate_y = vesa_poe_case_top_extent_z + mount_footer_extent_z - 6.8; // z in original
original_picam_housing_translate_z = -12.5; // -x in original

hqpicam_housing_attach_legs_height = 4;
hqpicam_housing_extent_x = 30.0;
hqpicam_housing_extent_y = 38.0;
hqpicam_housing_extent_z =  8.0;
hqpicam_housing_translate_x = 15.8; // -y in original
hqpicam_housing_translate_y = vesa_poe_case_top_extent_z + mount_footer_extent_z + hqpicam_housing_attach_legs_height; // z in original
hqpicam_housing_translate_z = -12.5; // -x in original

module camera_only (include_tripod_mount = true) {
    // position so base of tripod mount is at y==0
    translate([0,
               camera_zero_translate_y_with_tripod_mount,
               camera_zero_translate_z]) {
        raspi_hq_camera_model(install_ccs_adapter = false,
                              install_tripod_mount = include_tripod_mount);
    }
}

module camera_ccs_adapter_only (include_tripod_mount = true) {
    // position so base of tripod mount is at y==0
    translate([0,
               camera_zero_translate_y_with_tripod_mount,
               camera_zero_translate_z]) {
        raspi_hq_camera_model(install_ccs_adapter = true,
                              install_tripod_mount = include_tripod_mount);
    }

}

module camera_and_6mm_assembly (include_tripod_mount = true) {

    // position so base of tripod mount is at y==0
    translate([0,
               camera_zero_translate_y_with_tripod_mount,
               camera_zero_translate_z]) {

        raspi_hq_camera_model(install_ccs_adapter = false,
                              install_tripod_mount = include_tripod_mount);

        translate([lens_6mm_translate_x,
                   lens_6mm_translate_y,
                   lens_6mm_translate_z])
            lens_6mm_model();
    }
}

module camera_and_16mm_assembly (include_tripod_mount = true) {

    // position so base of tripod mount is at y==0
    translate([0,
               camera_zero_translate_y_with_tripod_mount,
               camera_zero_translate_z]) {

        raspi_hq_camera_model(install_ccs_adapter = true,
                              install_tripod_mount = include_tripod_mount);

        translate([lens_16mm_translate_x,
                   lens_16mm_translate_y,
                   lens_16mm_translate_z])
            lens_16mm_model();
    }
}

module vesa_poe_case_top () {
    import("designs/RasPi3Case-Top-PoE.stl");
}

module open_chassis_vesa_poe_case_top () {
    open_chassis_frame_thickness = 3.0 + 0.8; // not exclusively applied
    top_poe_main_z_height = 14; // just a number

    open_chassis_sides_cut_translate_x = 10 + 2.5;
    open_chassis_sides_cut_translate_y = 0;
    open_chassis_sides_cut_translate_z = open_chassis_frame_thickness;
    open_chassis_sides_cut_width = 50.8 + 5.2;
    open_chassis_sides_cut_height = vesa_poe_case_top_extent_y;
    open_chassis_sides_cut_z_height = top_poe_main_z_height  - open_chassis_frame_thickness;

    open_chassis_ends_cut_translate_x = 0;
    open_chassis_ends_cut_translate_y = -vesa_poe_case_top_extent_y + 20 - 2.5 ;
    open_chassis_ends_cut_translate_z = open_chassis_frame_thickness;
    open_chassis_ends_cut_width = 38 + 2*2;
    open_chassis_ends_cut_height = vesa_poe_case_top_extent_y - 6;
    open_chassis_ends_cut_z_height = top_poe_main_z_height  - open_chassis_frame_thickness + 2;

    open_chassis_top_cut_translate_x = open_chassis_sides_cut_translate_x - 1.3;
    open_chassis_top_cut_translate_y = open_chassis_ends_cut_translate_y - 4.3;
    open_chassis_top_cut_translate_z = -(1/2)*open_chassis_frame_thickness;
    open_chassis_top_cut_width = open_chassis_ends_cut_width + 2*4.5;
    open_chassis_top_cut_height = open_chassis_sides_cut_width + 1.3;
    open_chassis_top_cut_z_height = open_chassis_frame_thickness + 2;

    radius_sides = 1;
    radius_ends = 2;
    radius_top = 0.5;

    difference()
    {
        // starting design
        import("designs/RasPi3Case-Top-PoE.stl");

        // all the cuts
        translate([-vesa_poe_case_top_translate_x, -2*vesa_poe_case_top_translate_y + 4 , 0])
        {
            // sides cut
            translate([open_chassis_sides_cut_translate_x,
                       open_chassis_sides_cut_translate_y,
                       open_chassis_sides_cut_translate_z])
                rotate([90,0,0])
            {
                // main cut
                linear_extrude(height = open_chassis_sides_cut_height + 2*e, center = false)
                    complexRoundSquare([open_chassis_sides_cut_width, open_chassis_sides_cut_z_height],
                                       [radius_sides, radius_sides],
                                       [radius_sides, radius_sides],
                                       [radius_sides, radius_sides],
                                       [radius_sides, radius_sides],
                                       center = false);
                // ethernet side extra
                width_ethernet_side_extra = 4.2;
                translate([0, 0, - 5])
                    linear_extrude(height = 5 + 10  + 2*e, center = false)
                    complexRoundSquare([open_chassis_sides_cut_width + width_ethernet_side_extra,
                                        open_chassis_sides_cut_z_height],
                                       [radius_sides, radius_sides],
                                       [radius_sides, radius_sides],
                                       [radius_sides, radius_sides],
                                       [radius_sides, radius_sides],
                                       center = false);
                // usb side extra
                width_usb_side_extra = 9.0;
                translate([0, 0, +open_chassis_sides_cut_height - 10])
                    linear_extrude(height = open_chassis_sides_cut_height - 70 + 2*e, center = false)
                    complexRoundSquare([open_chassis_sides_cut_width + width_usb_side_extra,
                                        open_chassis_sides_cut_z_height],
                                       [radius_sides, radius_sides],
                                       [radius_sides, radius_sides],
                                       [radius_sides, radius_sides],
                                       [radius_sides, radius_sides],
                                       center = false);
            }
            // ends cut
            translate([open_chassis_ends_cut_translate_x,
                       open_chassis_ends_cut_translate_y,
                       open_chassis_ends_cut_translate_z])
                rotate([90,0,90])
                linear_extrude(height = open_chassis_ends_cut_height + 2*e, center = false)
                complexRoundSquare([open_chassis_ends_cut_width, open_chassis_ends_cut_z_height],
                                   [radius_ends, radius_ends],
                                   [radius_ends, radius_ends],
                                   [radius_ends, radius_ends],
                                   [radius_ends, radius_ends],
                                   center = false);
            // top cut
            translate([open_chassis_top_cut_translate_x,
                       open_chassis_top_cut_translate_y,
                       open_chassis_top_cut_translate_z])
                rotate([90,0,90])
                linear_extrude(height = open_chassis_top_cut_height + 2*e, center = false)
                complexRoundSquare([open_chassis_top_cut_width, open_chassis_top_cut_z_height],
                                   [radius_top, radius_top],
                                   [radius_top, radius_top],
                                   [radius_top, radius_top],
                                   [radius_top, radius_top],
                                   center = false);
        }
    }

}

module mount_footer () {
    import("designs/Camera-pi-case-adapter.stl");
}


module original_picam_housing () {
    import("designs/camera_housing.STL");
}

module simple_hqcam_pcb_housing (include_tripod_mount = false) {

    hqcam_pcb_housing(instantiate_reference_hqcam_model = true,
                      install_tripod_mount = include_tripod_mount);
}


module case_top_and_footer () {
    rotate([180,0,0])
        translate([vesa_poe_case_top_translate_x, vesa_poe_case_top_translate_y, vesa_poe_case_top_translate_z])
        open_chassis_vesa_poe_case_top();

    translate([mount_footer_translate_x, mount_footer_translate_y, mount_footer_translate_z])
        rotate([0,0,180])
        mount_footer();
}

module picam_original_and_vesa_poe_case () {
    case_top_and_footer();

    rotate([90,0,-90])
        translate([0,0,0])
        translate([original_picam_housing_translate_x, original_picam_housing_translate_y, original_picam_housing_translate_z])
        original_picam_housing();
}

module pihqcam_and_vesa_poe_case (include_tripod_mount = false) {
    case_top_and_footer();

    rotate([90,0,-90])
        translate([hqpicam_housing_translate_x, hqpicam_housing_translate_y, hqpicam_housing_translate_z])
        simple_hqcam_pcb_housing(include_tripod_mount = include_tripod_mount);
}

module showTogether() {

    x_spacing = 100;
    y_spacing = 80;

    scale ([1.0,1.0,1.0])
        translate([0*x_spacing, 0*y_spacing, 0])
        rotate([0,0,0])
         picam_original_and_vesa_poe_case();

    // row 2
    scale ([1.0,1.0,1.0])
        translate([0*x_spacing, 1*y_spacing, 0])
        rotate([0,0,0])
        pihqcam_and_vesa_poe_case(include_tripod_mount = false);

}

show_everything = true ;

print_open_chassis_poe_top = !true ;

show_camera_and_6mm = !true ;
show_camera_and_16mm = !show_camera_and_6mm ;

if (show_everything) {
    showTogether();
} else {


    if (print_open_chassis_poe_top) {
        rotate([180,0,0])
            rotate([180,0,0])
            translate([vesa_poe_case_top_translate_x, vesa_poe_case_top_translate_y, 0*vesa_poe_case_top_translate_z])
            open_chassis_vesa_poe_case_top ();

    } else {

        // $preview requires version 2019.05
        fn = $preview ? 30 : 100;

        if (show_camera_and_6mm) {

            scale ([1.0,1.0,1.0])
                translate([0,0,0])
                rotate([0,0,0])
                camera_and_6mm_assembly();
        }

        if (show_camera_and_16mm) {

            scale ([1.0,1.0,1.0])
                translate([0,0,0])
                rotate([0,0,0])
                camera_and_16mm_assembly();
        }
    }

}
