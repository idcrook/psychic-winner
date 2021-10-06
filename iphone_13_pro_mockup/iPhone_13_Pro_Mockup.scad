/*

  iPhone 13 Pro Mechanical Mockups dummy model

  Modeled by David Crook - https://github.com/idcrook

  2021-Oct-02

  Thingiverse: http://www.thingiverse.com/thing:4980345/

  GitHub: https://github.com/idcrook/psychic-winner/tree/main/iphone_13_pro_mockup

  NOTES:

  - OpenSCAD generation relies on MCAD library (https://github.com/openscad/MCAD)
  - See README.md for other notes.
*/

// * All measurements in millimeters * //

// If true, model is instantiated by this file
DEVELOPING_iPhone_13_Pro_model = !false;

use <MCAD/2Dshapes.scad>
// from dotSCAD
use <rounded_square.scad>

// very small number
e = 1/128;

/// Gross iPhone 13 Pro dimensions
iphone_13_pro__height = 146.71;
iphone_13_pro__width  =  71.54;
iphone_13_pro__depth  =   7.65;
iphone_13_pro__z_mid  =   iphone_13_pro__depth / 2;

// estimate
iphone_13_pro__face_corner_radius = 16.7; // close to profile from blueprint
iphone_13_pro__graphite = "#50504C";
iphone_13_pro__graphite_stainless_steel = "Silver";
iphone_13_pro__graphite_button = "#70706C";
iphone_13_pro__graphite_turret = iphone_13_pro__graphite;
iphone_13_pro__graphite_plateau = "#5F5E5A";
iphone_13_pro__graphite_lens_bezel = "#ABA9A4";

// "from_top" measurements are to center/midpoint of object

/// Left side buttons
volume_up__half_height     =  5.80;
volume_up__height          =  volume_up__half_height * 2;
volume_up__depth           =  3.06;
volume_up_center__from_top = 45.53;
volume_up__from_top        = volume_up_center__from_top;
volume_up__bump            = 0.45;
volume_up__z_mid           = 3.82;

volume_down__half_height     =  volume_up__half_height;
volume_down__height          =  volume_down__half_height * 2;
volume_down__depth           =  3.06;
volume_down_center__from_top = 59.93;
volume_down__from_top        = volume_down_center__from_top;
volume_down__bump            = 0.45;
volume_down__z_mid           = 3.82;

ringsilent_switch_cutout__half_height = 2.90;
ringsilent_switch_cutout__height   = ringsilent_switch_cutout__half_height * 2;
ringsilent_switch_cutout__depth    = 2.15;
ringsilent_switch_cutout_center__from_top = 32.22;
ringsilent_switch_cutout__from_top = ringsilent_switch_cutout_center__from_top;
ringsilent_switch_cutout__bump     = 0.60;
ringsilent_switch_cutout__z_mid    = 3.75;

sim_slot__half_height =  8.02;
sim_slot__height      =  2 * sim_slot__half_height;
sim_slot__depth       =  2.66;
sim_slot_center__from_top = 83.69;
sim_slot__from_top    = sim_slot_center__from_top;
sim_slot__bump        =  0.03;  // flush actually

/// Right side buttons
side_button__half_height =  9.05;
side_button__height      =  side_button__half_height * 2;
side_button__depth       =  3.06;
side_button_center__from_top = 44.61;
side_button__from_top    = side_button_center__from_top;
side_button__bump        =  0.45;

// Front facing camera and sensors
truedepth_sensor_bar__height   = 5.58;
truedepth_sensor_bar__width    = 25.36;
truedepth_sensor_bar__from_top = 5.59;
truedepth_sensor_bar__from_left = 35.76;
truedepth_sensor_bar__curve_radius = 2.85;

//
speaker_top__height       = 0.85;
speaker_top__width        = 11.12;
speaker_top__from_top     = 1.75 - (speaker_top__height/2);
speaker_top__from_left    = 35.76;
speaker_top__curve_radius = 0.69;

// rear facing cameras
rear_cam1_center__from_top = 13.43;
rear_cam2_center__from_top = 31.35;
rear_cam3_center__from_top = 22.39;
rear_flash_center__from_top = 9.42;
rear_mic_center__from_top  = rear_cam2_center__from_top + 0.6;
rear_sensor_center__from_top = 35.35;

rear_cam1_center__from_left = 13.43;
rear_cam2_center__from_left = 13.43;
rear_cam3_center__from_left = 30.08;
rear_flash_center__from_left = 30.08;
rear_mic_center__from_left  = rear_cam3_center__from_left + 6; // guess
rear_sensor_center__from_left = 30.08;

