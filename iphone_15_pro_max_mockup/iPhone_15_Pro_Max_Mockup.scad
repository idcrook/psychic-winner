/*

  iPhone 15 Pro Max Mechanical Mockups dummy model

  Modeled by David Crook - https://github.com/idcrook

  2023-Sep-18

  Thingiverse: http://www.thingiverse.com/thing:TBD/

  GitHub: https://github.com/idcrook/psychic-winner/tree/main/iphone_15_pro_max_mockup

  NOTES:

  - OpenSCAD generation relies on MCAD library (https://github.com/openscad/MCAD)
  - See README.md for other notes.
*/

// * All measurements in millimeters * //

// If true, model is instantiated by this file
DEVELOPING_iPhone_15_Pro_Max_model = false;

use <../libraries/MCAD/2Dshapes.scad>

use <../libraries/dotSCAD/src/rounded_square.scad>

// very small number
e = 1/128;

// https://developer.apple.com/accessories/Accessory-Design-Guidelines.pdf
// "Device Dimensional Drawings" § 56.1 - 56.3 iPhone 15 Pro Max
// Release 21, downloaded 2023-Oct-31
// -	Height: 6.29 inches (159.9 mm)
// -	Width: 3.02 inches (76.7 mm)
// -	Depth: 0.32 inch (8.25 mm)

/// Gross iPhone 15 Pro Max dimensions
iphone_15_pro_max__height = 159.86;
iphone_15_pro_max__width  =  76.73;
iphone_15_pro_max__depth  =   8.25;
iphone_15_pro_max__z_mid  =   iphone_15_pro_max__depth / 2;

// Does our phone have a SIM slot?
SIM_SLOT_PRESENT = false;

// estimate
iphone_15_pro_max__face_corner_radius = 10.88; // very close to matching profile from blueprint

iphone_15_pro_max__blue_titanium = "#3B3E47";
iphone_15_pro_max__blue_titanium_titanium = "#23262E";
iphone_15_pro_max__blue_titanium_button = "#2F3340";
iphone_15_pro_max__blue_titanium_turret = iphone_15_pro_max__blue_titanium;
iphone_15_pro_max__blue_titanium_plateau = "#282E3A";
iphone_15_pro_max__blue_titanium_lens_bezel = "#48506F";

housing_spline_inlay_to_start_of_flat_area__width = 1.04;
titanium_housing__inset = housing_spline_inlay_to_start_of_flat_area__width;
rear_cam_plateau__inset = 4.70;
rear_cam_turret__trench_width = rear_cam_plateau__inset - titanium_housing__inset;

// "from_top" measurements are to center/midpoint of object

/// Left side buttons
volume_up__half_height     =  5.60;
volume_up__height          =  volume_up__half_height * 2;
volume_up__depth           =  2.66;
volume_up_center__from_top = 45.22;
volume_up__from_top        = volume_up_center__from_top;
volume_up__bump            = 0.45;
volume_up__z_mid           = 4.13;

volume_down__half_height     =  volume_up__half_height;
volume_down__height          =  volume_down__half_height * 2;
volume_down__depth           =  2.66;
volume_down_center__from_top = 59.42;
volume_down__from_top        = volume_down_center__from_top;
volume_down__bump            = 0.45;
volume_down__z_mid           = 4.13;

action_button__half_height = 3.02;
action_button__height   = action_button__half_height * 2;
action_button__depth    = 2.66;
action_button__center__from_top = 31.67;
action_button__from_top = action_button__center__from_top;
action_button__bump     = 0.45;
action_button__z_mid    = 4.12;

sim_slot__half_height =  8.07;
sim_slot__height      =  2 * sim_slot__half_height;
sim_slot__depth       =  2.76;
sim_slot_center__from_top = 91.07;
sim_slot__from_top    = sim_slot_center__from_top;
sim_slot__bump        =  0.03;  // flush actually

