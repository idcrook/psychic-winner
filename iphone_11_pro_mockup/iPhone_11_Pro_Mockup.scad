/*

  iPhone 11 Pro Mechanical Mockups dummy model

  Modeled by David Crook - https://github.com/idcrook

  2019-Sep-16

  Thingiverse:
  http://www.thingiverse.com/thing:3865803/

  GitHub:
  https://github.com/idcrook/psychic-winner/tree/master/iphone_11_pro_mockup


  NOTES:

  - OpenSCAD generation relies on the MCAD library (https://github.com/openscad/MCAD)

*/


// * All measurements in millimeters * //


use <MCAD/2Dshapes.scad>

// very small number
e = 0.02;

/// Gross iPhone 11 Pro dimensions
iphone_11_pro__height = 144.0;
iphone_11_pro__width  =  71.4;
iphone_11_pro__depth  =   8.1;
iphone_11_pro__z_mid  =   iphone_11_pro__depth / 2;

// estimate
iphone_11_pro__face_corner_radius = 7.0;
iphone_11_pro__edge_radius = (iphone_11_pro__depth - 0.25) / 2 ;
iphone_11_pro__midnight_green = "#788473";
iphone_11_pro__midnight_green_button = "#55625D";
iphone_11_pro__midnight_green_turret = "#485249";
iphone_11_pro__midnight_green_lens_bezel = "#7B8D7E";

// "from_top" measurements are to center/midpoint of object

/// Left side buttons
volume_up__height   =  5.88 * 2;
volume_up__depth    =  2.88;
volume_up__from_top = 37.84;
volume_up__bump = 0.38;

volume_down__height   =  5.88 * 2;
volume_down__depth    =  2.88;
volume_down__from_top = 51.37;
volume_down__bump = 0.38;

ringsilent_switch_cutout__height = 5.71;
ringsilent_switch_cutout__depth = 2.08;
ringsilent_switch_cutout__from_top = 24.72;
ringsilent_switch_cutout__bump = 0.43;

/// Right side buttons

side_button__height   =  8.77 * 2;
side_button__depth    =  2.88;
side_button__from_top = 44.61;
side_button__bump     =  0.38;

sim_slot__height   =  16.03;
sim_slot__depth    =  2.66;
sim_slot__from_top = 71.67 + (1/2)*(sim_slot__height);
sim_slot__bump     =  0.03;  // flush actually


// Front facing camera and sensors
truedepth_sensor_bar__height   = 6.23;
truedepth_sensor_bar__width    = 33.9;
truedepth_sensor_bar__from_top = 5.35;
truedepth_sensor_bar__from_left = 35.68;
truedepth_sensor_bar__curve_radius = truedepth_sensor_bar__height/2;

//
speaker_top__height       = 1.38;
speaker_top__width        = 7.84;
speaker_top__from_top     = 6.08;
speaker_top__from_left    = 35.68;
speaker_top__curve_radius = 0.69;

mic_top__height       = 1.38; // diameter
mic_top__from_top     = 6.08;
mic_top__from_left    = 35.68;
mic_top__radius       = mic_top__height/2;

// rear facing cameras
rear_cam1_center__from_top = 12.04;
rear_cam2_center__from_top = 27.06;
rear_cam3_center__from_top = 19.55;
rear_flash_center__from_top = 9.31;
rear_mic_center__from_top  = 29.78;

rear_cam1_center__from_left = 12.04;
rear_cam2_center__from_left = 12.04;
rear_cam3_center__from_left = 25.04;
rear_flash_center__from_left = 25.04;
rear_mic_center__from_left  = 25.04;

rear_cam_center__diameter = 2 * 5.5;  // guess

rear_flash_center__diameter = 2 * (rear_cam1_center__from_top - rear_flash_center__from_top);
rear_mic_center__diameter = 2.40;

rear_cam_turret__height_inner = 28.99;
rear_cam_turret__width_inner = 26.87;
rear_cam_turret__height_outer = 32.71;
rear_cam_turret__width_outer = 30.59;

rear_cam_turret__rradius_inner = 6.5;
rear_cam_turret__rradius_outer = 8.5;

rear_cam_turret_center__from_top = (rear_cam1_center__from_top + rear_cam2_center__from_top)/2;
rear_cam_turret_center__from_left = (rear_cam1_center__from_left + rear_cam3_center__from_left)/2;
rear_cam_turret_keepout__height_above = 1.21;