rear_cam1__shroud_radius = 15.53/2;
rear_cam2__shroud_radius = 15.53/2;
rear_cam3__shroud_radius = 15.8/2;

rear_flash_center__diameter = 6;  // guess
rear_mic_center__diameter = 1.15;
rear_sensor_center_keepout__height = 7.06;
rear_sensor_center_keepout__width = 4.06;
rear_sensor_center__diameter = rear_sensor_center_keepout__height;

rear_cam_turret__height_inner = (40.51 - 4.27);
rear_cam_turret__width_inner = (39.28 - 4.27);
rear_cam_turret__height_outer = (43.62 - 1.15);
rear_cam_turret__width_outer = (42.39 - 1.15);

rear_cam_turret__rradius_inner = 10.2;
rear_cam_turret__rradius_outer = 14.5;

rear_cam_turret_center__from_top = (rear_cam1_center__from_top + rear_cam2_center__from_top)/2;
rear_cam_turret_center__from_left = (rear_cam1_center__from_left + rear_cam3_center__from_left)/2;
rear_cam_turret_keepout__height_above = 1.21;

rear_cam_plateau__height_inner = (40.51 - 4.27);
rear_cam_plateau__width_inner = (39.28 - 4.27);
rear_cam_plateau__height_outer = (43.62 - 1.15);
rear_cam_plateau__width_outer = (42.39 - 1.15);

rear_cam_plateau_center__from_top = (rear_cam_plateau__height_outer/2) + 1.15;
rear_cam_plateau_center__from_left = (rear_cam_plateau__width_outer/2) + 1.15;
rear_cam_plateau_keepout__height_above = 1.21;

rear_cam_plateau__rradius_inner = rear_cam_turret__rradius_inner;
rear_cam_plateau__rradius_outer = rear_cam_turret__rradius_outer;
rear_cam_plateau__height = 1.68;

rear_cam_camera_glass__height = 3.60;
rear_cam_camera_glass_rim__height = 2.90;  // guess
rear_cam_camera_glass_rim__outset = 1.05;  // guess

// the logo locates the center of the inductive charger coil
rear_logo_center__from_top = 73.35;
rear_logo_keepout__diameter = 57.50;

active_display__width     =  64.58;
active_display__height    = 139.77;
active_display__inset_from_exterior = 3.47;
active_display__corner_r  = iphone_13_pro__face_corner_radius - active_display__inset_from_exterior;

display_glass__width     =  69.42;
display_glass__height    = 144.61;
display_glass_over__width = (1/2)*(display_glass__width - active_display__width);    // ~2.5 mm
display_glass_over__height = (1/2)*(display_glass__height - active_display__height); // ~2.5 mm

housing_spline_inlay_to_start_of_flat_area__width = 1.15;
stainless_housing__inset = housing_spline_inlay_to_start_of_flat_area__width;

notch__width = 26.79;
notch_cutout__height =  5.58;
notch__height =  notch_cutout__height * 2;
notch__from_left_active  = active_display__width/2; // center
notch__R =  3.8;
notch__r =  0.95;

/// Bottom sensors and connectors
bottom__z_mid  = 3.75;

grill_hole__diameter = 1.53;
screw_bottom__diameter = 1.50;

// from_left -> hole centers
screw_bottom_1__from_left = 29.37;
screw_bottom_2__from_left = 42.16;

// other side of lightning port from speaker
mic1_bottom__hole_1__from_left = 19.14;
//mic1_bottom__hole_2__from_left = ;
mic1_bottom__hole_3__from_left = 25.18;

// next to speaker grill
mic2_bottom__hole_1__from_left = 46.34;
// (port of speaker ports)
mic2_bottom__hole_5__from_left = 56.89;

lightning_connector__height       = 2.30;
lightning_connector__from_right   = 35.76; // distance to center point
lightning_connector__from_left = (iphone_13_pro__width - lightning_connector__from_right);
lightning_connector_end1__from_left = 31.74;
lightning_connector_end2__from_left = 39.79;
lightning_connector__width        = (lightning_connector_end2__from_left - lightning_connector_end1__from_left);

lightning_connector_keepout__radius  = 3.4;
lightning_connector_keepout__width   = 13.65;
lightning_connector_keepout__height  = 6.85;
lightning_connector_keepout__outward = 14.0;

function translate_y_from_top (from_top)  = iphone_13_pro__height - from_top;
function translate_back_x_from_left (from_left)  = iphone_13_pro__width - from_left;

