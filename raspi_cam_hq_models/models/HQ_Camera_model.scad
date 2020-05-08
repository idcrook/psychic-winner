///////////////////////////////////////////////////////////////////////////////
// Initial Revision: 2020-May-02
// Author: David Crook <idcrook@users.noreply.github.com>
// Description: Rough dummy model of Raspberry Pi HQ Camera
//
// Revisions/Notes:
//
//   2020-May-02: Initial PCB dimensions
//   2020-May-03: Add notches to rings, add keepout regions to back of PCB
//   2020-May-03: Partially refine tripod mount portion
//
//
///////////////////////////////////////////////////////////////////////////////

use <MCAD/2Dshapes.scad>
// module complexRoundSquare()

use <../../libraries/wedge.scad>
// module wedge(h, r, d, fn = $fn)

e = 1/128; // small number

// If true, model is instantiated by this file
DEVELOPING_HQ_Camera_model = false;

pcb_thickness = 1.4 + 0.1; // measured closer to 1.5
pcb_width = 38.0;
pcb_height = 38.0;

pcb_back_sensor_housing_fastener_z_height = 2.8;
pcb_back_sensor_housing_fastener_washer_diameter = 5.0;
pcb_back_sensor_housing_fastener_diameter = 3.7;
left_fastener_x_inset = 4.6;
right_fastener_x_inset = 4.0;
fastener_x_radius = (1/2)*pcb_back_sensor_housing_fastener_washer_diameter;
fastener_y_center = (1/2) * pcb_height;

pcb_keepout_back = 1.5; //surface mount components
pcb_corner_radius = 1.8;

hqpcb_hole_diameter = 2.5;
hqpcb_hole_pcb_ring_diameter = 2*2.5;
hqpcb_hole_pos_x = 4.0;
hqpcb_hole_pos_y = 4.0;
hqpcb_hole_spacing = pcb_width - (2*hqpcb_hole_pos_x);

spacer_pos_x = hqpcb_hole_pos_x;
spacer_pos_y = hqpcb_hole_pos_y;
keepout_spacer_half = spacer_pos_x;
keepout_spacer_side = 2.0 * keepout_spacer_half;
keepout_spacing = pcb_width - 2*spacer_pos_x;


csi_connector_width = 23.5;
csi_fpc_width = 16.0;
csi_connector_height = 8.0;
csi_connector_above_board = 4.5 - pcb_thickness;
csi_from_x = (1/2)* ( pcb_width - csi_connector_width);
csi_from_y = 0.0;

sensor_center_pos_x = (1/2)*pcb_width;
sensor_center_pos_y = (1/2)*pcb_height;
sensor_width_x = 8.5;
sensor_width_y = sensor_width_x;

sensor_opening_diameter = 22.4;

sensor_focus_ring_outer_diameter = 36.0;
sensor_focus_ring_inner_diameter = sensor_opening_diameter;
sensor_focus_ring_notches = 48;

sensor_ccs_adapter_outer_diameter = 30.75;
sensor_ccs_adapter_inner_diameter = 24.1;
sensor_ccs_adapter_notches = 28;

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
sensor_housing_lock_screw_clamp_z_height = 5.02;

lock_screw_clamp_base_width = 10.16;
lock_screw_clamp_gap_width = 0.8;
lock_screw_clamp_shortest_height = 3.7;
lock_screw_clamp_farthest_height = 4.7;
lock_screw_clamp_height_y_distance = lock_screw_clamp_farthest_height - lock_screw_clamp_shortest_height +
    (1/2) * (sensor_focus_ring_outer_diameter-sensor_housing_base_outer_diameter);
lock_screw_cap_diameter = 2.8;

tripod_mount_base_width = 13.97;
tripod_mount_base_height = 13.5; // from base to focus ring outer diameter
tripod_mount_farthest_width = 24.4;
tripod_mount_base_above_pcb = sensor_housing_base_z_height - sensor_housing_tripod_mount_z_height; // flush with focus ring
tripod_mount_arc_degrees = 70; // ~ten notches on focus ring
tripod_mount_segment_inner_radius = (1/2)*sensor_housing_base_outer_diameter;
tripod_mount_segment_outer_radius = tripod_mount_segment_inner_radius + 6.0 + 2.0;
tripod_mount_segment_chop_radius = tripod_mount_segment_inner_radius +
    (1/2)*(tripod_mount_segment_outer_radius - tripod_mount_segment_inner_radius);
tripod_mount_screw_diameter = 0.25 * 25.4 - (0.5*2);


// Returns degrees of arc
// sequence_number == total_number => 360
// sequence_number == 0 => 0
function arc_fraction(sequence_number = 1,
                      total_number = 12) = 360 * (sequence_number / total_number);