/// Right side buttons
side_button__half_height =  8.85;
side_button__height      =  side_button__half_height * 2;
side_button__depth       =  2.66;
side_button_center__from_top = 56.17;
side_button__from_top    = side_button_center__from_top;
side_button__bump        =  0.45;
side_button__z_mid    = 4.12;

// Front facing camera and sensors
truedepth_sensor_bar__height   = 5.58;
truedepth_sensor_bar__width    = 25.36;
truedepth_sensor_bar__from_top = 5.59;
truedepth_sensor_bar__from_left = 35.76;
truedepth_sensor_bar__curve_radius = 2.85;

//
speaker_top__height       = 0.45 ;
speaker_top__width        = 14.54;
speaker_top__from_top     = 1.17 - (speaker_top__height/2);
speaker_top__from_left    = 38.37;
speaker_top__curve_radius = speaker_top__height;

extend_cones_far = false;
default_keepout_cone_height = extend_cones_far ? 13.5 : 4.8 + 2.5 + 0.67;

// rear facing cameras and sensors / flash
rear_cam1_center__from_top = 14.17;
rear_cam2_center__from_top = 33.41;
rear_cam3_center__from_top = 23.79;
rear_flash_center__from_top = 10.22;
rear_mic_center__from_top  = 33.86;
// DETAIL F
rear_sensor_center__from_top = 38.22;

rear_cam1_center__from_left = 14.17;
rear_cam2_center__from_left = 14.17;
rear_cam3_center__from_left = 32.16;
rear_flash_center__from_left = 32.16;
rear_mic_center__from_left  = 37.95;
// DETAIL F
rear_sensor_center__from_left = 32.16;

rear_cam1__shroud_radius = 16.20/2;
rear_cam2__shroud_radius = 16.20/2;
rear_cam3__shroud_radius = 16.20/2;

rear_flash_center__diameter = 6.9;
rear_mic_center__diameter = 0.75;
rear_sensor_center_keepout__height = 7.06;
rear_sensor_center_keepout__width = 4.06;
rear_sensor_center__diameter = 7.0;

// angles in degress
rear_cam1__keepout_cone_angle = 123;
rear_cam2__keepout_cone_angle = 86;
rear_cam3__keepout_cone_angle = 24.1;
rear_flash__keepout_inner_cone_angle = 112;
//rear_flash__keepout_inner_cone_angle = 96;
rear_flash__keepout_outer_cone_angle = 157;
rear_sensor__keepout_cone_angle = 80.75;

rear_cam1__keepout_cone_to_front_cover_glass = 8.28;
rear_cam2__keepout_cone_to_front_cover_glass = 7.73;
rear_cam3__keepout_cone_to_front_cover_glass = -4.60;
rear_flash__keepout_outer_cone_to_front_cover_glass = 12.36;
rear_flash__keepout_inner_cone_start_diameter = 8.35;
rear_sensor__keepout_cone_to_front_cover_glass = -0.0;

// "turret" is the region rising freo back glass to camera plateau
rear_cam_turret__height_inner = (42.88 - rear_cam_plateau__inset);
rear_cam_turret__width_inner = (41.56 - rear_cam_plateau__inset);
rear_cam_turret__height_outer = (46.54 - titanium_housing__inset);
rear_cam_turret__width_outer = (45.22 - titanium_housing__inset);

rear_cam_turret__scale_height_inner_to_outer = 1 + (1/2)*(rear_cam_turret__height_outer/rear_cam_turret__height_inner - 1) ;
rear_cam_turret__scale_width_inner_to_outer  = 1 + (1/2)*(rear_cam_turret__width_outer/rear_cam_turret__width_inner - 1);

//rear_cam_turret__rradius_inner = 10.6;
//rear_cam_turret__rradius_outer = 13.7;
rear_cam_turret__rradius_inner = rear_cam2_center__from_left - rear_cam_plateau__inset;
rear_cam_turret__rradius_outer = rear_cam2_center__from_left - housing_spline_inlay_to_start_of_flat_area__width;