/// creates for() range to give desired no of steps to cover range
function steps( start, no_steps, end) = [start:(end-start)/(no_steps-1):end];


module iphone_13_pro (width, length, depth,
                      corner_radius = 7, show_lightning_keepout = true)
{
  w_to_ss = width - 2*stainless_housing__inset;
  l_to_ss = length - 2*stainless_housing__inset;

  // stainless steel housing goes all around with uniform inset
  translate([0,0,e])
    shell(width, length, depth-2*e,
          corner_radius, shell_color = iphone_13_pro__graphite_stainless_steel, color_alpha = 0.95);

  // replace the stainless shell at a uniform inset
  translate([stainless_housing__inset, stainless_housing__inset, 0])
    shell(w_to_ss, l_to_ss, depth, corner_radius - stainless_housing__inset, shell_color = iphone_13_pro__graphite,
          color_alpha = 0.85, full_size_pass = false);

  // ring/silent switch
  color(iphone_13_pro__graphite_button)
    translate([-ringsilent_switch_cutout__bump,
               translate_y_from_top(ringsilent_switch_cutout__from_top),
               ringsilent_switch_cutout__z_mid]) {
    rotate([90,0,90])
      linear_extrude(ringsilent_switch_cutout__bump+e)
      square([ringsilent_switch_cutout__height, ringsilent_switch_cutout__depth], center=true);
  }

  // volume up button
  color(iphone_13_pro__graphite_button)
    translate([-volume_up__bump,
               translate_y_from_top(volume_up__from_top),
               volume_up__z_mid]) {
    rotate([90,0,90])
      linear_extrude(volume_up__bump+e)
      rounded_square(size = [volume_up__height, volume_up__depth], corner_r = volume_up__depth/2, center = true);
  }
  // volume down button
  color(iphone_13_pro__graphite_button)
    translate([-volume_down__bump,
               translate_y_from_top(volume_down__from_top),
               volume_down__z_mid]) {
    rotate([90,0,90])
      linear_extrude(volume_down__bump+e)
      rounded_square(size=[volume_down__height, volume_down__depth], corner_r=volume_down__depth/2, center=true);
  }
  // sim slot
  color(iphone_13_pro__graphite_button)
    translate([-sim_slot__bump,
               translate_y_from_top(sim_slot__from_top),
               iphone_13_pro__z_mid]) {
    rotate([90,0,90])
      linear_extrude(sim_slot__bump+e)
      rounded_square(size=[sim_slot__height, sim_slot__depth], corner_r=sim_slot__depth/2, center=true);
  }

  // side button
  color(iphone_13_pro__graphite_button)
    translate([iphone_13_pro__width-e,
               translate_y_from_top(side_button__from_top),
               iphone_13_pro__z_mid]) {
    rotate([90,0,90])
      linear_extrude(side_button__bump+e)
      rounded_square([side_button__height, side_button__depth], corner_r=side_button__depth/2, center=true);
  }

  // mic1 holes
  for (i=steps(mic1_bottom__hole_1__from_left, 3, mic1_bottom__hole_3__from_left)) {
    echo (i);
    color("Black")
      translate([i, 0, bottom__z_mid]) {
      rotate([0, 90, 90])
        linear_extrude(1+e)
        circle(d=grill_hole__diameter);
    }
  }

  // mic2 holes
  for (i=steps(mic2_bottom__hole_1__from_left, 5, mic2_bottom__hole_5__from_left)) {
    echo (i);
    color("Black")
      translate([i, 0, bottom__z_mid]) {
      rotate([0, 90, 90])
        linear_extrude(1+e)
        circle(d=grill_hole__diameter);
    }
  }

  // bottom screw holes
  for (i=[screw_bottom_1__from_left, screw_bottom_2__from_left]) {
    color("Black")
      translate([i, 0, bottom__z_mid]) {
      rotate([-90, 0, 0])
        linear_extrude(1+e)
        circle(d=screw_bottom__diameter);
    }
  }

  // lightning
  corner_r1 = 1.1;
  corner_r2 = 1.1;
  color("Black")
    translate([lightning_connector__from_left, 0, bottom__z_mid]) {
    rotate([-90, 0, 0])
      linear_extrude(height = 1+e, center = false, convexity = 10)
      complexRoundSquare([lightning_connector__width,
                          lightning_connector__height],
                         [corner_r1, corner_r2],
                         [corner_r1, corner_r2],
                         [corner_r1, corner_r2],
                         [corner_r1, corner_r2],
                         center=true);
  }

  // lightning keepout
  if (show_lightning_keepout) {
    corner_r1_keepout = lightning_connector_keepout__radius;
    corner_r2_keepout = lightning_connector_keepout__radius;
    color("Red", alpha=0.2)
      translate([lightning_connector__from_left, 0, bottom__z_mid]) {
      rotate([90, 0, 0])
        %linear_extrude(height = lightning_connector_keepout__outward, center = false, convexity = 10)
        complexRoundSquare([lightning_connector_keepout__width,
                            lightning_connector_keepout__height],
                           [corner_r1_keepout, corner_r2_keepout],
                           [corner_r1_keepout, corner_r2_keepout],
                           [corner_r1_keepout, corner_r2_keepout],
                           [corner_r1_keepout, corner_r2_keepout],
                           center=true);
    }
  }

  // rear camera module
  translate([iphone_13_pro__width, iphone_13_pro__height, 0])
    rotate([0, 180, 0])
    rear_camera();
  // front sensor bar module
  translate([0, iphone_13_pro__height, iphone_13_pro__depth])
    rotate([0, 0, 0])
    front_sensor_bar();
}