// the logo locates the center of the inductive charger coil
rear_logo_center__from_top = 72.0;
rear_logo_keepout__diameter = 48.80;

rear_housing_spline_inlay_to_start_of_flat_area__width = 4.96;

active_display__width     =  62.33;
active_display__height    = 134.95;
active_display__recessed  =   0.0;
active_display__from_top  =   0.0;
active_display__from_right  =   0.0;

display_glass__width     =  67.37;
display_glass__height    = 139.99;
display_glass_over__width = (1/2)*(display_glass__width - active_display__width);    // ~2.5 mm
display_glass_over__height = (1/2)*(display_glass__height - active_display__height); // ~2.5 mm

notch__width = 34.80;
notch__height =  4.99 * 2; // bottom half of a "rounded" box
notch__from_left_active  = active_display__width/2; // center
notch__R =  3.59;
notch__r =  0.81;




/// Bottom sensors and connectors
// from_left -> hole centers

grill_hole__diameter = 1.45;
screw_bottom__diameter = 1.60;

// other side of lightning port from speaker
mic1_bottom__hole_1__from_left = 19.07;
//mic1_bottom__hole_2__from_left = ;
mic1_bottom__hole_3__from_left = 25.03;

// next to speaker grill
mic2_bottom__hole_1__from_left = 46.33;
// (port of speaker ports)
mic2_bottom__hole_6__from_left = 59.06;

screw_bottom_1__from_left = 29.29;
screw_bottom_2__from_left = 42.08;


//
lightning_connector__height       = 3.01;
lightning_connector__from_right   = 35.68; // distance to center point
lightning_connector__from_left = (iphone_11_pro__width - lightning_connector__from_right);
lightning_connector_end1__from_left = 31.30;
lightning_connector_end2__from_left = 40.06;
lightning_connector__width        = (lightning_connector_end2__from_left - lightning_connector_end1__from_left);

lightning_connector_keepout__radius  = 3.4;
lightning_connector_keepout__width   = 13.65;
lightning_connector_keepout__height  = 6.85;
lightning_connector_keepout__outward = 14.0;


model_quality = 25;

function translate_y_from_top (from_top)  = iphone_11_pro__height - from_top;
function translate_back_x_from_left (from_left)  = iphone_11_pro__width - from_left;


/// creates for() range to give desired no of steps to cover range
function steps( start, no_steps, end) = [start:(end-start)/(no_steps-1):end];


