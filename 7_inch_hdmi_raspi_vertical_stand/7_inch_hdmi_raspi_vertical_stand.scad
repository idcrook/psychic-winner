///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2020-Apr-19
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//   Vertical stand for Raspberry Pi plus 7-inch HDMI touchscreen display with
//   push-buttons
//
// Revisions/Notes:
//
// 2020-Apr-19: Initial dimensions
//
// 2020-Apr-27: Front face Test print 1 Feedback
//   - in ABS, both X- and Y- dimensions were too short. Updated LCD monitor
//     assembly dimensions to account.
//   - Also, ABS slicer should be scaled ~1.2%-1.5% to account for intrinsic ABS
//     shrinking properties
// 2020-Apr-28: Front face Test print 2, scale 101.35% ABS Feedback:
//   - screw hole placements extended; lcd screen position/opening adjusted
// 2020-Apr-28: Front face Test print 3, scale 101.35% ABS Feedback:
//   - screw hole placements were wrong direction, so reversed for print 4
// 2020-Apr-28: Front face Test print 4, scale 101.35% ABS
//   - placed 3X pushbutton area in side of front panel
// 2020-Apr-29: Rear face Test print 1, scale 101.35% ABS
// 2020-Apr-29: Front face Test print 5, scale 101.35% ABS
//   - pushbutton related changes
// 2020-Apr-29: Rear face Test print 2, scale 101.35% ABS
//   - shortened rear cover height; changed Power USB opening
// 2020-May-14: Pushbutton test 1, scale 101.35% ABS
//   - Refine pushbutton "shelf"
// 2020-May-14: Stand foot test 1, scale 101.35% ABS
//   - First outline of a foot (one for each side)
//
// 2020-May-14: Stand foot test 2, scale 101.35% ABS
//   - add catch to foot
//
///////////////////////////////////////////////////////////////////////////////


use <MCAD/2Dshapes.scad>

include <../libraries/local-misc/fillet.scad>

include <../libraries/Chamfers-for-OpenSCAD/Chamfer.scad>

/* LCD monitor model */
//use <mockup/HDMI_7inch_touchscreen__dummy.scad>
include <mockup/HDMI_7inch_touchscreen__dummy.scad>

e = 1/128; // small number

show_everything = true ;
print_mode = false;

print_front = true;
print_rear = false;
print_foot = false;

show_monitor_assembly = !(print_front || print_rear || print_foot || print_mode) ;
print_something = (print_front || print_rear || print_foot || print_mode) ? true : false;

module __Customizer_Limit__ () {} 

case_side_edge_extra = 1.0;
case_top_bottom_edge_extra = 0.5;
panel_shell_thickness = 3.5;
panel_width  = pcb_width + 2*(case_side_edge_extra) + 2*panel_shell_thickness;
panel_height  = pcb_height + 2*(case_top_bottom_edge_extra) + 2*panel_shell_thickness ;

lcd_cutout_x = lcd_width;
lcd_cutout_y = lcd_height;
lcd_translate_x = pcb_rectangular_x_origin + (1/2) * (panel_width - pcb_rectangular_width);
lcd_translate_y = pcb_rectangular_y_origin + panel_shell_thickness + pcb_to_edge_lcd_bottom ;

screw1_pos_x = first_hole_pos_x + panel_shell_thickness + case_side_edge_extra;
screw1_pos_y = first_hole_pos_y + panel_shell_thickness + case_top_bottom_edge_extra;
screw_hole_distance_x = hole_spacing_width;
screw_hole_distance_y = hole_spacing_height;
screw_hole_diameter = hole_diameter;
screw_hole_pad_size = 7.2;
screw_hole_pad_depth = 5.0;

// pushbutton related
button_footprint_xy = 6.25;
button_footprint_xy_extra_y = 1.0;
button_half_xy = (1/2)*button_footprint_xy;

button_footprint_z_height = 3.5; // plastic base to metal faceplate
button_leg_extension_shorten = 1.3;
button_leg_extension = 3.5 - button_leg_extension_shorten;
button_diameter = 3.5;
button_seperation = 2.54 * 6; // 15.24mm, multiple of 0.1", center to center,
button_moat_distance = 2.5;