// Note: Requires version 2015.03 (for use of concat())
face_profile_set = [[0.07, 15.89], [0.92, 11.42], [3.31, 7.04], [7.04, 3.31], [11.43, 0.92], [15.89, 0.07] ];
face_profile_polygon = concat(face_profile_set, [[16.0, 0.0], [0,0], [0.0, 16.0]]);
edge_profile_b_set = [[0.21, 2.63], [0.21, 3.07], [0.34, 3.47], [0.69, 3.71], [1.12, 3.75]];
edge_profile_b_polygon = concat([[1.15, iphone_13_pro__depth/2 + e], [0, iphone_13_pro__depth/2 + e], [0, 0]], edge_profile_b_set);

module face_profile_corner (size = 1.0) {
  scale([size, size]) {
    polygon(face_profile_polygon);
  }
}

module edge_profile_corner (size = 1.0) {
  scale([size, size]) {
    polygon(edge_profile_b_polygon);
  }
}

module test_face_profile() {
  translate([0,0,3]) {
    % face_profile_corner();
  }
}

module test_edge_profile() {
  z_off_midline = edge_profile_b_polygon[0][1];
  * union () { long_edge_profile    (); }
  % union () { short_edge_profile    (); }
}

module test_edge_corner_profile() {
  z_off_midline = edge_profile_b_polygon[0][1];
  % union () { edge_corner_profile    (); }
}

module long_edge_profile() {
  z_off_midline = edge_profile_b_polygon[0][1];

  union () {
      translate([0,0,z_off_midline-0.05])
      {
        rotate([-90,0,0])
          linear_extrude(height=iphone_13_pro__height)
          edge_profile_corner();
      }
    translate([0,iphone_13_pro__height,z_off_midline])
      {
        rotate([90,0,0])
          linear_extrude(height=iphone_13_pro__height)
          edge_profile_corner();
      }
  }
}

module edge_corner_profile() {
  z_off_midline = edge_profile_b_polygon[0][1];
  extra_angle_degrees = 0;
  rotate_angle = 90 + 2*extra_angle_degrees;

  union () {
      {
        translate([iphone_13_pro__face_corner_radius, iphone_13_pro__face_corner_radius, z_off_midline])
          rotate([0,0,-extra_angle_degrees])
          rotate_extrude(angle = rotate_angle)
          translate([-iphone_13_pro__face_corner_radius, 0])
          edge_profile_corner();
      }
      {
        translate([iphone_13_pro__face_corner_radius, iphone_13_pro__face_corner_radius, z_off_midline-0.05])
          rotate([0,0,-extra_angle_degrees])
          rotate_extrude(angle = rotate_angle)
          translate([-iphone_13_pro__face_corner_radius, 0])
          rotate([180,0,0])
          edge_profile_corner();
      }
  }
}

module short_edge_profile() {
  z_off_midline = edge_profile_b_polygon[0][1];

  translate([iphone_13_pro__width,0,0])
    rotate([0,0,90])
    union () {
    translate([0,0,z_off_midline-0.05])
      {
        rotate([-90,0,0])
          linear_extrude(height=iphone_13_pro__width)
          edge_profile_corner();
      }
    translate([0,iphone_13_pro__width,z_off_midline])
      {
        rotate([90,0,0])
          linear_extrude(height=iphone_13_pro__width)
          edge_profile_corner();
      }
  }
}

