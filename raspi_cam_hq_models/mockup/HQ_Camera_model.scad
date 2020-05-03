///////////////////////////////////////////////////////////////////////////////
// Initial Revision: 2020-May-02
// Author: David Crook <idcrook@users.noreply.github.com>
// Description: Rough dummy model of Raspberry Pi HQ Camera
//
// Revisions/Notes:
//
//   2020-May-02: Initial PCB dimensions
//
//
///////////////////////////////////////////////////////////////////////////////

use <MCAD/2Dshapes.scad>
// complexRoundSquare()

e = 1/128; // small number

// If true, model is instantiated by this file
DEVELOPING_HQ_Camera_model = !false;

pcb_thickness = 1.4;
pcb_width = 38.0;
pcb_height = 38.0;
pcb_back_sensor_housing_fastener_z_height = 2.8;
pcb_keepout_back = pcb_back_sensor_housing_fastener_z_height;
pcb_corner_radius = 1.8;

hole_diameter = 2.5;
hole_pos_x = 4.0;
hole_pos_y = 4.0;
hole_spacing = pcb_width - (2*hole_pos_x);

spacer_pos_x = hole_pos_x;
spacer_pos_y = hole_pos_y;
keepout_spacer_half = spacer_pos_x;
keepout_spacer_side = 2 * keepout_spacer_half;
keepout_spacing = pcb_width - 2*spacer_pos_x;


csi_connector_length = 10;
csi_connector_width = 5;
csi_connector_above_board = 6.1;
csi_from_x = 5.5;
csi_from_y = 0.2;
csi_pth_protrusion_length = 7.3;
csi_pth_protrusion_width = 1.4;
csi_pth_protrusion_height = 2.5;
csi_pth_protrusion_from_x = 7.3;
csi_pth_protrusion_from_y = 2.1;
csi_pth_protrusion_from_tol = 0.3;

sensor_center_pos_x = (1/2)*pcb_width;
sensor_center_pos_y = (1/2)*pcb_height;
sensor_width_x = 8.5;
sensor_width_y = sensor_width_x;

sensor_opening_diameter = 22.4;
sensor_focus_ring_outer_diameter = 36.0;
sensor_focus_ring_inner_diameter = sensor_opening_diameter;
sensor_ccs_adapter_outer_diameter = 30.75;
sensor_ccs_adapter_inner_diameter = 24.1;
sensor_dust_cap_outer_diameter = 29.3;
sensor_dust_cap_inner_diameter = 16.6;
sensor_dust_cap_inner_diameter_upper = 22.4;

sensor_housing_base_outer_diameter = 35.0 ; // x dimension
sensor_housing_base_inner_diameter = sensor_opening_diameter ; // x dimension
sensor_housing_base_z_height = 10.2;  // z dimension
sensor_housing_pcb_base_z_height = 11.43;  // z dimension

sensor_housing_tripod_mount_z_height = 7.62;
sensor_housing_focus_ring_z_height = 1.2;
sensor_housing_ccs_adapter_z_height = 5.8;
sensor_housing_dust_cap_z_height = 4.0;
sensor_housing_lock_screw_clamp_z_height = 5.2;

lock_screw_clamp_base_width = 10.16;
lock_screw_clamp_gap_width = 0.8;
tripod_mount_base_width = 13.97;
tripod_mount_base_height = 13.0; // from base to focus ring outer diameter
tripod_mount_farthest_width = 24.4;

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


module csi_connector (length = csi_connector_length, width = csi_connector_width, height = csi_connector_above_board) {