rear_cam_turret_center__from_top = rear_cam_turret__height_outer/2 + titanium_housing__inset;
rear_cam_turret_center__from_left = rear_cam_turret__width_outer/2 + titanium_housing__inset;

// camera plateau is the bed the lenses and sensors,etc are rising from
rear_cam_plateau__height = rear_cam_turret__height_inner;
rear_cam_plateau__width = rear_cam_turret__width_inner;

rear_cam_plateau_center__from_top = (rear_cam_plateau__height/2) + rear_cam_plateau__inset;
rear_cam_plateau_center__from_left = (rear_cam_plateau__width/2) + rear_cam_plateau__inset;

rear_cam_plateau__rradius = rear_cam_turret__rradius_inner;
rear_cam_plateau__z_height = 2.05;

rear_cam_camera_glass__height = 4.07;
rear_cam_camera_glass_rim__height = 2.90;  // guess
rear_cam_camera_glass_rim__outset = 1.05;  // guess

// the logo locates the center of the inductive charger coil
rear_logo_center__from_top = 79.93;
rear_logo_keepout__diameter = 57.50;

active_display__width     =  71.21;
active_display__height    = 154.34;
active_display__inset_from_exterior = 2.76;
active_display__corner_r  = iphone_15_pro_max__face_corner_radius - active_display__inset_from_exterior;

display_glass__width     =  74.73;
display_glass__height    = 157.85;
display_glass_over__width = (1/2)*(display_glass__width - active_display__width);    // ~2.5 mm
display_glass_over__height = (1/2)*(display_glass__height - active_display__height); // ~2.5 mm

dynamic_island__width = 20.69;
//dynamic_island_cutout__height =  6.07;
dynamic_island__height =  6.07;
dynamic_island__from_top = 7.67;
dynamic_island__from_top_active = 7.67 - active_display__inset_from_exterior;
dynamic_island__from_left_active  = active_display__width/2; // center
dynamic_island__R =  dynamic_island__height / 2;
dynamic_island__r =  0.95;

/// Bottom sensors and connectors
bottom__z_mid  = 4.12;

grill_hole__diameter = 1.35;
grill_hole__r = grill_hole__diameter/2;
screw_bottom__diameter = 1.50;

// from_left -> hole centers
screw_bottom_1__from_left = 31.44;
screw_bottom_2__from_left = 45.29;

// other side of USB-C port from speaker
mic1_bottom__hole_1__from_left = 20.40 + grill_hole__r;
mic1_bottom__hole_4__from_left = 27.17 - grill_hole__r;

// next to speaker grill
mic2_bottom__hole_1__from_left = 49.56 + grill_hole__r;
// (port of speaker ports)
mic2_bottom__hole_6__from_left = 60.84 - grill_hole__r;

usbc_connector__height       = 3.14;
usbc_connector__from_right   = 38.37; // distance to center point
usbc_connector__from_left = (iphone_15_pro_max__width - usbc_connector__from_right);
usbc_connector_end1__from_left = 33.87;
usbc_connector_end2__from_left = 42.86;
usbc_connector__width        = (usbc_connector_end2__from_left - usbc_connector_end1__from_left);

usbc_connector_keepout__width   = 12.45;
usbc_connector_keepout__height  = 6.60;
//usbc_connector_keepout__radius  = usbc_connector_keepout__height / 2;
usbc_connector_keepout__radius  = 3.25;
usbc_connector_keepout__outward = 14.0;

function translate_y_from_top (from_top)  = iphone_15_pro_max__height - from_top;
function translate_back_x_from_left (from_left)  = iphone_15_pro_max__width - from_left;
function translate_back_camera_depth (from_front)  = (iphone_15_pro_max__depth - from_front) ;