module shell(width, length, depth, corner_radius, shell_color = "Blue", color_alpha = 0.82, full_size_pass=true)
{
  corner_r1 = corner_radius ;
  corner_r2 = corner_radius ;
  active_corner_r1 = active_display__corner_r ;
  active_corner_r2 = active_corner_r1;

  active_display_inset = active_display__inset_from_exterior;

  display_inset_depth = 0.4;

  // test_face_profile(); // guide for face corner profile
  // test_edge_profile(); // housing rounded corners profile
  // test_edge_corner_profile(); // housing rounded corners profile

  // generate the basic solid outline
  {
    color(shell_color, alpha = color_alpha)
      difference() {

      // most of body
      union($fn = 25)
      {
        // main rectangular region
        translate([0, 0, 0]) {
          linear_extrude(height = depth, center = false, convexity = 10)
            complexRoundSquare([ width ,
                                 length ],
                               [corner_r1, corner_r2],
                               [corner_r1, corner_r2],
                               [corner_r1, corner_r2],
                               [corner_r1, corner_r2],
                               center=false);
        }
      } // subtract starting here

      if (full_size_pass) {
        // left side
        translate([-e, 0, 0]) long_edge_profile();
        // right side
        translate([iphone_13_pro__width + e, 0, 0]) mirror([1,0,0])  long_edge_profile();

        // bottom side
        translate([0, -e, 0]) short_edge_profile();
        // top side
        translate([0, iphone_13_pro__height + e, 0]) mirror([0,1,0])  short_edge_profile();

        // bottom left corner
        translate([-4*e, -4*e, 0]) edge_corner_profile();
        // bottom right corner
        translate([iphone_13_pro__width + 4*e, -4*e, 0]) mirror([1,0,0]) edge_corner_profile();
        // top left corner
        translate([-4*e, iphone_13_pro__height + 4*e, 0]) mirror([0,1,0]) edge_corner_profile();
        // top right corner
        translate([iphone_13_pro__width + 4*e, iphone_13_pro__height + 4*e, 0]) mirror([1,1,0]) edge_corner_profile();
      }
    }
    notch__centered_from_left_active = notch__from_left_active ;
    notch__centered_from_top_active = active_display__height;

    // display active region
    if (full_size_pass) {
      translate([active_display_inset, active_display_inset,
                 depth - display_inset_depth])
        {
          color ("#103080", alpha = 0.70)
            linear_extrude(height = display_inset_depth + 2*e, center = false, convexity = 10)
            difference() {
            complexRoundSquare([ active_display__width,
                                 active_display__height ],
                               [active_corner_r1, active_corner_r2],
                               [active_corner_r1, active_corner_r2],
                               [active_corner_r1, active_corner_r2],
                               [active_corner_r1, active_corner_r2],
                               center=false);

            // notch
            translate([notch__centered_from_left_active,
                       notch__centered_from_top_active])
              complexRoundSquare([ notch__width, notch__height ],
                                 [notch__R, notch__R],
                                 [notch__R, notch__R],
                                 [notch__R, notch__R],
                                 [notch__R, notch__R],
                                 center=true);

            // tiny circle for bendout on left
            translate([notch__centered_from_left_active - (1/2)*notch__width - notch__r,
                       notch__centered_from_top_active - notch__r])
              difference() {
              square(notch__r);
              circle(r = notch__r);
            }

            // tiny circle for bendout on right
            translate([notch__centered_from_left_active + (1/2)*notch__width + notch__r,
                       notch__centered_from_top_active - notch__r])
              mirror([1,0,0]) {
              difference() {
                square(notch__r);
                circle(r = notch__r);
              }
            }
          }
        }

    }
  }
}

module rear_camera (camera_plateau_height = rear_cam_plateau__height) {

  //h = rear_cam_turret_keepout__height_above ;
  h = 0.1;

  // turrent
  rradius_outer = rear_cam_turret__rradius_outer;
  rradius_inner = rear_cam_turret__rradius_inner;
  translate ([rear_cam_turret_center__from_left, -rear_cam_turret_center__from_top, -e])
    color(iphone_13_pro__graphite_turret, alpha = 0.70)
    difference() {
    linear_extrude(height = h)
      complexRoundSquare([rear_cam_turret__width_outer,
                          rear_cam_turret__height_outer],
                         [rradius_outer, rradius_outer],
                         [rradius_outer, rradius_outer],
                         [rradius_outer, rradius_outer],
                         [rradius_outer, rradius_outer],
                         center=true);


    translate ([0,0, -e])
      linear_extrude(height = h + 2*e)
      complexRoundSquare([rear_cam_turret__width_inner,
                          rear_cam_turret__height_inner],
                         [rradius_inner, rradius_inner],
                         [rradius_inner, rradius_inner],
                         [rradius_inner, rradius_inner],
                         [rradius_inner, rradius_inner],
                         center=true);
  }