// button centers
button1_translate_x = button_moat_distance + button_half_xy;
button1_translate_y = button_moat_distance - button_moat_distance + button_half_xy - e;

pb_panel_length = 2*button_moat_distance + 2*button_seperation + button_footprint_xy;
pb_panel_width  = 2*button_moat_distance + button_footprint_xy + button_footprint_xy_extra_y
    - 2*button_moat_distance - 2*e;
pb_panel_z_height = button_footprint_z_height;
pb_panel_distance_from_corner = 82;

// PCB and Pi footprints
rear_pi_width         = pi_width  + 20;
rear_pi_height        = pi_height + 20;

rear_pi_pcb_rect_inset_right = screw1_pos_x - first_hole_pos_x + (1/2) * (pcb_rectangular_width - rear_pi_width);
rear_pi_pcb_rect_inset_top =  screw1_pos_y  - first_hole_pos_y + (1/2) * (pcb_height - rear_pi_height)  ;

rear_panel_z_height = pcb_to_lcd_glass ;

// for "stand"
assm_foot_thickness = 3.5;
assm_foot_width = 9.0;
assm_foot_z_height = 30.0;

assm_case_thickness = 19.3 - 0.5;
assm_tilt_angle = 9.0; // in degrees
assm_rear_outcrop = 50.0;
//assm_rear_shadow = panel_width * sin(assm_tilt_angle);
//assm_front_outcrop = 10.0;
assm_front_lift = assm_case_thickness * sin(assm_tilt_angle);


module monitorAndPiAssembly (showPi = false) {
    HDMI_7inch_touchscreen__dummy(showPi);
}

module screw_hole_pad_front_face (pad_size = screw_hole_pad_size, pad_depth = screw_hole_pad_depth,
                                  hole_diameter = screw_hole_diameter) {
    // note: notice tapers smaller at d_top
    d_bot = hole_diameter;
    d_top = (95/100)*hole_diameter;

    difference () {
        cube([pad_size, pad_size, pad_depth + e], center = true);
        translate([0,0,-e])
            cylinder(h = pad_depth + 2*e, d1 = d_bot, d2 = d_top, center = true);
    }
}

module screw_hole_pad_rear_face_opening (pad_size = screw_hole_pad_size, pad_depth = screw_hole_pad_depth) {
    cube([pad_size, pad_size, pad_depth + e], center = true);
    //cylinder(h = pad_depth + 2*e, d = pad_size, center = true);
}

module screw_hole_pad_rear_face (pad_size = screw_hole_pad_size, pad_depth = screw_hole_pad_depth,
                                  hole_diameter = screw_hole_diameter) {
    diameter = 1.05 * hole_diameter;

    translate([0,0,-(1/2)*pad_depth])
    difference () {
        cube([pad_size, pad_size, pad_depth], center = true);
        translate([0,0,-e])
            cylinder(h = pad_depth + 2*e + 5, d = diameter, center = true);
    }
}

module pushbutton_dummy_model (footprint_xy = button_footprint_xy,
                               footprint_z_height =  button_footprint_z_height,
                               trapezoid = false) {
    extra_y = button_footprint_xy_extra_y;
    half_z_height = (1/2)*footprint_z_height;

    translate([0, + (1/2)*extra_y, half_z_height])
        if (!trapezoid) {
            cube([footprint_xy, footprint_xy + extra_y, footprint_z_height+2*e], center = true);
        } else {
            rotate([90,0,0])
                // the scale here determines how much of fan "wedge" shape. 1.0 is rectangular
                linear_extrude(height=footprint_xy + extra_y + 2*e, center=true, scale=1.035)
                square([footprint_xy, footprint_z_height + 2*e], center = true);
        }
}

module pushbutton_3x_panel_opening () {
    translate([-e, -e, -e]) {
        cube([pb_panel_length + 2*e,
              pb_panel_width + 2*e,
              pb_panel_z_height + 2*e]);
    }
}

