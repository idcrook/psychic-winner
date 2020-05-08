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


hqcam_pcb_housing_rear_thickness = 3.5;
hqcam_pcb_housing_sidewall_thickness = 2.0;
hqcam_pcb_housing_lower_sidewall_thickness = 2.0;
hqcam_pcb_housing_z_height = 8;
hqcam_pcb_z_height = hqcam_pcb_housing_z_height - pcb_thickness ;


hqcam_pcb_housing_rear_face_width = pcb_width + 2*hqcam_pcb_housing_rear_thickness + 0 ;
hqcam_pcb_housing_rear_face_height = pcb_width + 2*hqcam_pcb_housing_rear_thickness + 0 ;

module hqcam_pcb_housing (instantiate_reference_hqcam_model = false,
                          install_tripod_mount = false) {

    if (instantiate_reference_hqcam_model) {
        translate([pcb_width + hqcam_pcb_housing_sidewall_thickness,
                   pcb_height + hqcam_pcb_housing_lower_sidewall_thickness,
                   hqcam_pcb_z_height])
                   /* hqcam_pcb_housing_rear_thickness + pcb_thickness]) */
        rotate([0,0,180])
        raspi_hq_camera_model(install_tripod_mount = install_tripod_mount);
    }


    %difference ()
    {
        linear_extrude(height = hqcam_pcb_housing_z_height)
            square(pcb_width + 2* hqcam_pcb_housing_sidewall_thickness);


        translate([hqcam_pcb_housing_sidewall_thickness - tol_e,
                   hqcam_pcb_housing_lower_sidewall_thickness - tol_e,
                   hqcam_pcb_housing_rear_thickness])
            linear_extrude(height = hqcam_pcb_housing_z_height - hqcam_pcb_housing_rear_thickness + 2*e)
            square([pcb_width + 2*tol_e, pcb_width + hqcam_pcb_housing_lower_sidewall_thickness + 5]);


    }
}



// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

if (DEVELOPING_HQ_Camera_pcb_housing)  {

    translate_y = true ? 90 : 0;

    translate([0,translate_y,0])
    {

        hqcam_pcb_housing(instantiate_reference_hqcam_model = true);

        translate([50,0,0])
        {
            translate([(1/2)*(38 - 30) + hqcam_pcb_housing_sidewall_thickness, -13, 0])
                import("camera_housing.STL");
            %hqcam_pcb_housing(instantiate_reference_hqcam_model = false);
        }
    }
}