  // plateau
  pradius_inner = rear_cam_plateau__rradius_inner;
  translate ([rear_cam_turret_center__from_left, -rear_cam_turret_center__from_top, -e])
    color(iphone_13_pro__graphite_plateau, alpha = 0.70)
    difference() {
    linear_extrude(height = camera_plateau_height)
      complexRoundSquare([rear_cam_plateau__width_inner,
                          rear_cam_plateau__height_inner],
                         [pradius_inner, pradius_inner],
                         [pradius_inner, pradius_inner],
                         [pradius_inner, pradius_inner],
                         [pradius_inner, pradius_inner],
                         center=true);


    % translate ([0,0, -e])
      linear_extrude(height = h + 2*e)
      complexRoundSquare([rear_cam_plateau__width_inner,
                          rear_cam_plateau__height_inner],
                         [pradius_inner, pradius_inner],
                         [pradius_inner, pradius_inner],
                         [pradius_inner, pradius_inner],
                         [pradius_inner, pradius_inner],
                         center=true);
  }

  // interior features
  translate ([rear_cam1_center__from_left, -rear_cam1_center__from_top, 0])
    rear_camera_lens(r = rear_cam1__shroud_radius);

  translate ([rear_cam2_center__from_left, -rear_cam2_center__from_top, 0])
    rear_camera_lens(r = rear_cam2__shroud_radius);

  translate ([rear_cam3_center__from_left, -rear_cam3_center__from_top, 0])
    rear_camera_lens(r = rear_cam3__shroud_radius);

  translate ([rear_flash_center__from_left, -rear_flash_center__from_top, camera_plateau_height])
    color(alpha=0.30)
    linear_extrude(height = h/4)
    circle(d = rear_flash_center__diameter);

  translate ([rear_mic_center__from_left, -rear_mic_center__from_top, camera_plateau_height])
    color("DarkGray")
    linear_extrude(height = h/4)
    circle(d = rear_mic_center__diameter);

  translate ([rear_sensor_center__from_left, -rear_sensor_center__from_top, camera_plateau_height])
    color("Black")
    linear_extrude(height = h/4)
    circle(d = rear_sensor_center__diameter);


}

module rear_camera_lens(r, h = rear_cam_camera_glass__height,
                        h_rim = rear_cam_camera_glass_rim__height,
                        inset_rim = rear_cam_camera_glass_rim__outset) {
  color(iphone_13_pro__graphite_lens_bezel, alpha=0.95)
    linear_extrude(height=h_rim)
    circle(r=r);

  color("Black", alpha=0.86)
    linear_extrude(height=h)
    circle(r=r - inset_rim);

}

module front_sensor_bar () {

  corner_radius = truedepth_sensor_bar__curve_radius;

  translate ([truedepth_sensor_bar__from_left, -truedepth_sensor_bar__from_top, -e])
    color("#101010", alpha = 0.50)
    linear_extrude(height = 3*e)
    complexRoundSquare([truedepth_sensor_bar__width,
                        truedepth_sensor_bar__height],
                       [corner_radius, corner_radius],
                       [corner_radius, corner_radius],
                       [corner_radius, corner_radius],
                       [corner_radius, corner_radius],
                       center=true);

  translate ([speaker_top__from_left, -speaker_top__from_top, -e])
    color("#101010", alpha = 0.80)
    linear_extrude(height = 4*e)
    complexRoundSquare([speaker_top__width,
                        speaker_top__height],
                       [speaker_top__curve_radius, speaker_top__curve_radius],
                       [speaker_top__curve_radius, speaker_top__curve_radius],
                       [0,0],
                       [0,0],
                       center=true);

}

echo ("corner_radius: ", iphone_13_pro__face_corner_radius);

// $preview requires version 2019.05
$fn = $preview ? 50 : 100;

if (DEVELOPING_iPhone_13_Pro_model)  {
  iphone_13_pro(iphone_13_pro__width, iphone_13_pro__height, iphone_13_pro__depth,
                iphone_13_pro__face_corner_radius,
                show_lightning_keepout = true);
}