module iphone_11_pro (width, length, depth,
                      corner_radius = 7, edge_radius = 3.925, show_lightning_keepout = true)
{
  // fixme: add an inset translate for all following so that, including

  // button bumps, are bound {x,y} >= {0,0}
  shell(width, length, depth, corner_radius, edge_radius, shell_color = iphone_11_pro__midnight_green);

  // ring/silent switch
  color(iphone_11_pro__midnight_green_button)
    translate([-ringsilent_switch_cutout__bump,
               translate_y_from_top(ringsilent_switch_cutout__from_top),
               iphone_11_pro__z_mid]) {
    rotate([90,0,90])
      linear_extrude(ringsilent_switch_cutout__bump+e)
      square([ringsilent_switch_cutout__height, ringsilent_switch_cutout__depth],center=true);
  }

  // volume up button
  color(iphone_11_pro__midnight_green_button)
    translate([-volume_up__bump,
               translate_y_from_top(volume_up__from_top),
               iphone_11_pro__z_mid]) {
    rotate([90,0,90])
      linear_extrude(volume_up__bump+e)
      square([volume_up__height, volume_up__depth],center=true);
  }

  // volume down button
  color(iphone_11_pro__midnight_green_button)
    translate([-volume_down__bump,
               translate_y_from_top(volume_down__from_top),
               iphone_11_pro__z_mid]) {
    rotate([90,0,90])
      linear_extrude(volume_down__bump+e)
      square([volume_down__height, volume_down__depth],center=true);
  }

  // side button
  color(iphone_11_pro__midnight_green_button)
    translate([iphone_11_pro__width-e,
               translate_y_from_top(side_button__from_top),
               iphone_11_pro__z_mid]) {
    rotate([90,0,90])
      linear_extrude(side_button__bump+e)
      square([side_button__height, side_button__depth],center=true);
  }

  // sim slot
  color(iphone_11_pro__midnight_green_button)
    translate([iphone_11_pro__width-e,
               translate_y_from_top(sim_slot__from_top),
               iphone_11_pro__z_mid]) {
    rotate([90,0,90])
      linear_extrude(sim_slot__bump+e)
      square([sim_slot__height, sim_slot__depth],center=true);
  }

  // mic1 holes
  for (i=steps(mic1_bottom__hole_1__from_left, 3, mic1_bottom__hole_3__from_left)) {
    echo (i);
    color("Black")
      translate([i, 0, iphone_11_pro__z_mid]) {
      rotate([0, 90, 90])
        linear_extrude(1+e)
        circle(d=grill_hole__diameter);
    }
  }

  // mic2 holes
  for (i=steps(mic2_bottom__hole_1__from_left, 6, mic2_bottom__hole_6__from_left)) {
    echo (i);
    color("Black")
      translate([i, 0, iphone_11_pro__z_mid]) {
      rotate([0, 90, 90])
        linear_extrude(1+e)
        circle(d=grill_hole__diameter);
    }
  }

  // bottom screw holes
  for (i=[screw_bottom_1__from_left, screw_bottom_2__from_left]) {
    color("Black")
      translate([i, 0, iphone_11_pro__z_mid]) {
      rotate([-90, 0, 0])
        linear_extrude(1+e)
        circle(d=screw_bottom__diameter);
    }
  }

  // lightning
  corner_r1 = 1.5;
  corner_r2 = 1.5;
  color("Black")
    translate([lightning_connector__from_left, 0, iphone_11_pro__z_mid]) {
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
    color("Red")
      translate([lightning_connector__from_left, 0, iphone_11_pro__z_mid]) {
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
  translate([iphone_11_pro__width, iphone_11_pro__height, 0])
    rotate([0, 180, 0])
    rear_camera();

  // front sensor bar module
  translate([0, iphone_11_pro__height, iphone_11_pro__depth])
    rotate([0, 0, 0])
    front_sensor_bar();


}

module shell(width, length, depth, corner_radius, edge_radius, shell_color = "Silver")
{
  face_corner_radius = corner_radius;

  // Try to parameterize the curves
  corner_r1 = face_corner_radius - 2;
  corner_r2 = face_corner_radius - 2 ;

  edge_curvature_radius = edge_radius;
  edge_offset = edge_curvature_radius;

  corner_sphere_r = face_corner_radius - (corner_radius - edge_radius)/8;


  round_rect_offset_factor = 0.40 * face_corner_radius;
  display_round_rect_offset_factor = 0.45 * face_corner_radius;
  display_inset_depth = 0.8;

  length_edge_extr_height = length - 2*face_corner_radius;
  width_edge_extr_height  = width  - 2*face_corner_radius ;
  corner_sphere_chop_height = 5;


  // generate the basic solid outline
  {
    color(shell_color, alpha = 0.82)
    difference() {

      // most of body
      hull($fn = 25)
        // DEBUG
        //% union($fn = 25)
      {

        // main rectangular region
        translate([round_rect_offset_factor,
                   round_rect_offset_factor,
                   0])
        {
          linear_extrude(height = depth, center = false, convexity = 10)
            complexRoundSquare([ width - 2*round_rect_offset_factor,
                                 length - 2*round_rect_offset_factor ],
                               [corner_r1, corner_r2],
                               [corner_r1, corner_r2],
                               [corner_r1, corner_r2],
                               [corner_r1, corner_r2],
                               center=false);
        }


        // lower left corner
        translate([face_corner_radius, face_corner_radius, depth/2])
        {
          intersection() {
            sphere(r = corner_sphere_r, $fn = 50);
            cube(size = [20, 20, corner_sphere_chop_height], center = true);
          }
        }

        // left length side
        translate([edge_curvature_radius, face_corner_radius, depth/2]) {

          rotate([-90,0,0])
            linear_extrude(height = length_edge_extr_height, center = false)
            projection(cut = true)
            sphere(r = edge_curvature_radius, $fn = 50) ;
        }

        // bottom width side
        translate([face_corner_radius, edge_curvature_radius, depth/2]) {
          rotate([0,90,0])
            linear_extrude(height = width_edge_extr_height, center = false)
            projection(cut = true)
            sphere(r = edge_curvature_radius, $fn = 50) ;
        }

        // upper left corner
        translate([face_corner_radius, length - face_corner_radius, depth/2])
        {
          intersection() {
            sphere(r = corner_sphere_r, $fn = 50);
            cube(size = [20, 20, corner_sphere_chop_height], center = true);
          }
        }

        // upper right corner
        translate([width - face_corner_radius, length - face_corner_radius, depth/2])
        {
          intersection() {
            sphere(r = corner_sphere_r, $fn = 50);
            cube(size = [20, 20, corner_sphere_chop_height], center = true);
          }
        }

        // right length side
        translate([width - edge_curvature_radius, length- face_corner_radius, depth/2]) {
          rotate([90,0,0])
            linear_extrude(height = length_edge_extr_height, center = false)
            projection(cut = true)
            sphere(r = edge_curvature_radius, $fn = 50) ;
        }

        // top width side
        translate([width - face_corner_radius, length- edge_curvature_radius, depth/2]) {
          rotate([0,-90,0])
            linear_extrude(height = width_edge_extr_height, center = false)
            projection(cut = true)
            sphere(r = edge_curvature_radius, $fn = 50) ;
        }

        // lower right corner
        translate([width - face_corner_radius, face_corner_radius, depth/2])
        {
          intersection() {
            sphere(r = corner_sphere_r, $fn = 50);
            cube(size = [20, 20, corner_sphere_chop_height], center = true);
          }
        }


      }
    }

    notch__centered_from_left_active = notch__from_left_active + display_round_rect_offset_factor/2 - 0.2;
    notch__centered_from_top_active = length - 2*display_round_rect_offset_factor - e;

    // display main rectangular region
    translate([display_round_rect_offset_factor,
               display_round_rect_offset_factor,
               depth - display_inset_depth]) {
      color ("#103080", alpha = 0.70)
        linear_extrude(height = display_inset_depth + e, center = false, convexity = 10)
        difference() {
        complexRoundSquare([ width  - 2*display_round_rect_offset_factor,
                             length - 2*display_round_rect_offset_factor ],
                           [corner_r1, corner_r2],
                           [corner_r1, corner_r2],
                           [corner_r1, corner_r2],
                           [corner_r1, corner_r2],
                           center=false);

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

module rear_camera (camera_lens_radius = 13.08/2) {

  h = rear_cam_turret_keepout__height_above ;

  // turret enclosure
  rradius_outer = rear_cam_turret__rradius_outer;
  rradius_inner = rear_cam_turret__rradius_inner;
  translate ([rear_cam_turret_center__from_left, -rear_cam_turret_center__from_top, -e])
    color(iphone_11_pro__midnight_green_turret, alpha = 0.70)
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


  // interior features
  translate ([rear_cam1_center__from_left, -rear_cam1_center__from_top, 0])
    rear_camera_lens(r = camera_lens_radius);

  translate ([rear_cam2_center__from_left, -rear_cam2_center__from_top, 0])
    rear_camera_lens(r = camera_lens_radius);

  translate ([rear_cam3_center__from_left, -rear_cam3_center__from_top, 0])
    rear_camera_lens(r = camera_lens_radius);

  translate ([rear_flash_center__from_left, -rear_flash_center__from_top, 0])
    color(alpha=0.30)
    linear_extrude(height = h/4)
    circle(d = rear_flash_center__diameter);

  translate ([rear_mic_center__from_left, -rear_mic_center__from_top, 0])
    color("Black")
    linear_extrude(height = h/4)
    circle(d = rear_mic_center__diameter);
}

module rear_camera_lens(r, h = rear_cam_turret_keepout__height_above) {
  color(iphone_11_pro__midnight_green_lens_bezel, alpha=0.95)
    linear_extrude(height=h/2)
    circle(r=r);

  color("Black", alpha=0.86)
    linear_extrude(height=h/2 + e)
    circle(r=r-0.9);

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
                       [speaker_top__curve_radius, speaker_top__curve_radius],
                       [speaker_top__curve_radius, speaker_top__curve_radius],
                       center=true);

  translate ([mic_top__from_left, -mic_top__from_top, -e])
    color("#101010")
    linear_extrude(height = 5*e)
    circle(r=mic_top__radius);

}



echo ("corner_radius: ", iphone_11_pro__face_corner_radius);
echo ("edge_radius: ", iphone_11_pro__edge_radius);

$fn = $preview ? 50 : 100;

iphone_11_pro(iphone_11_pro__width, iphone_11_pro__height, iphone_11_pro__depth,
              iphone_11_pro__face_corner_radius, iphone_11_pro__edge_radius,
              show_lightning_keepout = true);