module pushbutton_3x_panel () {
    button_origin = [button1_translate_x , button1_translate_y];
    button_positions = [[button_origin.x + 0,                   button_origin.y + 0, false],
                        [button_origin.x + button_seperation,   button_origin.y + 0, false],
                        [button_origin.x + 2*button_seperation, button_origin.y + 0, false]];

    translate([-e, -e, -2*e]) {
        difference () {
            // main panel bulk
            cube([pb_panel_length + 2*e, pb_panel_width, pb_panel_z_height]);

            // cutout button areas
            for (p = button_positions) {
                translate([p[0], p[1], 0])
                    if (p[2]) {
                        pushbutton_dummy_model(trapezoid = true);
                    } else {
                        pushbutton_dummy_model();
                    }
            }
        }

        // "pad" past shell wall for contact with "legs" of pushbutton switch
        slight_shift = 0.5;
        translate([0, pb_panel_width, panel_shell_thickness - slight_shift])
            cube([pb_panel_length, 2.0, button_leg_extension + slight_shift]);

        // "stop" for one side of legs
        stop_thickness = 2.0;
        stop_height = (2/2)*button_footprint_xy;
        stop_open_length = button_leg_extension;

        // end stop
        translate([0, pb_panel_width - stop_height, 2*(panel_shell_thickness)-e - button_leg_extension_shorten])
            cube([pb_panel_length, stop_height + 2.0, stop_thickness]);

    }

}

module pushbutton_3x_panel_shelf (thickness = 2.5) {
    //translate([0, pb_panel_width , thickness])
    translate([0, - (panel_shell_thickness + button_leg_extension), (-thickness)])
        cube([pb_panel_length, 2*button_leg_extension, thickness], center = false);
}

module stand_foot () {
    clamp_width = assm_foot_width;
    clamp_thickness = 2*assm_foot_thickness + assm_case_thickness;
    clamp_z_height = assm_foot_thickness + assm_foot_z_height;
    clamp_translate = [0, 0, clamp_thickness * sin(assm_tilt_angle)];
    assm_rear_translate = clamp_thickness * cos(assm_tilt_angle) - assm_foot_thickness;

    catch_length = 6 - 0.5;
    catch_thickness = 8.0;
    catch_translate_y = clamp_thickness - assm_foot_thickness - catch_length + e;
    catch_translate_z = assm_foot_thickness + panel_shell_thickness + case_side_edge_extra + 0.8 + 1.0;

    translate(clamp_translate) {
        // upward slot ("clamp") that case sits in
        rotate([-assm_tilt_angle, 0, 0]) {
            difference ()
            {
                union ()
                {
                    cube_fillet([clamp_width ,
                                 clamp_thickness,
                                 clamp_z_height], radius=1, $fn=25);
                    // extend base
                    translate([0, 0, -(assm_foot_thickness)*(1 + sin(assm_tilt_angle)) ])
                        cube_fillet([clamp_width ,
                                     clamp_thickness,
                                     clamp_z_height], radius=1, $fn=25);
                }
                // main slot
                translate([-e, assm_foot_thickness, assm_foot_thickness])
                    cube([assm_foot_width + 2*e, assm_case_thickness, clamp_z_height], center = false);
                // flatten base
                translate([-e, 0, -clamp_translate.z - 0.05])
                rotate([assm_tilt_angle, 0, 0]) {
                    mirror([0,0,1])
                    cube([assm_foot_width + 2*e, clamp_z_height, 10], center = false);
                }
            }
            // catch
            translate([0, catch_translate_y, catch_translate_z])
                cube([assm_foot_width, catch_length, catch_thickness], center = false);

        }
    }
    // rear outcrop
    translate([0, assm_rear_translate, 0])
        cube([assm_foot_width, assm_rear_outcrop, assm_foot_thickness], center = false);
}

module caseFrontPanel () {
    chamfer_size_face = 2;
    thickness_face = 2.0;
    panel_z_height = pcb_to_lcd_glass + pcb_thickness;