module cutout_solid (cylinder_diameter = hqpcb_hole_diameter, cylinder_length = pcb_thickness) {
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

module fastener_model (diameter1 = pcb_back_sensor_housing_fastener_washer_diameter,
                         diameter2 = pcb_back_sensor_housing_fastener_diameter,
                         z_height = pcb_back_sensor_housing_fastener_z_height) {

    washer_height = 0.8;

    translate([0,0,-z_height])
        linear_extrude(height = z_height + 2*e, center = false) {
        circle(d = diameter2);
    }
    translate([0,0,-washer_height])
        linear_extrude(height =  washer_height + 2*e, center = false) {
        circle(d = diameter1);
    }
}


module csi_connector_footprint (width = csi_connector_width, height = csi_connector_height, z_height = csi_connector_above_board,
                                fpc_width = csi_fpc_width ) {

    // assume flat panel cable is centered
    fpc_x_translate = (1/2)*(width-fpc_width);
    fpc_y_translate = -5.0;
    fpc_z_translate = (3/4)*z_height;

    fpc_thickness = 0.1;

    // connector on PCB
    color("Red")
    mirror([0,0,0])
        cube([width, height, z_height], center = false);

    // flex cable
    color("Blue")
        translate([fpc_x_translate, fpc_y_translate, fpc_z_translate])
        cube([fpc_width, -fpc_y_translate+1, fpc_thickness], center = false);

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
    number_of_notches = sensor_focus_ring_notches;
    notch_diameter = 1.12;
    effective_radial_length = (1/2)*od + (0/10)*notch_diameter;

    angles = [ for (i = [1 : 1 : number_of_notches]) arc_fraction(sequence_number = i, total_number = number_of_notches) ];

    linear_extrude(height = h, center = false)
        difference()
    {
        // bulk
        circle(d = od, $fn = 100);

        // cutout inner opening
        circle(d = id, $fn = 40);

        // notches
        for (angle = angles) {
            x = effective_radial_length * cos(angle) ;
            y = effective_radial_length * sin(angle) ;
            translate([x, y, 0])
                circle(d = notch_diameter, $fn = 20);
        }
    }
}

module sensor_housing_adapter_ring (od = sensor_ccs_adapter_outer_diameter,
                                    id = sensor_ccs_adapter_inner_diameter,
                                    h = sensor_housing_ccs_adapter_z_height) {

    number_of_notches = sensor_ccs_adapter_notches;
    notch_diameter = 1.85;
    effective_radial_length = (1/2)*od + (2/10)*notch_diameter;

    angles = [ for (i = [1 : 1 : number_of_notches]) arc_fraction(sequence_number = i, total_number = number_of_notches) ];

    linear_extrude(height = h, center = false)
        difference()
    {
        // bulk
        circle(d = od, $fn = 100);

        // hollow out inner region
        circle(d = id, $fn = 100);

        // notches
        for (angle = angles) {
            x = effective_radial_length * cos(angle) ;
            y = effective_radial_length * sin(angle) ;
            translate([x, y, 0])
                circle(d = notch_diameter);
        }
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

    center_x = 0 ;
    center_y = sensor_center_pos_y + height;
    segment_arc_degrees = tripod_mount_arc_degrees;
    rotate_amount = 270 - (1/2)*segment_arc_degrees;
    segment_inner_radius = tripod_mount_segment_inner_radius;
    segment_outer_radius = tripod_mount_segment_outer_radius;
    segment_chop_radius = tripod_mount_segment_chop_radius;
    segment_chop_rotate = 50;
    second_chop_x = segment_chop_radius * cos(segment_arc_degrees);
    second_chop_y = segment_chop_radius * sin(segment_arc_degrees);

    echo ("tripod_mount arc = ", segment_arc_degrees );
    echo ("tripod_mount rotate = ", rotate_amount );


    // cube portion
    translate([0, (1/2)*height, (1/2)*thickness])
        difference ()
    {
        cube([width, height, thickness], center = true);

        // 1/4" tripod screw mount
        rotate([90,0,0])
        cylinder((1/2)*height + e, d = tripod_mount_screw_diameter);
    }

    // circular arc portion
    translate([center_x, center_y, 0])
        rotate([0, 0, rotate_amount])
        //rotate([0, 0, 0])
        difference ()
    {
        wedge(h = thickness, r = segment_outer_radius, d = segment_arc_degrees);

        // subtract inside circular segment
        translate([-e, -e, -e])
            wedge(h = thickness + 2*e, r = segment_inner_radius, d = segment_arc_degrees);

        // chop off edges
        translate([segment_chop_radius, -e, -e])
            rotate([0, 0, -segment_chop_rotate])
            cube(thickness + 2*e);

        translate([second_chop_x, second_chop_y, -e])
            rotate([0, 0, (segment_arc_degrees) - (90 - segment_chop_rotate)])
            cube(thickness + 2*e);
    }

}

module lock_screw_clamp ( width = lock_screw_clamp_base_width,
                          height = lock_screw_clamp_farthest_height,
                          gap_width = lock_screw_clamp_gap_width,
                          thickness = sensor_housing_lock_screw_clamp_z_height) {

    screw_cap_thickness = 0.2;

    translate([0, (1/2)*height, (1/2)*thickness])
        difference() {

        // bulk
        cube([width, height, thickness], center = true);

        // gap
        cube([gap_width, height + 2*e, thickness + 2*e], center = true);


        // screw cap
        translate ([(1/2)*width - screw_cap_thickness, 0 + 0.3 , 0])
            rotate ([0,90,0])
            cylinder(d = lock_screw_cap_diameter, h = screw_cap_thickness + 2*e, center = false);
        }
}


module sensor_housing (install_ccs_adapter = true,
                       show_dust_cap = false,
                       install_tripod_mount = true) {

    showLockClamp = true;
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
    tripod_mount_pos_z = tripod_mount_base_above_pcb;

    lock_clamp_pos_x = 0;
    lock_clamp_pos_y =  ((1/2)* base_diameter  -  lock_screw_clamp_height_y_distance);
    lock_clamp_pos_z =  sensor_housing_base_z_height - sensor_housing_lock_screw_clamp_z_height;

    union() {
        // main base
        translate([0,0,0])
            sensor_housing_base ();

        if (showLockClamp) {
            translate([lock_clamp_pos_x, lock_clamp_pos_y, lock_clamp_pos_z])
                lock_screw_clamp();
        }

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
        translate([tripod_mount_pos_x, tripod_mount_pos_y, tripod_mount_pos_z])
            tripod_mount();
    }

}


module raspi_hq_camera_model (install_ccs_adapter = true,
                              install_tripod_mount = true) {

    origin_center_inset_x = hqpcb_hole_pos_x;
    origin_center_inset_y = hqpcb_hole_pos_y;
    hole_distance = hqpcb_hole_spacing;
    hole_D = hqpcb_hole_diameter;
    radius = pcb_corner_radius;

    keepout_center_inset_x = spacer_pos_x;
    keepout_center_inset_y = spacer_pos_y;
    keepout_side = keepout_spacer_side;
    keepout_offset = keepout_spacer_half;
    keepout_distance = keepout_spacing;

    csi_x_pos = csi_from_x;
    csi_y_pos = csi_from_y;
    csi_z_pos = -(csi_connector_above_board);

    sensor_x_pos = sensor_center_pos_x;
    sensor_y_pos = sensor_center_pos_y;
    sensor_z_pos = pcb_thickness;

    hole_origin = [origin_center_inset_x,  origin_center_inset_y];
    spacer_origin = [0,0];

    corner_hole_positions = [[hole_origin.x + 0,             hole_origin.y + 0],
                             [hole_origin.x + hole_distance, hole_origin.y + 0],
                             [hole_origin.x + 0,             hole_origin.y + hole_distance],
                             [hole_origin.x + hole_distance, hole_origin.y + hole_distance]];

    corner_spacer_positions = [[spacer_origin.x + 0,                spacer_origin.y + 0],
                               [spacer_origin.x + keepout_distance, spacer_origin.y + 0],
                               [spacer_origin.x + 0,                spacer_origin.y + keepout_distance],
                               [spacer_origin.x + keepout_distance, spacer_origin.y + keepout_distance]];

    // looking from back these are opposite
    left_fastener_x_translate = 0 + (right_fastener_x_inset + fastener_x_radius) ;
    right_fastener_x_translate = 0 + pcb_width - (left_fastener_x_inset + fastener_x_radius );

    fastener_positions = [[left_fastener_x_translate, fastener_y_center],
                          [right_fastener_x_translate, fastener_y_center]];

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

            // CSI connector ("back" of PCB)
            translate([csi_x_pos, csi_y_pos, csi_z_pos]) {
                csi_connector_footprint();
            }

            // sensor housing ("front" of PCB)
            translate([sensor_x_pos, sensor_y_pos, sensor_z_pos]) {
                mirror([0,0,0])
                    sensor_housing(install_ccs_adapter = install_ccs_adapter,
                                   install_tripod_mount = install_tripod_mount);
            }

            // keepout spacers around screws
            %color("Green")
                mirror([0,0,1])
                for (p = corner_spacer_positions) {
                    translate([p[0] , p[1] , 0])
                        keepout_spacer();
                }

            // main PCB backside keepout
            %translate([0,0,-pcb_thickness])
                linear_extrude(height = pcb_keepout_back, center = false)
                square([pcb_width, pcb_height] , center = false);


            // keepout spacers around screws
            color("Silver")
                mirror([0,0,0])
                for (p = fastener_positions) {
                    translate([p[0] , p[1] , 0])
                        fastener_model();
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