// place these function calls _after_ function is fully defined (including any closure variables)
rear_cam1__keepout_cone_depth = translate_back_camera_depth(from_front = rear_cam1__keepout_cone_to_front_cover_glass);
rear_cam2__keepout_cone_depth = translate_back_camera_depth(from_front = rear_cam2__keepout_cone_to_front_cover_glass);
rear_cam3__keepout_cone_depth = translate_back_camera_depth(from_front = rear_cam3__keepout_cone_to_front_cover_glass);
rear_flash__keepout_cone_depth = translate_back_camera_depth(from_front = rear_flash__keepout_outer_cone_to_front_cover_glass);
rear_sensor__keepout_cone_depth = translate_back_camera_depth(from_front = rear_sensor__keepout_cone_to_front_cover_glass);


/// creates for() range to give desired no of steps to cover range
function steps( start, no_steps, end) = [start:(end-start)/(no_steps-1):end];


module iphone_15_pro_max (width, length, depth,
                      corner_radius = 7, show_keepouts = true)
{
  show_usbc_keepout = show_keepouts;

  w_to_ss = width - 2*titanium_housing__inset;
  l_to_ss = length - 2*titanium_housing__inset;

  // Titanium housing goes all around with uniform inset
  translate([0,0,e])
    shell(width, length, depth-2*e,
          corner_radius, shell_color = iphone_15_pro_max__blue_titanium_titanium, color_alpha = 0.95);

  // replace the titanium shell at a uniform inset
  translate([titanium_housing__inset, titanium_housing__inset, 0])
    shell(w_to_ss, l_to_ss, depth, corner_radius - titanium_housing__inset, shell_color = iphone_15_pro_max__blue_titanium,
          color_alpha = 0.92, full_size_pass = false);

  // Action button
  color(iphone_15_pro_max__blue_titanium_button)
    translate([-action_button__bump,
               translate_y_from_top(action_button__from_top),
               action_button__z_mid]) {
    rotate([90,0,90])
      linear_extrude(action_button__bump+e)
      square([action_button__height, action_button__depth], center=true);
  }

  // volume up button
  color(iphone_15_pro_max__blue_titanium_button)
    translate([-volume_up__bump,
               translate_y_from_top(volume_up__from_top),
               volume_up__z_mid]) {
    rotate([90,0,90])
      linear_extrude(volume_up__bump+e)
      rounded_square(size = [volume_up__height, volume_up__depth], corner_r = volume_up__depth/2, center = true);
  }
  // volume down button
  color(iphone_15_pro_max__blue_titanium_button)
    translate([-volume_down__bump,
               translate_y_from_top(volume_down__from_top),
               volume_down__z_mid]) {
    rotate([90,0,90])
      linear_extrude(volume_down__bump+e)
      rounded_square(size=[volume_down__height, volume_down__depth], corner_r=volume_down__depth/2, center=true);
  }
  // sim slot
  if (SIM_SLOT_PRESENT) {
    color(iphone_15_pro_max__blue_titanium_button)
      translate([-sim_slot__bump,
                 translate_y_from_top(sim_slot__from_top),
                 side_button__z_mid]) {
      rotate([90,0,90])
        linear_extrude(sim_slot__bump+e)
        rounded_square(size=[sim_slot__height, sim_slot__depth], corner_r=sim_slot__depth/2, center=true);
    }
  }

  // side button
  color(iphone_15_pro_max__blue_titanium_button)
    translate([iphone_15_pro_max__width-e,
               translate_y_from_top(side_button__from_top),
               iphone_15_pro_max__z_mid]) {
    rotate([90,0,90])
      linear_extrude(side_button__bump+e)
      rounded_square([side_button__height, side_button__depth], corner_r=side_button__depth/2, center=true);
  }

  // mic1 holes
  for (i=steps(mic1_bottom__hole_1__from_left, 4, mic1_bottom__hole_4__from_left)) {
    echo (i);
    color("Black")
      translate([i, 0, bottom__z_mid]) {
      rotate([0, 90, 90])
        linear_extrude(1+e)
        circle(d=grill_hole__diameter);
    }
  }

  // mic2 holes
  for (i=steps(mic2_bottom__hole_1__from_left, 6, mic2_bottom__hole_6__from_left)) {
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

  // USB-C
  corner_r1 = usbc_connector__height / 2;
  corner_r2 = usbc_connector__height / 2;
  color("Black")
    translate([usbc_connector__from_left, 0, bottom__z_mid]) {
    rotate([-90, 0, 0])
      linear_extrude(height = 1+e, center = false, convexity = 10)
      complexRoundSquare([usbc_connector__width,
                          usbc_connector__height],
                         [corner_r1, corner_r2],
                         [corner_r1, corner_r2],
                         [corner_r1, corner_r2],
                         [corner_r1, corner_r2],
                         center=true);
  }

  // USB-C keepout
  if (show_usbc_keepout) {
    corner_r1_keepout = usbc_connector_keepout__radius;
    corner_r2_keepout = usbc_connector_keepout__radius;
    color("Red", alpha=0.2)
      translate([usbc_connector__from_left, 0, bottom__z_mid]) {
      rotate([90, 0, 0])
        %linear_extrude(height = usbc_connector_keepout__outward, center = false, convexity = 10)
        complexRoundSquare([usbc_connector_keepout__width,
                            usbc_connector_keepout__height],
                           [corner_r1_keepout, corner_r2_keepout],
                           [corner_r1_keepout, corner_r2_keepout],
                           [corner_r1_keepout, corner_r2_keepout],
                           [corner_r1_keepout, corner_r2_keepout],
                           center=true);
    }
  }

  // rear camera module
  translate([iphone_15_pro_max__width, iphone_15_pro_max__height, 0])
    rotate([0, 180, 0])
    rear_camera(show_keepouts = show_keepouts);
  // front sensor bar module
  translate([0, iphone_15_pro_max__height, iphone_15_pro_max__depth])
    rotate([0, 0, 0])
    front_sensor_bar(show_keepouts = show_keepouts);
}

// Profiles for edges and facing corners
// Note: Requires version 2015.03 (for use of concat())
face_profile_set = [[0.05, 12.36], [0.90, 7.58], [3.48, 3.48], [7.58, 0.9], [12.36, 0.90] ];
face_profile_polygon = concat(face_profile_set, [[17.24, 0.0], [0,0], [0.0, 17.24]]);
edge_profile_b_set = [[0.0, 1.84], [0.0, 2.46], [0.06, 3.07], [0.32, 3.62], [0.81, 3.99]];
edge_profile_b_polygon = concat([[1.15, iphone_15_pro_max__depth/2 + e], [0, iphone_15_pro_max__depth/2 + e], [0, 0]], edge_profile_b_set);

// FIXME: use face corner profile
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
  translate([0,0,iphone_15_pro_max__depth/2]) {
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
          linear_extrude(height=iphone_15_pro_max__height)
          edge_profile_corner();
      }
    translate([0,iphone_15_pro_max__height,z_off_midline])
      {
        rotate([90,0,0])
          linear_extrude(height=iphone_15_pro_max__height)
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
        translate([iphone_15_pro_max__face_corner_radius, iphone_15_pro_max__face_corner_radius, z_off_midline])
          rotate([0,0,-extra_angle_degrees])
          rotate_extrude(angle = rotate_angle)
          translate([-iphone_15_pro_max__face_corner_radius, 0])
          edge_profile_corner();
      }
      {
        translate([iphone_15_pro_max__face_corner_radius, iphone_15_pro_max__face_corner_radius, z_off_midline-0.05])
          rotate([0,0,-extra_angle_degrees])
          rotate_extrude(angle = rotate_angle)
          translate([-iphone_15_pro_max__face_corner_radius, 0])
          rotate([180,0,0])
          edge_profile_corner();
      }
  }
}

