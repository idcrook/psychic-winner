///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2021-Oct-04
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//   Remix this sleeve to fit an Otterbox Commuter Series for iPhone 13 Pro
//
// Revisions/Notes:
//
//   2021-Oct-04 : Initial Case dimensions
//
//   2021-Oct-08 : Adjustments with case in hand
//
//
///////////////////////////////////////////////////////////////////////////////


use <MCAD/2Dshapes.scad>
use <../libraries/misc/wedge.scad>
use <../libraries/dotSCAD/src/rounded_square.scad>

// imports variables, modules with "include"
include <mockup/iPhone_13_Pro_Mockup.scad>

e = 1/128; // small number

// - [Protective iPhone 13 Pro Case | OtterBox Commuter Series Case](https://www.otterbox.com/en-us/iphone-13-pro/commuter-series-antimicrobial-case/commuter-iphp21.html)
//  6.03 x 3.12 x 0.56 in | 15.32 x 7.92 x 1.41 cm.
//  - Length 153.2 mm
//  - Width   79.2 mm
//  - Depth   14.1 mm

l = 153.2 ;  // measured?
w = 79.2 ; // including widest at buttons
h = 14.1 ;
l_use = l - 0.25; // measured
w_use = w - 1.2 ; // measured
h_use = h + (1*0.65);    // + padding

// https://developer.apple.com/accessories/Accessory-Design-Guidelines.pdf
// "Device Dimensional Drawings" § 44.3 iPhone 13 Pro 1 of 2
// Release R15, downloaded 2021-Oct-02
//  - Length: 146.71 mm
//  - Width:   71.54 mm
//  - Depth:    7.65 mm

il = iphone_13_pro__height;
iw = iphone_13_pro__width ;
ih = iphone_13_pro__depth ;
tol = 0.2;

// number of h half-s where iphone sets in case
icase_h_ratio = 5.1/4;

dw = w - iw;
dl = l - il;
dh = h - ih;

tw = (1/2) * dw  ;
tl = (1/2) * dl  ;
th = (1/2) * dh  ;

// front case cutout
case_front_lip = 1.0;
cut_w = active_display__width  + 2*active_display__inset_from_exterior - 2*case_front_lip;
cut_l = active_display__height + 2*active_display__inset_from_exterior - 2*case_front_lip;
cut_r = 6.95;

case_out_r = cut_r + 6;

// case display cutout
dcw = (w - cut_w) / 2;
dcl = (l - cut_l) / 2;

// case rear cam opening
case_rcam_w = 37.5;
case_rcam_l = 38.8;
case_rcam_r = 10;

// case lightning flap
case_flap_w = 12.5;
case_flap_l = h - 2.8;
case_flap_r = 0.7;
case_mid_w = w/2;

function translate_y_from_top (from_top)  = il - from_top;

// this is a
module otterboxCommuterCase () {
  difference() {
    // case outer dimensions
    shell(w, l, h, case_out_r, shell_color="#2a8", color_alpha=0.90,
          full_size_pass=false);

    translate ([dcw, dcl, th+0-tol])
      {
        // cut out iphone shape and extend up
        linear_extrude(height = 15, center = false, convexity = 10)
          rounded_square(size=[cut_w, cut_l], corner_r = cut_r, center=false);
        // cut out rear camera hole
        translate([iphone_13_pro__width, iphone_13_pro__height, 0])
          translate([-(17/16)*tw, -case_rcam_l-(5/4)*tl, 0])
          rotate([0, 180, 0])
          linear_extrude(height = 15, center = false, convexity = 10)
          rounded_square(size=[case_rcam_w, case_rcam_l], corner_r = case_rcam_r, center=false);
      }

    // cut out lightning flap
    translate([case_mid_w - case_flap_w/2, 0, -e]) {
      translate([0, dcl, 0])
        rotate([90, 0, 0])
        linear_extrude(height = 15, center = false, convexity = 10)
        complexRoundSquare([case_flap_w, case_flap_l],
                           [0, 0],
                           [0, 0],
                           [case_flap_r, case_flap_r],
                           [case_flap_r, case_flap_r],
                           center = false);

    }
  }
}


module lightningBackFlapOpening (flap_opening_height = 7, flap_opening_width = 17, thickness) {
  tolerance = 0.5;

  linear_extrude(height = flap_opening_height + 2*e, center = false)
    complexRoundSquare( [flap_opening_width, thickness],
                        [0.0, 0.0],
                        [0.0, 0.0],
                        [0.0, 0.0],
                        [0.0, 0.0],
                        center = false);
}

module sleeveForEncasediPhone (w, l, h, tweak_mount_surface, with_cap, with_sleeve) {

  tolerance = 0.5;
  // bike mount version requires cap but no lightning port access
  for_bike_mount = true;

  printer_has_shorter_volume_height = true;
  CONTROL_RENDER_cutoff_top       = true && printer_has_shorter_volume_height;

  //CONTROL_RENDER_bottom_front_no_bridge = for_bike_mount ? !true : true;
  CONTROL_RENDER_prototype_bottom_lightning_access = for_bike_mount ? !true : true;
  CONTROL_RENDER_prototype_bottom_back_flap =  for_bike_mount ? !true : true;
  CONTROL_RENDER_mute_switch_extra_access =  for_bike_mount ? !true : true;

  CONTROL_RENDER_experiment3      = ! true;
  CONTROL_RENDER_experiment4      = ! true;
  CONTROL_RENDER_experiment5      = ! true;
  CONTROL_RENDER_prototype_bottom = ! true;

  wantThinner =  true;
  wantThinnerCap = false;

  want_camera_hole_to_be_slot = true;

  sleeveSideThickness   =  wantThinner ? 2.88 : 3.5;
  sleeveBottomThickness =  wantThinner ? 2.88 : 3.5;
  sleeveTopThickness    =  wantThinner ? 2.88 : 3.5;
  sleeveBaseThickness   =  wantThinner ? 2.88 : 3.5;

  sleeveSideThickness__button_cutout = sleeveSideThickness + 0.8 + 2*tolerance;