    scale_cutout = 0.95;
    translate_scale_cutout = (1/2) * (1/scale_cutout - 1);
    translate_x_cutout = translate_scale_cutout * panel_width;
    translate_y_cutout = translate_scale_cutout * panel_height;

    first_hole_center_inset_x = screw1_pos_x;
    first_hole_center_inset_y = screw1_pos_y;
    hole_distance_x = screw_hole_distance_x ;
    hole_distance_y = screw_hole_distance_y ;
    hole_diameter  = screw_hole_diameter ;

    front_pad_depth = panel_z_height - thickness_face - pcb_thickness;

    hole_origin = [first_hole_center_inset_x + (1/4)*case_side_edge_extra,
                   first_hole_center_inset_y + (1/2)*case_top_bottom_edge_extra ];
    corner_hole_positions = [[hole_origin.x + 0,               hole_origin.y + 0],
                             [hole_origin.x + hole_distance_x, hole_origin.y + 0],
                             [hole_origin.x + 0,               hole_origin.y + hole_distance_y],
                             [hole_origin.x + hole_distance_x, hole_origin.y + hole_distance_y]];

    for (p = corner_hole_positions) {
        translate([p[0], p[1], pcb_thickness+ (1/2)*front_pad_depth ])
            screw_hole_pad_front_face(pad_size = screw_hole_pad_size,
                                      pad_depth = front_pad_depth + e,
                                      hole_diameter = hole_diameter);
    }

    // bulk - {bulk cutout, screen cutout}
    difference () {
        intersection() {
            // outline with rounded corners
            translate([0, 0, 0])
                cube_fillet([panel_width ,
                             panel_height,
                             panel_z_height], radius=4, $fn=25);

            // add chamfer to top
            scale ([1.0, 1.0, 1.0])
                translate([0, 0, -chamfer_size_face])
                rotate([0,0,0])
                chamferCube([panel_width, panel_height, panel_z_height + chamfer_size_face+ e], ch=chamfer_size_face);
        }

        // bulk cutout
        translate([translate_x_cutout ,
                   translate_y_cutout , -e])
            rotate([0,0,0])
            cube_fillet([panel_width * scale_cutout ,
                         panel_height * scale_cutout ,
                         panel_z_height - thickness_face + 2*e],
                        radius=4, $fn=25);

        // screen cutout
        translate([lcd_translate_x,
                   lcd_translate_y,
                   panel_z_height - thickness_face - e])
            rotate([0,0,0])
            cube_fillet([lcd_cutout_x,
                         lcd_cutout_y,
                         thickness_face + 2*e],
                        radius=0.5, $fn=25);

        // LCD usb keepout carve out
        lcdusb_x = 0 + panel_shell_thickness + 2*case_side_edge_extra + e;
        lcdusb_y = 0 + panel_shell_thickness + case_top_bottom_edge_extra + 0.25 +
            pcb_rectangular_y_origin + 32.5 ;
        lcdusb_z = (1/2) * (microusb_keepout_height) - pcb_thickness;

        translate([lcdusb_x, lcdusb_y, lcdusb_z])
            rotate([-90, 0, 90])
            microusb_keepout(mycolor="Green");

        // pushbutton "panel" area - opening
        scale ([1.0,1.0,1.0])
            translate([panel_width - pb_panel_distance_from_corner,
                       panel_height,
                       0])
            rotate([90, 0, 0])
            pushbutton_3x_panel_opening();
    }

    // pushbutton "panel" area
    scale ([1.0,1.0,1.0])
        translate([panel_width - pb_panel_distance_from_corner,
                   panel_height,
                   0])
        rotate([90, 0, 0])
        pushbutton_3x_panel();
}

module caseBackPanel () {

    chamfer_size_face = 2;
    thickness_face = 2.0;
    panel_z_height = rear_panel_z_height;

    scale_cutout = 0.95;
    translate_scale_cutout = (1/2) * (1/scale_cutout - 1);
    translate_x_cutout = translate_scale_cutout * panel_width;
    translate_y_cutout = translate_scale_cutout * panel_height;