module short_edge_profile() {
  z_off_midline = edge_profile_b_polygon[0][1];

  translate([iphone_15_pro_max__width,0,0])
    rotate([0,0,90])
    union () {
    translate([0,0,z_off_midline-0.05])
      {
        rotate([-90,0,0])
          linear_extrude(height=iphone_15_pro_max__width)
          edge_profile_corner();
      }
    translate([0,iphone_15_pro_max__width,z_off_midline])
      {
        rotate([90,0,0])
          linear_extrude(height=iphone_15_pro_max__width)
          edge_profile_corner();
      }
  }
}

module test_keepout_cone() {
  translate([0,0,3]) { keepout_cone(angle=90);  }
  translate([0,0,0]) { keepout_cone(angle=90, solid = !true); }
  translate([-20,-20, 5]) { keepout_cone(angle=77, starting_r = 4.06/2, height = 10);  }
}


module shell(width, length, depth, corner_radius, shell_color = "Blue",
             color_alpha = 0.82, full_size_pass=true) {
  corner_r1 = corner_radius ;
  corner_r2 = corner_radius ;
  active_corner_r1 = active_display__corner_r ;
  active_corner_r2 = active_corner_r1;

  active_display_inset = active_display__inset_from_exterior;

  display_inset_depth = 0.4;

  if (full_size_pass) {
    // test_face_profile(); // guide for face corner profile
    // test_edge_profile(); // housing rounded corners profile
    // test_edge_corner_profile(); // housing rounded corners profile
    // test_keepout_cone();
  }

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
        translate([iphone_15_pro_max__width + e, 0, 0]) mirror([1,0,0])  long_edge_profile();

        // bottom side
        translate([0, -e, 0]) short_edge_profile();
        // top side
        translate([0, iphone_15_pro_max__height + e, 0]) mirror([0,1,0])  short_edge_profile();

        // bottom left corner
        translate([-4*e, -4*e, 0]) edge_corner_profile();
        // bottom right corner
        translate([iphone_15_pro_max__width + 4*e, -4*e, 0]) mirror([1,0,0]) edge_corner_profile();
        // top left corner
        translate([-4*e, iphone_15_pro_max__height + 4*e, 0]) mirror([0,1,0]) edge_corner_profile();
        // top right corner
        translate([iphone_15_pro_max__width + 4*e, iphone_15_pro_max__height + 4*e, 0]) mirror([1,1,0]) edge_corner_profile();
      }
    }
    dynamic_island__centered_from_left_active = dynamic_island__from_left_active ;
    dynamic_island__centered_from_top_active = active_display__height - dynamic_island__from_top_active;

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

            // dynamic_island
            translate([dynamic_island__centered_from_left_active,
                       dynamic_island__centered_from_top_active])
              complexRoundSquare([ dynamic_island__width, dynamic_island__height ],
                                 [dynamic_island__R, dynamic_island__R],
                                 [dynamic_island__R, dynamic_island__R],
                                 [dynamic_island__R, dynamic_island__R],
                                 [dynamic_island__R, dynamic_island__R],
                                 center=true);

            // tiny circle for bendout on left (not present in dynamic island > iphone 14 Pro)
            *translate([dynamic_island__centered_from_left_active - (1/2)*dynamic_island__width - dynamic_island__r,
                       dynamic_island__centered_from_top_active - dynamic_island__r])
              difference() {
              square(dynamic_island__r);
              circle(r = dynamic_island__r);
            }

            // tiny circle for bendout on right  (not present in dynamic island > iphone 14 Pro)
            *translate([dynamic_island__centered_from_left_active + (1/2)*dynamic_island__width + dynamic_island__r,
                       dynamic_island__centered_from_top_active - dynamic_island__r])
              mirror([1,0,0]) {
              difference() {
                square(dynamic_island__r);
                circle(r = dynamic_island__r);
              }
            }
          }
        }

    }
  }
}