  base_l = sleeveBaseThickness;

  //cutoff_top_length = !true ? 10 : 18;
  cutoff_top_length = true ? 10 : 32;
  trim_front_bars = (cutoff_top_length > 15) ? true : false;
  //trim_front_bars = false;

  sleeveInner_w =  tolerance + w + tolerance;
  sleeveInner_h =  tolerance + h + ( tolerance / 2 );
  sleeveInner_r = 3.1;
  sleeveInner_rear_r = sleeveInner_r + 1.0;

  buttonsIncludedInner_w =  tolerance + sleeveInner_w + tolerance + 1.0; // button groove depth
  buttonsIncludedInner_h =            +  4.0 + tolerance;
  buttonsIncludedInner_r =  1.5*tolerance ;
  sleeveOuter_w =  sleeveSideThickness + sleeveInner_w + sleeveSideThickness;
  sleeveOuter_h =  sleeveBottomThickness + sleeveInner_h + sleeveTopThickness;
  sleeveOuter_r = wantThinner ? 4.6 + 1.2 : 4.6 + 2.5;
  sleeve_base_taper_scale = 1/0.94;
  sleeve_base_start_w = sleeveOuter_w / sleeve_base_taper_scale;
  sleeve_base_start_h = sleeveOuter_h / sleeve_base_taper_scale;

  // iphoneDisplay_w = 48.5;
  iphoneDisplay_w = active_display__width;
  iphoneScreenBezel_w = active_display__inset_from_exterior;

  iphoneScreenOpening_w = iphoneScreenBezel_w + iphoneDisplay_w + iphoneScreenBezel_w;
  caseNonViewable = (1/2) * (sleeveOuter_w - iphoneScreenOpening_w );

  //
  //trim_for_lulzbot_mini_height = printer_has_shorter_volume_height ? 1 : 0;
  trim_for_lulzbot_mini_height = 0;
  sleeveInner_l = l - trim_for_lulzbot_mini_height ;

  sleeve_button__cutout_depth = 7.7 + 1.8;
  sleeve_button__y_scale_factor = 1.4 ;
  sleeve_button__y_translate_adjust = 1.85;

  volumeButtonsCutoutHeight = volume_up__half_height + volume_down__half_height +
    ( volume_down_center__from_top - volume_up_center__from_top) + 10 ;  // big enough to be continuous with mute switch
  volumeButtonsHeightFromBottom = translate_y_from_top(volume_down_center__from_top) - volume_down__half_height;

  volumeButtonsCutoutDepth = sleeve_button__cutout_depth;
  volumeButtonsCutoutRadius = 2;
  erase_sleeveInner_l_left  = volumeButtonsHeightFromBottom;

  add_mute_flap_cutout = CONTROL_RENDER_mute_switch_extra_access;
  muteSwitchCutoutHeight = 25.2 ; // extend so that switch is accessible with cap on
  muteSwitchHeightFromBottom = translate_y_from_top(ringsilent_switch_cutout_center__from_top) - ringsilent_switch_cutout__half_height;
  muteSwitchCutoutDepth = sleeve_button__cutout_depth;
  muteSwitchCutoutRadius = 2;

  shift_up_power_button = 0.0;
  powerButtonCutoutHeight = (side_button__half_height*2) + 10 + 10 + shift_up_power_button;
  powerButtonHeightFromBottom = translate_y_from_top(side_button_center__from_top) - side_button__half_height + shift_up_power_button;
  powerButtonCutoutDepth = sleeve_button__cutout_depth;
  powerButtonCutoutRadius = 2;
  erase_sleeveInner_l_right =   powerButtonHeightFromBottom;

  cameraHeightFromBottom = translate_y_from_top(rear_cam_plateau_center__from_top + rear_cam_plateau__height/2) - 1.0  ;
  cameraCutoutHeight = rear_cam_plateau__height + ((rear_cam_plateau__height - rear_cam_plateau__width)/2) ;
  cameraCutoutDepth = rear_cam_plateau__width + 2;
  cameraCutoutRadius =  rear_cam_plateau__rradius;
  cameraCutoutRadius_diag =  2;
  cameraHoleOffcenter = - 1.0;
  cameraHoleAddOffsetForCase_midline = 8.5 + 2.5; // add additonal safety margin for UW lens
  cameraHoleAddOffsetForCase_sideline = 0.0;

  speakerCutoutCenterBonus = 2.0;
  speakerCutoutHeight = 18 + speakerCutoutCenterBonus;
  speakerCutoutDepth = 6.6;
  speakerCutout_zDelta = (icase_h_ratio-1/1)*th;
  speakerCutoutRadius = speakerCutoutDepth/2;
  speakerHoleOffcenter = 8.0 - speakerCutoutCenterBonus;

  leftMicCutoutCenterBonus = 2.0;
  leftMicCutoutHeight = 12 + leftMicCutoutCenterBonus;
  leftMicCutoutDepth = speakerCutoutDepth;
  leftMicCutout_zDelta = (icase_h_ratio-1/1)*th;
  leftMicCutoutRadius = leftMicCutoutDepth/2;
  leftMicHoleOffcenter = 20.0;

  lightningCutoutHeight = lightning_connector_keepout__width + 3.35;
  lightningCutoutDepth = lightning_connector_keepout__height;
  lightningCutoutRadius = lightning_connector_keepout__radius;
  lightningFlapCutoutRadius = 0.74;
  lightningHoleOffcenter = 0;

  bottomLipHeight = 4.54; // matches height of case lip
  extra_overlap_screen_bottom = 0.5;
  bottom_lip_rounded_corners = true;

  fingerprint_sensor_cutout = true; // CONTROL_RENDER_bottom_front_no_bridge ;
  // re-appropriate for extra space for sliding up from bottom edge of phone
  // on-screen indicator for this is ~21.5 mm wide
  bottomLipOnScreenIndicator_w = 22.5;
  bottomLipCutout_MinWidth = bottomLipOnScreenIndicator_w;
  bottomLipCutout_Width = bottomLipCutout_MinWidth + 2*4.0;
  bottomLipCutout_h = bottomLipHeight + extra_overlap_screen_bottom;
  bottomLipCutout_scale = 1 + (bottomLipCutout_Width/bottomLipCutout_MinWidth - 1);