    first_hole_center_inset_x = screw1_pos_x;
    first_hole_center_inset_y = screw1_pos_y;
    hole_distance_x = screw_hole_distance_x ;
    hole_distance_y = screw_hole_distance_y ;
    hole_diameter  = screw_hole_diameter ;

    back_pad_depth = 2.0;

    hole_origin = [first_hole_center_inset_x + (1/4)*case_side_edge_extra,
                   first_hole_center_inset_y + (1/2)*case_top_bottom_edge_extra ];
    corner_hole_positions = [[hole_origin.x + 0,               hole_origin.y + 0],
                             [hole_origin.x + hole_distance_x, hole_origin.y + 0],
                             [hole_origin.x + 0,               hole_origin.y + hole_distance_y],
                             [hole_origin.x + hole_distance_x, hole_origin.y + hole_distance_y]];

    translate_pad_z_height = panel_z_height;

    translate_x_pi_cutout = rear_pi_pcb_rect_inset_right;
    translate_y_pi_cutout = rear_pi_pcb_rect_inset_top;

    // screw hole for attachment
    for (p = corner_hole_positions) {
        translate([p[0], p[1], translate_pad_z_height])
            screw_hole_pad_rear_face(pad_size = screw_hole_pad_size + 5,
                                     pad_depth = back_pad_depth + e,
                                     hole_diameter = hole_diameter);
    }

    // pushbutton "panel" area - shelf
    shelf_thickness = 2.0;

    scale ([1.0,1.0,1.0])
        translate([panel_width - pb_panel_distance_from_corner,
                   panel_height - 0,
                   panel_z_height])
        rotate([0, 0, 0])
        pushbutton_3x_panel_shelf(thickness = shelf_thickness);

    // bulk - {bulk cutout, screen cutout}
    difference () {
        intersection() {
            // outline with rounded corners
            translate([0, 0, 0])
                cube_fillet([panel_width ,
                             panel_height,
                             panel_z_height], radius=4, $fn=25);

            // add chamfer to bottom
            scale ([1.0, 1.0, 1.0])
                translate([0, 0, 0])
                rotate([0,0,0])
                chamferCube([panel_width, panel_height, panel_z_height + chamfer_size_face+ e], ch=chamfer_size_face);
        }

        // bulk cutout
        translate([translate_x_cutout ,
                   translate_y_cutout , thickness_face -e])
            rotate([0,0,0])
            cube_fillet([panel_width * scale_cutout ,
                         panel_height * scale_cutout ,
                         panel_z_height - thickness_face + 2*e],
                        radius=4, $fn=25);

        // pi footprint cutout
        translate([translate_x_pi_cutout ,
                   translate_y_pi_cutout , -e])
            rotate([0,0,0])
            cube([rear_pi_width ,
                  rear_pi_height ,
                  panel_z_height ]);


        // pcb footprint cutout
        translate([panel_shell_thickness + case_side_edge_extra,
                  2*panel_shell_thickness + pcb_to_edge_lcd_bottom , -e])
            rotate([0,0,0])
            cube([pcb_rectangular_width ,
                  pcb_rectangular_height ,
                  panel_z_height ]);


        // more cutout
        overhang = 0.7;
        translate([panel_shell_thickness + overhang,
                   panel_shell_thickness + overhang , -e])
            rotate([0,0,0])
            cube([panel_width - 2*panel_shell_thickness - 2*overhang ,
                  panel_height - 2*panel_shell_thickness - 2*overhang ,
                  panel_z_height - panel_shell_thickness]);


        // screwdriver cutouts
        for (p = corner_hole_positions) {
        translate([p[0], p[1], 0 ])
            screw_hole_pad_rear_face_opening(pad_size = 8,
                                             pad_depth = 5 + e);
        }

        // LCD usb keepout carve out
        rear_lcdusb_x = 0 + panel_shell_thickness + 2*case_side_edge_extra + e;
        rear_lcdusb_y = 0 + panel_shell_thickness + case_top_bottom_edge_extra + 0.25 +
            pcb_rectangular_y_origin + 32.5 ;
        rear_lcdusb_z =  (microusb_keepout_height) + 2 + pcb_thickness;

        translate([rear_lcdusb_x, rear_lcdusb_y, rear_lcdusb_z])
            rotate([-90, 0, 90])
            microusb_keepout(mycolor="Green");


        // power usb keepout carve out
        rear_powerusb_x = panel_width - ( panel_shell_thickness + case_side_edge_extra + pipower_distance_from_edge + microusb_keepout_width );
        rear_powerusb_y = 10 + 2.3;
        /* rear_powerusb_z =  (microusb_keepout_height) + 2 + pcb_thickness; */
        rear_powerusb_z = 0 + 3.5;

        translate([rear_powerusb_x, rear_powerusb_y, rear_powerusb_z])
            rotate([90, 0, 0])
            scale([0.5, 0.6, 1])
            microusb_keepout(mycolor="Green");


    }

}