module rear_camera (camera_plateau_height = rear_cam_plateau__z_height, show_keepouts = false) {

  sim_turret_h = 0.1 ;
  feature_h = 0.02;

  // turret
  rr_outer = rear_cam_turret__rradius_outer;
  rr_inner = rear_cam_turret__rradius_inner;
  %translate ([rear_cam_turret_center__from_left, -rear_cam_turret_center__from_top, -e])
    color(iphone_15_pro_max__blue_titanium_turret, alpha = 0.70)
    difference()
    {
      linear_extrude(height = sim_turret_h)
        union() {
          rounded_square(size=[rear_cam_turret__width_outer, rear_cam_turret__height_outer], corner_r = rr_outer, center=true);
      /* minkowski () { */
      /* rounded_square(size=[rear_cam_turret__width_inner, rear_cam_turret__height_inner], corner_r = 12, center=false); */
      /*   circle(r=rear_cam_turret__trench_width/2); */
      }
      translate ([0,0, -e])
        linear_extrude(height = sim_turret_h + 2*e)
        rounded_square(size=[rear_cam_turret__width_inner, rear_cam_turret__height_inner], corner_r = rr_inner, center=true);
    }

  // plateau
  pradius_inner = rear_cam_plateau__rradius;
  translate ([rear_cam_turret_center__from_left, -rear_cam_turret_center__from_top, -e])
    color(iphone_15_pro_max__blue_titanium_plateau, alpha = 0.70)
    difference() {
    linear_extrude(height = camera_plateau_height)
      rounded_square(size=[rear_cam_plateau__width, rear_cam_plateau__height], corner_r = pradius_inner, center=true);
  }