  // calculate how far we need to translate below to cut out enough
  bottomRearFlapCutoutHeight = 6.0 + 3.0; // measured on case, add fudge
  bottomRearFlapCutoutWidth = lightning_connector_keepout__width + 3.35; // measured on case, add fudge

  needed_overlap = 2.0;

  // trim based on experiments
  sleeveInner_trim__width  = (2/2)*tolerance ;  // 2*tolerance of 2*0.5 was added
  trim__height = (3/4)*tolerance;              // (3/2)*tolerance was added
  sleeveInner_trim__r_flatten = 2.8; //
  sleeveInner_trim__r_flatten_rear = sleeveInner_trim__r_flatten ; //

  echo ("sleeve height from bed (unchopped) = ", sleeveInner_l + sleeveBottomThickness);

  intersection() {
    union() {
      if (with_sleeve) {
        union () {

          // fill in groove for part of sleeve below buttons
          difference() {
            union () {
              erase_sleeveInner_left = erase_sleeveInner_l_left;
              erase_sleeveInner_right = erase_sleeveInner_l_right;

              // left side groove fill-in
              linear_extrude(height = erase_sleeveInner_left, center = false, convexity = 10)
                translate([-(1/2)*buttonsIncludedInner_w, -(1/2)*buttonsIncludedInner_h, 0])
                translate([0,-(1/4)*3.0])
                difference () {
                complexRoundSquare([(1/2)*(buttonsIncludedInner_w) + e,
                                    buttonsIncludedInner_h + e],
                                   [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                   [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                   [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                   [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                   center = false);

                // cut out size of iphone in case (plus tolerance)
                translate([ (1/2)*(buttonsIncludedInner_w - sleeveInner_w + tolerance),
                            -(1/2)*(ih + sleeveBottomThickness + tolerance), 25])
                  complexRoundSquare([(1/2)*(sleeveInner_w - sleeveInner_trim__width ) + needed_overlap ,
                                      sleeveInner_h],
                                     [sleeveInner_r , sleeveInner_r + sleeveInner_trim__r_flatten],
                                     [sleeveInner_r , sleeveInner_r + sleeveInner_trim__r_flatten],
                                     [sleeveInner_rear_r, sleeveInner_r + sleeveInner_trim__r_flatten_rear],
                                     [sleeveInner_rear_r, sleeveInner_r + sleeveInner_trim__r_flatten_rear],
                                     center = false);
              }

              // right side groove fill-in at bottom part below button cutouts
              linear_extrude(height = erase_sleeveInner_right, center = false, convexity = 10)
                translate([0, -(1/2)*buttonsIncludedInner_h, 0])
                translate([0,-(1/4)*3.0])
                difference () {
                complexRoundSquare([buttonsIncludedInner_w/2+e, buttonsIncludedInner_h+e],
                                   [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                   [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                   [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                   [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                   center = false);

                // cut out size of iphone in case (plus tolerance)
                translate([-needed_overlap,
                           -(1/2)*(ih + sleeveBottomThickness + tolerance), 25])
                  complexRoundSquare([ (1/2)*(sleeveInner_w - sleeveInner_trim__width) + needed_overlap,
                                       sleeveInner_h],
                                     [sleeveInner_r, sleeveInner_r + sleeveInner_trim__r_flatten],
                                     [sleeveInner_r, sleeveInner_r + sleeveInner_trim__r_flatten],
                                     [sleeveInner_rear_r, sleeveInner_r + sleeveInner_trim__r_flatten_rear],
                                     [sleeveInner_rear_r, sleeveInner_r + sleeveInner_trim__r_flatten_rear],
                                     center = false);
              }
            }
          }

          // MAIN EXTRUDE - 2D view for length of case
          difference () {
            // need a difference here to be able to "punch out" button and camera access holes
            linear_extrude(height = sleeveInner_l, center = false, convexity = 10)
              difference () {
              complexRoundSquare([sleeveOuter_w, sleeveOuter_h],
                                 [sleeveOuter_r, sleeveOuter_r],
                                 [sleeveOuter_r, sleeveOuter_r],
                                 [sleeveOuter_r, sleeveOuter_r],
                                 [sleeveOuter_r, sleeveOuter_r],
                                 center = true);

              // cut out size of iphone in case
              complexRoundSquare([sleeveInner_w - sleeveInner_trim__width,
                                  sleeveInner_h - trim__height],
                                 [sleeveInner_r, sleeveInner_r + sleeveInner_trim__r_flatten],
                                 [sleeveInner_r, sleeveInner_r + sleeveInner_trim__r_flatten],
                                 // the rear of case has more cutout of it
                                 [sleeveInner_rear_r, sleeveInner_r + sleeveInner_trim__r_flatten_rear ],
                                 [sleeveInner_rear_r, sleeveInner_r + sleeveInner_trim__r_flatten_rear],
                                 center = true);

              // include groove for buttons (covered back in above)
              translate([0,-(1/4)*3.0])
              complexRoundSquare([buttonsIncludedInner_w,  buttonsIncludedInner_h],
                                 [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                 [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                 [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                 [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                 center = true);

              bevel_angle = 46.5;

              // cut for screen and add bevel
              translate ([-iphoneScreenOpening_w/2, -sleeveInner_h ])
                square([iphoneScreenOpening_w, sleeveInner_h],  center = false);

              // front left side
              translate ([-(1/2)*(sleeveInner_w + 2*tolerance), -(sleeveInner_h + tolerance)  + sleeveTopThickness/2])
                rotate((360 - bevel_angle) * [0, 0, 1])
                square([caseNonViewable, sleeveInner_h],  center = false);

              // front right side
              translate ([1/2*(sleeveInner_w + 2*tolerance), -(sleeveInner_h + tolerance) + sleeveTopThickness/2])
                rotate((90 + bevel_angle) * [0, 0, 1])
                square([caseNonViewable, sleeveInner_h],  center = false);
            } // difference

            if (CONTROL_RENDER_prototype_bottom_back_flap) {
             translate([-(1/2)*(bottomRearFlapCutoutWidth + 1*tolerance) -e,
                         (1/2)*(sleeveInner_h) - tolerance - e,
                          -e])
                lightningBackFlapOpening(flap_opening_height = bottomRearFlapCutoutHeight,
                                         flap_opening_width = bottomRearFlapCutoutWidth,
                                         thickness = sleeveBottomThickness + 1*tolerance + 2*e);
            }

            // power button cutout
            translate([+1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (powerButtonCutoutDepth) - sleeve_button__y_translate_adjust, powerButtonHeightFromBottom])
              rotate([0, 180 + 90, 0])
              scale([1,sleeve_button__y_scale_factor,1])
              linear_extrude(height = sleeveSideThickness__button_cutout + 2*e, center = false, scale = 0.9, convexity = 10)
              complexRoundSquare( [powerButtonCutoutHeight, powerButtonCutoutDepth],
                                  [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                  [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                  [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                  [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                  center = false);

            // volume buttons cutout
            translate([-1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (volumeButtonsCutoutDepth) - sleeve_button__y_translate_adjust, volumeButtonsHeightFromBottom])
              mirror([1,0,0])
              rotate([0, 180 + 90, 0])
              scale([1,sleeve_button__y_scale_factor,1])
              // height is in the X direction
              linear_extrude(height = sleeveSideThickness__button_cutout + 2*e, center = false, scale = 0.90)
              complexRoundSquare( [volumeButtonsCutoutHeight, volumeButtonsCutoutDepth],
                                  [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                  [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                  [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                  [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                  center = false);

            // mute switch cutout
            mute_switch_expand_for_flap = add_mute_flap_cutout ? 5.0 : 0;
            mute_switch_addl_cutout     = add_mute_flap_cutout ? 6.2 + 0.5  : 0; // toward midline
            mute_switch__y_scale_factor = add_mute_flap_cutout ? 1.16*sleeve_button__y_scale_factor : 1.0*sleeve_button__y_scale_factor;
            /// echo(muteSwitchCutoutHeight, muteSwitchCutoutDepth, muteSwitchHeightFromBottom);
            translate([-1 * ((1/2) * sleeveOuter_w + e),
                       -(1/2) * (muteSwitchCutoutDepth) - sleeve_button__y_translate_adjust - (0/2)*mute_switch_expand_for_flap,
                       muteSwitchHeightFromBottom])
              mirror([1,0,0])
              rotate([0, 180 + 90, 0])
              scale([1,mute_switch__y_scale_factor,1])
              linear_extrude(height = sleeveSideThickness__button_cutout + mute_switch_addl_cutout + 2*e, center = false,  scale = 0.9, convexity = 10)
              complexRoundSquare( [muteSwitchCutoutHeight, muteSwitchCutoutDepth + mute_switch_expand_for_flap],
                                  [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                  [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                  [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                  [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                  center = false);

            // camera cutout
            extend_camera_opening = want_camera_hole_to_be_slot ? 0 : 3 ;

            // normal one
            translate([cameraHoleOffcenter - cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline ,
                       (1/2) * sleeveInner_h - 3*tolerance - e,
                       cameraHeightFromBottom])
              rotate([90, 0, 0])
              mirror([0,0,1])
              linear_extrude(height = sleeveBottomThickness + 3*tolerance +2*e, center = false, convexity = 10)
              complexRoundSquare( [cameraCutoutHeight + cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline, cameraCutoutDepth + extend_camera_opening],
                                  [cameraCutoutRadius, cameraCutoutRadius],
                                  [cameraCutoutRadius_diag, cameraCutoutRadius_diag],
                                  [cameraCutoutRadius, cameraCutoutRadius],
                                  [cameraCutoutRadius, cameraCutoutRadius],
                                  center = false);

            // TODO: REFACTOR to avoid code duplication (copy-and-pasted from above)
            if (want_camera_hole_to_be_slot) {
              // shift up camera cutout past top to make it a slot
              shiftUpAmount = 12 - 4;
              translate([cameraHoleOffcenter - cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline ,
                         (1/2) * sleeveInner_h - 3*tolerance - e,
                         cameraHeightFromBottom + shiftUpAmount])
                rotate([90, 0, 0])
                mirror([0,0,1])
                linear_extrude(height = sleeveBottomThickness + 3*tolerance +2*e, center = false, convexity = 10)
                complexRoundSquare( [cameraCutoutHeight + cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline,  cameraCutoutDepth + 6],
                                    [cameraCutoutRadius, cameraCutoutRadius],
                                    [cameraCutoutRadius, cameraCutoutRadius],
                                    [cameraCutoutRadius, cameraCutoutRadius],
                                    [cameraCutoutRadius, cameraCutoutRadius],
                                    center = false);
            }

            if (CONTROL_RENDER_cutoff_top) { // chop off some amount of sleeve top
              cutHeight  = CONTROL_RENDER_experiment3 ? 5 : l - cutoff_top_length ;
              extrHeight = CONTROL_RENDER_experiment3 ? 200 :  cutoff_top_length + e  ;

              echo("cutHeight:", cutHeight);
              translate([0,0, cutHeight])
                linear_extrude(height = extrHeight, center = false, convexity = 10)
                complexRoundSquare([sleeveOuter_w+e, sleeveOuter_h+e],
                                   [0,0], [0,0], [0,0], [0,0],
                                   center = true);

              if (trim_front_bars) {
                translate([-(1/2)*sleeveOuter_w, - (1/2)*sleeveOuter_h, volumeButtonsHeightFromBottom])
                  linear_extrude(height = extrHeight + 10, center = false, convexity = 10)
                  complexRoundSquare([sleeveOuter_w+e, sleeveOuter_h+e],
                                     [0,0], [0,0], [0,0], [0,0],
                                     center = true);

                translate([(1/2)*sleeveOuter_w, - (1/2)*sleeveOuter_h, powerButtonHeightFromBottom])
                  linear_extrude(height = extrHeight + 10, center = false, convexity = 10)
                  complexRoundSquare([sleeveOuter_w+e, sleeveOuter_h+e],
                                     [0,0], [0,0], [0,0], [0,0],
                                     center = true);
              }



            }
            else
            {
              if (CONTROL_RENDER_experiment5) {
                cutHeight  = l - 10.0 ;
                extrHeight = l;
                echo("cutHeight:", cutHeight);
                translate([0,0, cutHeight])
                  rotate([180,0,0])
                  linear_extrude(height = extrHeight, center = false, convexity = 10)
                  complexRoundSquare([sleeveOuter_w+e, sleeveOuter_h+e],
                                     [0,0], [0,0], [0,0], [0,0],
                                     center = true);

              }
            }
          }
        }
      }

      // cap
      if (with_cap) {
        capArmThickness = wantThinnerCap ? 3.5 : 4.0;
        capCapThickness = wantThinnerCap ? 3.0 : 3.5;
        capDepth = sleeveOuter_h;
        caseHeight = sleeveInner_l + 0.56 ; //
        capCaseWidth = sleeveOuter_w + tolerance; //
        powerSideCut = powerButtonHeightFromBottom;
        powerSideHeight = powerButtonCutoutHeight;
        powerButtonCapClip_z = caseHeight - powerSideCut - powerSideHeight;

        muteSideCut = muteSwitchHeightFromBottom;
        muteSideHeight = muteSwitchCutoutHeight;
        muteSwitchCapClip_z = caseHeight - muteSideCut - muteSideHeight;

        echo("capDepth:",  capDepth );
        echo("caseHeight:", caseHeight);
        echo("capCaseWidth:", capCaseWidth);
        echo("powerButtonCapClip_z:", powerButtonCapClip_z);
        echo("muteSwitchCapClip_z:", muteSwitchCapClip_z);

        translate([0, -1.5, caseHeight])
          generateCap(capArmThickness, capCapThickness, capDepth, capCaseWidth,
                      powerButtonCapClip_z, muteSwitchCapClip_z);
      }


      // flat/bottom part of base of sleeve
      if (with_sleeve) {
        translate([0,0,e]) // to ensure overlap with main extrude (may not be needed?)
        difference() {
          translate([0,0, -base_l])
            linear_extrude(height = base_l , center = false, convexity = 10,
                           scale = sleeve_base_taper_scale)
            // 2D view for base of sleeve
            complexRoundSquare([sleeve_base_start_w, sleeve_base_start_h],
                               [sleeveOuter_r, sleeveOuter_r],
                               [sleeveOuter_r, sleeveOuter_r],
                               [sleeveOuter_r, sleeveOuter_r],
                               [sleeveOuter_r, sleeveOuter_r],
                               center = true);
          // handle speaker and mic, lightning, lightning access
          union () {
            // speaker + mic holes
            rotate([180,0,0])

              translate([-tolerance + speakerHoleOffcenter, -(1/2)*speakerCutoutDepth + speakerCutout_zDelta, -e])
              linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
              complexRoundSquare( [speakerCutoutHeight, speakerCutoutDepth + 4*e],
                                  [0,0],
                                  [speakerCutoutRadius, speakerCutoutRadius],
                                  [speakerCutoutRadius, speakerCutoutRadius],
                                  [0,0],
                                  center = false);
            // Mic holes
            rotate([180,0,0]) {
              translate([-tolerance - leftMicHoleOffcenter , -(1/2)*leftMicCutoutDepth + leftMicCutout_zDelta, -e])
                linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
                complexRoundSquare( [leftMicCutoutHeight, leftMicCutoutDepth],
                                    [leftMicCutoutRadius, leftMicCutoutRadius],
                                    [0,0],
                                    [0,0],
                                    [leftMicCutoutRadius, leftMicCutoutRadius],
                                    center = false);
            }

            // lightning access and case flap handling
            extend_out_flap_space = true ? 7 : 2;
            if (CONTROL_RENDER_prototype_bottom_lightning_access) {
              rotate([180,0,0])
                translate([-tolerance/2, 0, -e])
                linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
                union () {
                // main stretch strip on bottom
                complexRoundSquare( [lightningCutoutHeight, lightningCutoutDepth + 8.0 + tolerance],
                                    [lightningFlapCutoutRadius, lightningFlapCutoutRadius],
                                    [lightningFlapCutoutRadius, lightningFlapCutoutRadius],
                                    [lightningFlapCutoutRadius, lightningFlapCutoutRadius],
                                    [lightningFlapCutoutRadius, lightningFlapCutoutRadius],
                                    center = true);
                // extend up so flap has a place to go when inserting lightning connector
                translate([0, extend_out_flap_space, 0])
                  complexRoundSquare( [lightningCutoutHeight , lightningCutoutDepth + 7.6 + 3*tolerance],
                                      [lightningFlapCutoutRadius, lightningFlapCutoutRadius],
                                      [lightningFlapCutoutRadius, lightningFlapCutoutRadius],
                                      [lightningFlapCutoutRadius, lightningFlapCutoutRadius],
                                      [lightningFlapCutoutRadius, lightningFlapCutoutRadius],
                                      center = true);
                // cutout at rear of base, aligns with back flap cutout
                if (CONTROL_RENDER_prototype_bottom_back_flap) {
                  translate([0, -(1/2)*(sleeveInner_h + sleeveBottomThickness), 0])
                    complexRoundSquare( [bottomRearFlapCutoutWidth, sleeveBottomThickness + 3.0 + 3*tolerance],
                                        [0.5, 0.5],
                                        [0.5, 0.5],
                                        [3.5, 2.5],
                                        [3.5, 2.5],
                                        center = true);
                }
              }
            }
          }
        }
      }

      //
      bottom_lip_rounded_corners__radius = 7.5 ;
      extraBottomLipHeight = bottom_lip_rounded_corners ? 10 : 0;
      bottomLipDisplayOpeningWidth = w - 11.2 + 2*3.0; // added width
      bottomLipDisplayOpeningHeight = 22;

      // Bottom lip, including front band and back band
      if (with_sleeve) {
        difference() {
          // 2D view for height of lip
          linear_extrude(height = bottomLipHeight + extraBottomLipHeight, center = false, convexity = 10)
            difference () {
            rounded_square(size=[sleeveOuter_w, sleeveOuter_h], corner_r = sleeveOuter_r, center=true);

            // by bottom screen edge, front bottom lip, cut out size of iphone
            scale ([1,1,1])
              complexRoundSquare([sleeveInner_w, sleeveInner_h],
                                 [sleeveInner_r, sleeveInner_r],
                                 [sleeveInner_r, sleeveInner_r],
                                 [sleeveInner_rear_r, sleeveInner_r + sleeveInner_trim__r_flatten_rear],
                                 [sleeveInner_rear_r, sleeveInner_r + sleeveInner_trim__r_flatten_rear],
                                 center = true);

          }

          if (CONTROL_RENDER_prototype_bottom_back_flap) {
            translate([-(1/2)*(bottomRearFlapCutoutWidth + 1*tolerance)-e ,
                       (1/2)*(sleeveInner_h) - tolerance - e, -e])
              lightningBackFlapOpening(flap_opening_height = bottomRearFlapCutoutHeight,
                                       flap_opening_width = bottomRearFlapCutoutWidth,
                                       thickness = sleeveBottomThickness + 1*tolerance + 2*e);
          }

          if (CONTROL_RENDER_cutoff_top) {
            cutHeight  = CONTROL_RENDER_experiment3 ? 5 : l - cutoff_top_length ;
            extrHeight = CONTROL_RENDER_experiment3 ? 200 : cutoff_top_length + e ;

            echo("cutHeight:", cutHeight);
            translate([0,0, cutHeight])
              linear_extrude(height = extrHeight, center = false, convexity = 10)
              complexRoundSquare([sleeveOuter_w+e, sleeveOuter_h+e],
                                 [0,0],
                                 [0,0],
                                 [0,0],
                                 [0,0],
                                 center = true);
          }

          // previously cutout for fingerprint -
          // appropriated for space for sliding up from bottom edge of display
          if (fingerprint_sensor_cutout) {
            echo ("Width of face bottom lip cutout: ", bottomLipCutout_MinWidth);
            translate([-e, -(sleeveOuter_h/2)-e, 0])
              linear_extrude(height = bottomLipCutout_h + 2*e, center = false, convexity = 10, scale=bottomLipCutout_scale) {
              mirror([1,0,0])
              square([bottomLipCutout_MinWidth/2, sleeveSideThickness + 2*e], center=false);
              square([bottomLipCutout_MinWidth/2, sleeveSideThickness + 2*e], center=false);
            }
          }

          // rounded bottom corners for finger access to screen area
          if (bottom_lip_rounded_corners) {
           translate([0, 0, bottomLipHeight + bottomLipDisplayOpeningHeight/2 + extra_overlap_screen_bottom])
              rotate([90, 0, 0])
              linear_extrude(height = 10 + 5, center = false, convexity = 10)
              complexRoundSquare([bottomLipDisplayOpeningWidth, bottomLipDisplayOpeningHeight],
                                 [bottom_lip_rounded_corners__radius, bottom_lip_rounded_corners__radius],
                                 [bottom_lip_rounded_corners__radius, bottom_lip_rounded_corners__radius],
                                 [bottom_lip_rounded_corners__radius, bottom_lip_rounded_corners__radius],
                                 [bottom_lip_rounded_corners__radius, bottom_lip_rounded_corners__radius],
                                 center = true);
          }
        } // difference

      }


      // mounting wedge on back
      if (with_sleeve) {
        // add mounting wedge
        mountInsertWidth = 22;
        mountInsertThickness = 3;
        mountInsertHeight = 42;

        // y dimension needs to overlap with sleeve
        mountInsert_yTranslation = (1/2)*(tolerance + h) + sleeveBottomThickness - e;

        // y dimension needs to overlap with sleeve
        translate([-mountInsertWidth/2, mountInsert_yTranslation, (0.65) * l - mountInsertHeight + base_l])
          difference() {
          sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, tweak_mount_surface);

          // chop off top 1.5 mm of insert (as it seems to not fully insert into slot)
          translate([-e, -e, mountInsertHeight - 1.5])
            cube([mountInsertWidth + 2*e, mountInsertThickness*2 + 2*e, 6]);
        }
      }
    }

    if ((CONTROL_RENDER_cutoff_top && CONTROL_RENDER_experiment4) || CONTROL_RENDER_experiment5) {
      keepHeight = 45 + 10;
      cutHeight  = l + cutoff_top_length ;
      extrHeight = keepHeight ;

      translate([0,0, cutHeight - keepHeight])
        linear_extrude(height = extrHeight, center = false, convexity = 10)
        complexRoundSquare([sleeveOuter_w+10+e, sleeveOuter_h+10+e],
                           [0,0],
                           [0,0],
                           [0,0],
                           [0,0],
                           center = true);
    }

    if (CONTROL_RENDER_prototype_bottom) {
      keepHeight = 55;
      cutHeight  = 25;
      extrHeight = keepHeight ;

      // only keep the bottom section here
      translate([0,0, cutHeight - keepHeight])
        linear_extrude(height = extrHeight, center = false, convexity = 10)
        complexRoundSquare([sleeveOuter_w+10+e, sleeveOuter_h+10+e],
                           [0,0],
                           [0,0],
                           [0,0],
                           [0,0],
                           center = true);
    }


  } // main intersection
}


module generateCap(cap_arm_thickness, cap_thickness, cap_depth, cap_case_width,
                   power_button_z, mute_switch_z) {

  tolerance = 0.5;

  capCaseWidth = cap_case_width;
  capCapThickness = cap_thickness;
  capArmThickness = cap_arm_thickness;
  capDepth = cap_depth;
  capCornerSupportThickness = 2.5; //
  capCornerSupportWidth = 9.0;  //
  capCornerSupportHeight = 5.0;  //

  with_split_top_of_sleeve = !false ? true : false;
  with_tab_corner_support =  true ? true : false;

  fudge =  true ? true : false;
  powerButtonCapClip_z = fudge ? power_button_z + 1 : power_button_z;
  muteSwitchCapClip_z  = fudge ? mute_switch_z  + 1 : mute_switch_z;

  tabInsertDepth = 2.5 + 1 + 0.2 + 1; //

  sleeve_button__y_translate_adjust = 1.85;

  powerButtonCap_tabHeight = 15.2;
  powerButtonCap_tabWidth = 10 - tolerance;
  muteSwitchCap_tabHeight = 15.2;
  muteSwitchCap_tabWidth = 10 - tolerance;

  //capSideDistance = (capCaseWidth + capArmThickness)/2 + sleeve_button__y_translate_adjust;
  capSideDistance = (capCaseWidth + capArmThickness)/2;

  caseOverlap = 10.0;

  // main bar across tab
  linear_extrude(height = capCapThickness + e, center = false, convexity = 10)
    // 2D view for cap (base of cap)
    complexRoundSquare([capCaseWidth + 2*capArmThickness, capDepth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  // power button side - length to tab
  translate([capSideDistance, 0, - powerButtonCapClip_z])
    linear_extrude(height = powerButtonCapClip_z, center = false, convexity = 10)
    complexRoundSquare([capArmThickness, capDepth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  // power button side - inner spacer
  if (with_split_top_of_sleeve) {
    translate([capSideDistance - (capArmThickness - 1), 0, - caseOverlap + e])
      linear_extrude(height = caseOverlap, center = false, convexity = 10)
      complexRoundSquare([capArmThickness, capDepth],
                         [0,0], [0,0], [0,0], [0,0],
                         center = true);
  }

  // power button side - tab itself
  echo("=== generateCapTab : power switch side ===");
  translate([capSideDistance, 0,  - powerButtonCapClip_z - powerButtonCap_tabHeight])
    rotate([0,0,180])
    generateCapTab(capArmThickness, capDepth,
                   powerButtonCap_tabHeight, powerButtonCap_tabWidth, tabInsertDepth, direction = true);


  // power button side - corner reinforcement
  if (with_tab_corner_support) {
    translate([capSideDistance, ((1/2)*capDepth) - e, - (1/2)*capCornerSupportHeight])
      mirror([1,0,0])

      linear_extrude(height = capCornerSupportHeight, center = false, convexity = 10)
      complexRoundSquare([capCornerSupportWidth, capCornerSupportThickness],
                         [0,0],
                         [0,0],
                         [1.5,1.5],
                         [1.5,1.5],
                         center = false);
  }


  // mute switch side

  // mute switch side - length to tab
  translate([-(capSideDistance), 0,  - muteSwitchCapClip_z])
    linear_extrude(height = muteSwitchCapClip_z, center = false, convexity = 10)
    complexRoundSquare([capArmThickness, capDepth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  // mute switch side - inner spacer
  if (with_split_top_of_sleeve) {
    translate([-(capSideDistance - (capArmThickness - 1)), 0, - caseOverlap + e])
      linear_extrude(height = caseOverlap, center = false, convexity = 10)
      complexRoundSquare([capArmThickness, capDepth],
                         [0,0], [0,0], [0,0], [0,0],
                         center = true);
  }

  // mute switch side - tab for cutout
  echo("=== generateCapTab : mute switch side ===");
  translate([-(capSideDistance), 0, - muteSwitchCapClip_z - muteSwitchCap_tabHeight])
    rotate([0,0,0])
    generateCapTab(capArmThickness, capDepth,
                   muteSwitchCap_tabHeight, muteSwitchCap_tabWidth, tabInsertDepth, direction = false);

  // mute switch side - corner reinforcement
  if (with_tab_corner_support) {
    translate([-(capSideDistance - 0), (1/2)*capDepth  - e, - (1/2)*capCornerSupportHeight])
      mirror([0,0,0])
      linear_extrude(height = capCornerSupportHeight, center = false, convexity = 10)
      complexRoundSquare([capCornerSupportWidth, capCornerSupportThickness],
                         [0,0],
                         [0,0],
                         [1.5,1.5],
                         [1.5,1.5],
                         center = false);
  }


}


module generateCapTab(cap_arm_thickness, cap_case_width, tab_height, tab_width, tab_insert_depth , direction) {

  capCaseWidth = cap_case_width;
  capArmThickness = cap_arm_thickness;
  tabHeight = tab_height;
  tabWidth = tab_width;
  tabInsertDepth = tab_insert_depth;

  y_shift_amount = 1.8;
  cap_tab_y_shift = direction ? - y_shift_amount : y_shift_amount;
  //   sleeve_button__y_scale_factor = 1.4 ;
  cap_tab_y_scale = 1.4;

  if (true) {
    echo("capCaseWidth:", capCaseWidth, "capArmThickness:", capArmThickness, "tabHeight:", tabHeight, "tabWidth:", tabWidth, "tabInsertDepth:", tabInsertDepth);
  }

  // straight piece along back
  translate([0,0,+2*e])
    linear_extrude(height = tabHeight, center = false, convexity = 10)
    complexRoundSquare([capArmThickness, tabWidth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  // tab piece
  translate([(1/2)*capArmThickness - e, cap_tab_y_shift ,(1/2)*tabHeight])
    rotate([0,90,0])
    // greater than scale [,] x =~ 0.50 generally will imply supports to print
    scale([1,cap_tab_y_scale,1])
    linear_extrude(height = tabInsertDepth, scale = [0.68, 0.70],  twist=0, center = false)
    complexRoundSquare([tabHeight, tabWidth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  // tapered pieces on side of straight piece
  translate([0,0,tabHeight + 2*e])
    rotate([0,180,0])
    linear_extrude(height = (3/4)*tabHeight,  //
                   center = false, scale = [0.9, 0.55], convexity = 10)
    complexRoundSquare([capArmThickness, capCaseWidth],
                       [1,1], [1,1], [1,1], [1,1],
                       center = true);



}

module sleeveMountInsert (width, thickness, height, shouldTweak) {

  insertTailWidth = width;
  insertThickness = 2*thickness;
  insertChopThickness = thickness;
  insertFullHeight = height;

  insertPartialHeight = 30;
  insertSlantedHeight = insertFullHeight - insertPartialHeight;
  insertSlantAngle = 60;
  insertSlantAngle2 = 70;

  tolerance = 0.5;

  insertChopThickness_x = shouldTweak ? insertChopThickness + tolerance : insertChopThickness;
  insertChopThickness_y = shouldTweak ? insertChopThickness + tolerance : insertChopThickness;

  rotateAngle = 15;

  echo("insertChopThickness_x:", insertChopThickness_x);
  echo("insertChopThickness_y:", insertChopThickness_y);

  difference() {
    intersection () {
      linear_extrude(height = insertFullHeight, center = false, convexity = 10)
        difference() {
        complexRoundSquare([insertTailWidth, insertThickness],
                           [0,0], [0,0], [0,0], [0,0],
                           center = false);

        // vertical side nearest attach surface
        translate([-e, -e, 0])
          complexRoundSquare([insertChopThickness_x, insertChopThickness_y],
                             [0,0], [0,0], [0,0], [0,0],
                             center = false);

        // other vertical side nearest attach surface
        translate([insertTailWidth - insertChopThickness_x + e, -e, 0])
          complexRoundSquare([insertChopThickness_x, insertChopThickness_y],
                             [0,0], [0,0], [0,0], [0,0],
                             center = false);

        // this carves a small slant on the side rails
        if (shouldTweak) {

          translate([insertChopThickness_x, insertChopThickness_y*(1),0])
            rotate([0,0,180-rotateAngle])
            complexRoundSquare([insertChopThickness_x+1, insertChopThickness_y],
                               [0,0], [0,0], [0,0], [0,0],
                               center = false);

          translate([insertTailWidth - insertChopThickness_x + e, -e, 0])
            translate([0, insertChopThickness_y*(1),0])
            rotate([0,0,270+rotateAngle])
            complexRoundSquare([insertChopThickness_x, insertChopThickness_y+1],
                               [0,0], [0,0], [0,0], [0,0],
                               center = false);
        }
      }

      // carve bottom side insert wedge
      rotate([insertSlantAngle,0,0])
        cube(insertFullHeight);
    }

    translate([insertChopThickness,
               insertChopThickness - 2*e,
               (1/2) * insertSlantedHeight * sin (insertSlantAngle) - e])
      rotate([360-(90-insertSlantAngle2),0,90])
      cube(7+3);

    translate([insertTailWidth - insertChopThickness,
               insertChopThickness - 2*e,
               (1/2) * insertSlantedHeight * sin (insertSlantAngle) - e])
      rotate([0, (90 - insertSlantAngle2) ,0])
      cube(7+3);
  }

}


module test_sleeveMountInsert (fit_better, translate_x) {
  mountInsertWidth = 22;
  mountInsertThickness = 3;
  mountInsertHeight = 42;

  fitBetter = fit_better;

  tolerance = 0.5;
  wantThinner = true ;
  sleeveBottomThickness =  wantThinner ? 2.8 : 3.5;


  mountInsert_yTranslation = (1/2)*(tolerance + h) + sleeveBottomThickness;

  translate([translate_x, 0, 0])
    sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, fitBetter);
}

module test_generateCap() {
  capArmThickness = 4;
  capCapThickness = 3.5;
  capDepth = 17.5; // sleeveOuter_h;
  caseHeight = 161.9; // sleeveInner_l;
  capCaseWidth = 88.5; // sleeveOuter_w;

  powerButtonCapClip_z = 30.0; // caseHeight - powerSideCut - powerSideHeight;
  muteSwitchCapClip_z = 14.0; // caseHeight - muteSideCut - muteSideHeight;

  translate([100, 0, capCapThickness])
    rotate([180,0,0])
    generateCap(capArmThickness, capCapThickness, capDepth, capCaseWidth,
                powerButtonCapClip_z, muteSwitchCapClip_z);
}

module test_generateCapTab(cap_arm_thickness, cap_case_width, tab_height, tab_width, tab_insert_depth ) {
  generateCapTab(cap_arm_thickness, cap_case_width, tab_height, tab_width, tab_insert_depth);
}



module showTogether() {

  tweakMountSurface = true;
  withCap = true;
  withSleeve = true;

  show_with_phone_and_case = true;

  if (show_with_phone_and_case) {
    // iPhone 11 Pro
    translate([tw, tl, (icase_h_ratio)*th ]) // use this ratio since case back is thicker than front inset
      iphone_13_pro(iw, il, ih, show_keepouts = true);
    // case model
    translate([0,0,0]) otterboxCommuterCase();
  }

  // sleeve mount design
  translate([w/2,0,h/2]) rotate([360-90,0,0]) sleeveForEncasediPhone(w, l, h,  tweakMountSurface, withCap, withSleeve );
}

show_everything = !true;

if (show_everything) {
  showTogether();
} else {
  // $preview requires version 2019.05
  fn = $preview ? 30 : 100;

  tweakMountSurface =  true;

  withSleeve =  true;

  printCap   =  !true;
  withCap    =  printCap;
  //withCap    =  true;

  if (! printCap) {
    translate([0,0,0])
      sleeveForEncasediPhone(w, l, h, tweakMountSurface, withCap, withSleeve);
  } else {
    scale ([1.0,1.0,1.0])
      translate([0,0,3+l+0.5])
      rotate([180,0,0])
      sleeveForEncasediPhone(w, l, h, tweakMountSurface, true, ! withSleeve);
  }

  // *test_sleeveMountInsert(tweakMountSurface, 0);
}