module showTogether() {

    intersection_only_pushbutton_area = !true;
    pushbutton_capture_extra = 3.0;

    intersection () {

        if (intersection_only_pushbutton_area) {
            // pushbutton "panel" area
            scale ([1.0,1.0,1.0])
            translate([panel_width - pb_panel_distance_from_corner - panel_shell_thickness - ( case_side_edge_extra) - pushbutton_capture_extra,
                       panel_height - panel_shell_thickness - ( case_top_bottom_edge_extra) + 2*e,
                       -9])
            rotate([90, 0, 0])
            cube ([pb_panel_length + 2*pushbutton_capture_extra, 20, 30], center=false);

        }

        union () {
            scale ([1.0,1.0,1.0])
                translate([0 - panel_shell_thickness - ( case_side_edge_extra) ,
                           0 - panel_shell_thickness - ( case_top_bottom_edge_extra),
                           0 + 20 - 20])
                rotate([0,0,0])
                caseFrontPanel();

            %scale ([1.0,1.0,1.0])
                  translate([(1/4)*case_side_edge_extra,
                             (1/2)*case_top_bottom_edge_extra,
                             0])
                  rotate([0,0,0])
                  monitorAndPiAssembly(showPi = true);

            panel_z_height = rear_panel_z_height ;

            scale ([1.0,1.0,1.0])
                translate([0 - panel_shell_thickness - ( case_side_edge_extra) ,
                           0 - panel_shell_thickness - ( case_top_bottom_edge_extra),
                           0 - 40 + 40 - panel_z_height ])
                rotate([0,0,0])
                caseBackPanel();

            // legs
            union () {
                scale ([1.0,1.0,1.0])
                    translate([panel_width + (0.9)*panel_shell_thickness,
                               panel_height - (4.3/1)*(case_top_bottom_edge_extra+panel_shell_thickness),
                               panel_z_height + (1.3)*assm_foot_thickness ])
                    rotate([-90 + assm_tilt_angle,0,90])
                    stand_foot();

                scale ([1.0,1.0,1.0])
                    translate([panel_width + (0.9)*panel_shell_thickness,
                               0 + (1/4.3)*(case_top_bottom_edge_extra+panel_shell_thickness),
                               panel_z_height + (1.3)*assm_foot_thickness ])
                    rotate([-90 + assm_tilt_angle,0,90])
                    stand_foot();

            }

        }
    }
}


if (show_everything) {
    showTogether();
} else {

    // $preview requires version 2019.05
    fn = $preview ? 30 : 100;

    if (show_monitor_assembly) {

        scale ([1.0,1.0,1.0])
            translate([0,0,0])
            rotate([0,0,0])
            monitorAndPiAssembly();
    } else {

        if (print_something) {
            if (print_foot) { stand_foot(); }
            if (print_front && !print_rear) { rotate([0,180,0]) caseFrontPanel(); }
            if (print_rear && !print_foot) {  rotate([0,180,0]) caseBackPanel(); }
            if (! (print_front || print_rear)) { stand_foot(); }
    }
}


}