  // interior features // these start at back glass and "grow" outward
  translate ([rear_cam1_center__from_left, -rear_cam1_center__from_top, 0]) {
    rear_camera_lens(r = rear_cam1__shroud_radius);
    if (show_keepouts) { translate([0,0, -rear_cam1__keepout_cone_depth])
        keepout_cone(angle=rear_cam1__keepout_cone_angle, height = default_keepout_cone_height + rear_cam1__keepout_cone_depth);
    }
  }
  translate ([rear_cam2_center__from_left, -rear_cam2_center__from_top, 0]) {
    rear_camera_lens(r = rear_cam2__shroud_radius);
    if (show_keepouts) { translate([0,0, -rear_cam2__keepout_cone_depth])
        keepout_cone(angle=rear_cam2__keepout_cone_angle,  height = default_keepout_cone_height + rear_cam2__keepout_cone_depth);
    }
  }
  translate ([rear_cam3_center__from_left, -rear_cam3_center__from_top, 0]) {
    rear_camera_lens(r = rear_cam3__shroud_radius);
    if (show_keepouts) { translate([0,0, -rear_cam3__keepout_cone_depth])
        keepout_cone(angle=rear_cam3__keepout_cone_angle,  height = default_keepout_cone_height + rear_cam3__keepout_cone_depth);
    }
  }

  // flash
  translate ([rear_flash_center__from_left, -rear_flash_center__from_top, camera_plateau_height]) {
    color(alpha=0.30)
    linear_extrude(height = feature_h)
    circle(d = rear_flash_center__diameter);
    // there are two cones listed
    if (show_keepouts) {
      translate([0,0, -rear_flash__keepout_cone_depth - camera_plateau_height])
        keepout_cone(angle=rear_flash__keepout_outer_cone_angle,  starting_r = 11.76/2,
                     height = default_keepout_cone_height + rear_flash__keepout_cone_depth,
                     color_value = "#FEFE80", color_alpha = 0.03);
      translate([0,0, 0])
        keepout_cone(angle=rear_flash__keepout_inner_cone_angle,  starting_r = rear_flash__keepout_inner_cone_start_diameter/2,
                     height = default_keepout_cone_height - camera_plateau_height,
                     color_value = "#FEFE80", color_alpha = 0.05);
    }
  }