    pth_length = csi_pth_protrusion_length + 2*csi_pth_protrusion_from_tol;
    pth_width = csi_pth_protrusion_width + 2*csi_pth_protrusion_from_tol;
    pth_height = csi_pth_protrusion_height;
    pth_width_wires_offset = (3/5) * csi_connector_width; // not centered half-way in connector
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

module sensor_housing_base (od = sensor_housing_base_outer_diameter,
                            id = sensor_housing_base_inner_diameter,
                            h = sensor_housing_base_z_height) {
    difference() {
        linear_extrude(height = h, center = false)
            circle(d = od, $fn = 100);
        translate([0,0, -e])
            linear_extrude(height = h + 2*e, center = false)
            circle(d = id, $fn = 100);
    }
}


module sensor_housing_focus_ring (od = sensor_focus_ring_outer_diameter,
                                  id = sensor_focus_ring_inner_diameter,
                                  h = sensor_housing_focus_ring_z_height) {
    difference() {
        linear_extrude(height = h, center = false)
            circle(d = od, $fn = 100);
        translate([0,0, -e])
            linear_extrude(height = h + 2*e, center = false)
            circle(d = id, $fn = 100);
    }
}

module sensor_housing_adapter_ring (od = sensor_ccs_adapter_outer_diameter,
                                    id = sensor_ccs_adapter_inner_diameter,
                                    h = sensor_housing_ccs_adapter_z_height) {
    difference() {
        linear_extrude(height = h, center = false)
            circle(d = od, $fn = 100);
        translate([0,0, -e])
            linear_extrude(height = h + 2*e, center = false)
            circle(d = id, $fn = 100);
    }
}

module sensor_housing_dust_cap (od = sensor_dust_cap_outer_diameter,
                                id = sensor_dust_cap_inner_diameter,
                                id2 = sensor_dust_cap_inner_diameter_upper,
                                h = sensor_housing_dust_cap_z_height) {
    scale_factor = 1 + (id2-id)/id;
    cap_thickness = 1.0;

    %difference() {
        linear_extrude(height = h, center = false)
            circle(d = od, $fn = 100);
        translate([0,0,cap_thickness-e])
            linear_extrude(height = h - cap_thickness + 2*e,
                           scale = scale_factor, center = false)
            circle(d = id, $fn = 100);
    }
}

module tripod_mount ( width = tripod_mount_base_width,
                      height = tripod_mount_base_height,
                      wrap_diameter = 0,
                      thickness = sensor_housing_tripod_mount_z_height) {

    translate([0, (1/2)*height, (1/2)*thickness])
        cube([width, height, thickness], center = true);
}


module sensor_housing (install_ccs_adapter = true,
                       show_dust_cap = true,
                       install_tripod_mount = true) {

    installCcsAdapter = install_ccs_adapter;
    showDustCap = show_dust_cap;
    installTripodMount = install_tripod_mount;

    base_diameter = sensor_housing_base_outer_diameter;
    base_height = sensor_housing_base_z_height;

    focus_ring_diameter = sensor_focus_ring_outer_diameter;
    focus_ring_z_translate = sensor_housing_base_z_height;
    focus_ring_z_height = sensor_housing_focus_ring_z_height;

    adapter_ring_diameter = sensor_ccs_adapter_outer_diameter;
    adapter_ring_z_translate = focus_ring_z_translate + focus_ring_z_height;
    adapter_ring_z_height = sensor_housing_ccs_adapter_z_height;

    dust_cap_diameter = sensor_dust_cap_outer_diameter;
    dust_cap_z_height = sensor_housing_dust_cap_z_height;

    dust_cap_z_translate_w_adapter = adapter_ring_z_translate + adapter_ring_z_height;
    dust_cap_z_translate_wo_adapter = focus_ring_z_translate + focus_ring_z_height;

    tripod_mount_pos_x = 0;
    tripod_mount_pos_y = - ((1/2)* base_diameter  + tripod_mount_base_height);

    union() {
        // main base
        translate([0,0,0])
            sensor_housing_base ();

        // focus ring
        translate([0,0,focus_ring_z_translate])
            sensor_housing_focus_ring ();

        // adapter ring
        if (installCcsAdapter) {
            translate([0,0, adapter_ring_z_translate])
                sensor_housing_adapter_ring();

            if (showDustCap) {
                translate([0,0, dust_cap_z_translate_w_adapter])
                    sensor_housing_dust_cap();
            }
        } else {
            if (showDustCap) {
                translate([0,0, dust_cap_z_translate_wo_adapter])
                    sensor_housing_dust_cap();
            }
        }
    }

    if (installTripodMount) {
        translate([tripod_mount_pos_x, tripod_mount_pos_y, 0])
            tripod_mount();
    }

}


module raspi_hq_camera_model () {

    origin_center_inset_x = hole_pos_x;
    origin_center_inset_y = hole_pos_y;
    hole_distance = hole_spacing;
    hole_D = hole_diameter;
    radius = pcb_corner_radius;

    keepout_center_inset_x = spacer_pos_x;
    keepout_center_inset_y = spacer_pos_y;
    keepout_side = keepout_spacer_side;
    keepout_offset = keepout_spacer_half;
    keepout_distance = keepout_spacing;

    /* csi_x_pos = pcb_width - csi_from_x - csi_connector_length; */
    /* csi_y_pos = 0 + csi_from_y; */

    sensor_x_pos = sensor_center_pos_x;
    sensor_y_pos = sensor_center_pos_y;
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
                complexRoundSquare([pcb_width, pcb_height],
                                   [radius, radius],
                                   [radius, radius],
                                   [radius, radius],
                                   [radius, radius],
                                   center = false);

            // TODO: CSI connector ("back" of PCB)
            /* *translate([csi_x_pos, csi_y_pos, 0]) { */
            /*     csi_connector(); */
            /* } */

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

if (DEVELOPING_HQ_Camera_model)  {
    raspi_hq_camera_model();
}