  // mic
  translate ([rear_mic_center__from_left, -rear_mic_center__from_top, camera_plateau_height])
    color("DarkGray")
    linear_extrude(height = feature_h)
    circle(d = rear_mic_center__diameter);

  // LIDAR (not shown in accessory guide DEATIL A, but keepout is in DETAIL F)
  translate ([rear_sensor_center__from_left, -rear_sensor_center__from_top, camera_plateau_height]) {
    color("Black")
      linear_extrude(height = feature_h)
      circle(d = rear_sensor_center__diameter);

      translate ([0, 0, 0]) {
        if (show_keepouts) {
          color("Purple", alpha=0.2)
          translate([0,0, -rear_sensor__keepout_cone_depth])
            keepout_cone(angle=rear_sensor__keepout_cone_angle,  height = default_keepout_cone_height + rear_sensor__keepout_cone_depth);
        }
      }

    if (show_keepouts) {
      *color("Red", alpha=0.2)
        %hull() {
        translate([0, rear_sensor_center_keepout__height/4, 0])
          keepout_cone(angle=rear_sensor__keepout_cone_angle, starting_r = rear_sensor_center_keepout__width/2,
                       height = default_keepout_cone_height - (camera_plateau_height), use_as_hull = true);
        translate([0, -rear_sensor_center_keepout__height/4, 0])
          keepout_cone(angle=rear_sensor__keepout_cone_angle, starting_r = rear_sensor_center_keepout__width/2,
                       height = default_keepout_cone_height - (camera_plateau_height), use_as_hull = true);
      }


    }
  }

}

module rear_camera_lens(r, h = rear_cam_camera_glass__height, h_rim = rear_cam_camera_glass_rim__height,
                        inset_rim = rear_cam_camera_glass_rim__outset) {
  color(iphone_15_pro_max__blue_titanium_lens_bezel, alpha=0.95)
    linear_extrude(height=h_rim)
    circle(r=r);
  color("Black", alpha=0.80)
    linear_extrude(height=h)
    circle(r=r - inset_rim);
}

module front_sensor_bar (show_keepouts = false) {
  corner_radius = truedepth_sensor_bar__curve_radius;

  *translate ([truedepth_sensor_bar__from_left, -truedepth_sensor_bar__from_top, -e])
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


module keepout_cone (angle, starting_r = 0, height = default_keepout_cone_height, solid = true,
                     use_as_hull = false, color_value = "Red", color_alpha = 0.2)
{
  // compute the slope of a cross-section line
  m = tan(90 - (angle/2));

  // compute what the x position (cone radius) will be at height of cone
  ending_r = height/m + starting_r;

  if (!use_as_hull) {
    % difference() {
      color(color_value, alpha=color_alpha)
        cylinder(h = height, r1 = starting_r, r2 = ending_r);
      if (!solid) {
        translate([0, 0, 1])
          cylinder(h = height, r1 = starting_r, r2 = ending_r);
      }
    }
  } else {
    // hull computation requires actual objects
    cylinder(h = height, r1 = starting_r, r2 = ending_r);
  }
}


echo ("corner_radius: ", iphone_15_pro_max__face_corner_radius);
echo ("turret scale height:", rear_cam_turret__scale_height_inner_to_outer);
echo ("turret scale width:", rear_cam_turret__scale_width_inner_to_outer);

// $preview requires version 2019.05
$fn = $preview ? 50 : 100;

if (DEVELOPING_iPhone_15_Pro_Max_model)  {
  iphone_15_pro_max(iphone_15_pro_max__width, iphone_15_pro_max__height, iphone_15_pro_max__depth,
                iphone_15_pro_max__face_corner_radius,
                show_keepouts = true);
}
