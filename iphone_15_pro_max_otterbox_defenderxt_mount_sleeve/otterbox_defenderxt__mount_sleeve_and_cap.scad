///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2023-Sep-19
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//   Remix this sleeve to fit an Otterbox Defender XT Series for iPhone 15 Pro Max
//
// Model Repositories
//
//   -	[Modular mount system Sleeve for iPhone 15 Pro Max with case - Otterbox Commuter](https://www.thingiverse.com/thing:5019596)
//
//   -	https://www.
//
// Revisions/Notes:
//
//   2023-Sep-19 : Initial Case dimensions
//
//
//
///////////////////////////////////////////////////////////////////////////////


use <../libraries/MCAD/2Dshapes.scad>
use <../libraries/local-misc/wedge.scad>
use <../libraries/dotSCAD/src/rounded_square.scad>

// with "include", imports variable, module definitions to this file
include <mockup/iPhone_15_Pro_Max_Mockup.scad>

e = 1/128; // small number

// displays mockupo of phone + case + sleeve + cap
show_everything = true;

// print sleeve setup (unset to print cap)
printSleeve = true;
printCap   =  !printSleeve;

// bike mount version requires cap (but no USB-C port access)
for_bike_mount = !true;


// - [Black Clear MagSafe iPhone 15 Pro Max case | Defender Series XT Clear](https://www.otterbox.com/en-us/magsafe-iphone-15-pro-max-case-black/77-93312.html)
//  6.76 x 3.52 x 0.57 in / 171.65 x 89.38 x 14.52 mm

//  Height 171.65 mm
l = 171.65 ;  // measured?

// Width   89.38 mm
w = 89.38 ; // including widest at buttons

//  Depth   14.52 mm
h = 14.52 ;


// Height to use for sleeve // l - 0.25;
l_use = 171.40;

// Width to use for sleeve  // (w - 0.9) + 0.3 // measured at holster tabs + padding
w_use = 88.78;

// Width to use for sleeve  //  h - 2.0 + 0.35 //  12.5mm not incl. camera bump + padding
h_use = 12.87;

// https://developer.apple.com/accessories/Accessory-Design-Guidelines.pdf
// "Device Dimensional Drawings" § 56.1 iPhone 15 Pro Max 1 of 3
// Release 21, downloaded 2023-Oct-31
// -	Height: 6.29 inches (159.9 mm)
// -	Width: 3.02 inches (76.7 mm)
// -	Depth: 0.32 inch (8.25 mm)

il = iphone_15_pro_max__height;
iw = iphone_15_pro_max__width ;
ih = iphone_15_pro_max__depth ;
tol = 0.3;

module __Customizer_Limit__ () {}

// number of h half-s where iphone sets in case
icase_h_ratio = 5.1/4;

dw = w - iw;
dl = l - il;
dh = h - ih;

tw = (1/2) * dw  ;
tl = (1/2) * dl  ;
th = (1/2) * dh  ;

// front case cutout
case_front_lip = 2.0;
cut_w = active_display__width  + 2*active_display__inset_from_exterior - 2*case_front_lip;
cut_l = active_display__height + 2*active_display__inset_from_exterior - 2*case_front_lip;
cut_r = 6.95;

case_out_r = cut_r + 6;

// case display cutout
dcw = (w - cut_w) / 2;
dcl = (l - cut_l) / 2;

// case rear cam opening
case_rcam_w = 40.0;
case_rcam_l = 41.0;
case_rcam_r = 10;

// case USB-C flap
case_flap_w = 13.7;
case_flap_l = h - 2.8;
case_flap_r = 0.7;
case_mid_w = w/2;

function translate_y_from_top (from_top)  = il - from_top;

// this is a
module otterboxDefenderCase () {
  difference() {
    // case outer dimensions
    shell(w, l, h, case_out_r, shell_color="#99a", color_alpha=0.20,
          full_size_pass=false);
    translate ([dcw, dcl, th+0-tol])
      {
        // cut out iphone shape and extend up
        linear_extrude(height = 15, center = false, convexity = 10)
          rounded_square(size=[cut_w, cut_l], corner_r = cut_r, center=false);
        // cut out rear camera hole
        translate([iphone_15_pro_max__width, iphone_15_pro_max__height, 0])
          translate([-(10/16)*tw, -case_rcam_l-(12/16)*tl, 0])
          rotate([0, 180, 0])
          linear_extrude(height = 15, center = false, convexity = 10)
          rounded_square(size=[case_rcam_w, case_rcam_l], corner_r = case_rcam_r, center=false);
      }
    // cut out USB-C flap
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


module usbcBackFlapOpening (flap_opening_height = 7, flap_opening_width = 17, thickness) {
  linear_extrude(height = flap_opening_height + 2*e, center = false)
    complexRoundSquare( [flap_opening_width, thickness],
                        [0.0, 0.0],
                        [0.0, 0.0],
                        [0.0, 0.0],
                        [0.0, 0.0],
                        center = false);
}

module sleeveInnerProfile(w, trim_w, extra_w=0, h, r, r_rear, trim_r, trim_r_rear, center=false) {
  complexRoundSquare([ (2/2)*(w - trim_w) + extra_w, h],
                     [r, r + trim_r],
                     [r, r + trim_r],
                     [r_rear, r + trim_r_rear],
                     [r_rear, r + trim_r_rear],
                     center = center);
}

module sleeveForEncasediPhone (w, l, h, tweak_mount_surface, with_cap, with_sleeve) {

  tolerance = 0.3;

  printer_has_shorter_volume_height = true;
  CONTROL_RENDER_cutoff_top       = true && printer_has_shorter_volume_height;

  CONTROL_RENDER_mute_switch_extra_access = !for_bike_mount ? true : false;
  CONTROL_RENDER_bottom_usbc_access  = !for_bike_mount ? true : false;
  CONTROL_RENDER_bottom_back_flap         = CONTROL_RENDER_bottom_usbc_access;

  CONTROL_RENDER_experiment3      = false;
  CONTROL_RENDER_experiment5      = false;
  CONTROL_RENDER_prototype_bottom = false;

  wantThinner =  true;
  wantThinnerCap = false;

  want_camera_hole_to_be_slot = true;
  CONTROL_RENDER_chop_side_button_side = CONTROL_RENDER_cutoff_top ;

  sleeveSideThickness   =  wantThinner ? 2.88 : 3.5;
  sleeveBottomThickness =  wantThinner ? 2.88 : 3.5;
  sleeveTopThickness    =  wantThinner ? 2.88 : 3.5;
  sleeveBaseThickness   =  wantThinner ? 2.88 : 3.5;

  sleeveSideThickness__button_cutout = sleeveSideThickness + (1/2)*tolerance + 2.5; // +2.5 to cover internal extra curvature
  sleeveSideThickness__button_cutout_ratio = 0.85;

  base_l = sleeveBaseThickness;

  // this is used to trim for height of print volume
  cutoff_top_length = true ? 20 : 35;
  trim_front_bars = (cutoff_top_length > 30) ? true : false;

  sleeveInner_w =  tolerance + w + 0;
  sleeveInner_h =  tolerance + h + 0;
  sleeveInner_r = 3.1 - 0.6;
  sleeveInner_rear_r = sleeveInner_r + 1.2;

  buttonsIncludedInner_w =  tolerance + sleeveInner_w + tolerance + 2.2; // button groove depth
  buttonsIncludedInner_h =            +  4.0 + tolerance;
  buttonsIncludedInner_r =  2*tolerance ;
  sleeveOuter_w =  sleeveSideThickness + sleeveInner_w + sleeveSideThickness;
  sleeveOuter_h =  sleeveBottomThickness + sleeveInner_h + sleeveTopThickness;
  sleeveOuter_r = wantThinner ? 4.6 + 1.2 : 4.6 + 2.5;
  sleeve_base_taper_scale = 1/0.94;
  sleeve_base_start_w = sleeveOuter_w / sleeve_base_taper_scale;
  sleeve_base_start_h = sleeveOuter_h / sleeve_base_taper_scale;

  iphoneDisplay_w = active_display__width;
  iphoneDisplay_w_to_housing = active_display__inset_from_exterior - housing_spline_inlay_to_start_of_flat_area__width;

  iphoneScreenOpening_w = iphoneDisplay_w + 2*iphoneDisplay_w_to_housing ;
  caseNonViewable = (1/2) * (sleeveOuter_w - iphoneScreenOpening_w );

  //
  trim_for_lulzbot_mini_height = 0;
  sleeveInner_l = l - trim_for_lulzbot_mini_height ;

  sleeve_button__cutout_depth = 7.7 + 1.8; // how wide the cutouts/openings are
  sleeve_button__y_scale_factor = 1.4 ;
  // controls how far additionally from midline openings are placed (above
  // center from rear of case)
  sleeve_button__y_translate_adjust = 1.85 + 0.60;

  volumeButtonsCutoutHeight = volume_up__half_height + volume_down__half_height +
    ( volume_down_center__from_top - volume_up_center__from_top) + 10 ;  // big enough to be continuous with mute switch
  volumeButtonsHeightFromBottom = translate_y_from_top(volume_down_center__from_top) - volume_down__half_height;

  volumeButtonsCutoutDepth = sleeve_button__cutout_depth;
  volumeButtonsCutoutRadius = 2;
  erase_sleeveInner_l_left  = volumeButtonsHeightFromBottom;

  add_mute_flap_cutout = false; // CONTROL_RENDER_mute_switch_extra_access;
  actionButtonCutoutHeight = 25.2 ; // extend so that switch is accessible with cap on
  actionButtonHeightFromBottom = translate_y_from_top(action_button__center__from_top) - action_button__half_height;
  actionButtonCutoutDepth = sleeve_button__cutout_depth;
  actionButtonCutoutRadius = 2;

  // power button / side button
  shift_up_power_button = 0.0;
  powerButtonCutoutHeight = (side_button__half_height*2) + 10 + 10 + shift_up_power_button;
  powerButtonHeightFromBottom = translate_y_from_top(side_button_center__from_top) - side_button__half_height + shift_up_power_button;
  powerButtonCutoutDepth = sleeve_button__cutout_depth;
  powerButtonCutoutRadius = 2;
  erase_sleeveInner_l_right =   powerButtonHeightFromBottom;

  cameraHeightFromBottom = translate_y_from_top(rear_cam_plateau_center__from_top + rear_cam_plateau__height/2) - 1.0 - 1.6 ;
  cameraCutoutHeight = rear_cam_plateau__height + ((rear_cam_plateau__height - rear_cam_plateau__width)/2) ;
  cameraCutoutDepth = rear_cam_plateau__width + 2;
  cameraCutoutRadius =  rear_cam_plateau__rradius;
  cameraCutoutRadius_diag =  2;
  cameraHoleOffcenter = - 1.0;
  cameraHoleAddOffsetForCase_midline = 8.5 + 2.5; // add additonal safety margin for UW lens
  cameraHoleAddOffsetForCase_sideline = 0.0;

  sideButtonChopCameraExtraThickness = 2.0;
  sideButtonChopCameraPosition = cameraHoleOffcenter + cameraHoleAddOffsetForCase_sideline + cameraCutoutHeight  + cameraHoleAddOffsetForCase_sideline - cameraCutoutRadius_diag - e;
  sideButtonChopCameraFromButtom = cameraHeightFromBottom ;
  sideButtonChopSideButtonFromButtom = powerButtonHeightFromBottom;

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

  usbcCutoutHeight = usbc_connector_keepout__width + 3.35;
  usbcCutoutDepth = usbc_connector_keepout__height;
  usbcCutoutRadius = usbc_connector_keepout__radius;
  usbcFlapCutoutRadius = 0.74;
  usbcHoleOffcenter = 0;

  bottomLipHeight = 4.54; // matches height of case lip
  extra_overlap_screen_bottom = 0.0;
  bottom_lip_rounded_corners = true;

  home_indicator_cutout = true;
  // re-appropriate fingerprint sensor cutout for home indicator
  bottomLipOnScreenIndicator_w = 22.5;
  bottomLipCutout_MinWidth = bottomLipOnScreenIndicator_w;
  bottomLipCutout_Width = bottomLipCutout_MinWidth + 2*3.0;
  bottomLipCutout_h = bottomLipHeight + extra_overlap_screen_bottom;
  bottomLipCutout_scale = 1 + (bottomLipCutout_Width/bottomLipCutout_MinWidth - 1);

  // calculate how far we need to translate below to cut out enough
  bottomRearFlapCutoutHeight = 6.0 + 3.0; // measured on case, add fudge
  bottomRearFlapCutoutWidth = usbc_connector_keepout__width + 3.35; // measured on case, add fudge

  needed_overlap = 2.0;

  // trim based on experiments
  sleeveInner_trim__width  = (2/2)*tolerance ;  // 2*tolerance (2*0.3) was added
  trim__height = (3/4)*tolerance;              // (3/2)*tolerance was added
  sleeveInner_trim__r_flatten = 2.8 - 1.2; //
  sleeveInner_trim__r_flatten_rear = sleeveInner_trim__r_flatten + 1.2 ; //

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
                translate([-1/2*(buttonsIncludedInner_w+e), -1/2*buttonsIncludedInner_h, 0])
                difference () {
                translate([0,-(1/4)*3.0])
                  rounded_square(size=[1/2*buttonsIncludedInner_w + e, buttonsIncludedInner_h + e],
                                 corner_r = buttonsIncludedInner_r, center=false);
              }
              // right side groove fill-in
              linear_extrude(height = erase_sleeveInner_right, center = false, convexity = 10)
                translate([0, -1/2*buttonsIncludedInner_h, 0])
                difference () {
                translate([0,-(1/4)*3.0])
                  rounded_square(size=[1/2*buttonsIncludedInner_w + e, buttonsIncludedInner_h + e],
                                 corner_r = buttonsIncludedInner_r, center=false);
              }
            }
            translate([0,0,-e])
              linear_extrude(height = sleeveInner_l+2*e, center = false, convexity = 10)
              sleeveInnerProfile(w=sleeveInner_w, trim_w=sleeveInner_trim__width,
                                 h=sleeveInner_h, r=sleeveInner_r, r_rear=sleeveInner_rear_r,
                                 trim_r=sleeveInner_trim__r_flatten, trim_r_rear=sleeveInner_trim__r_flatten_rear,
                                 center=true);
          }
          // MAIN EXTRUDE - 2D view for length of case
          difference () {
            // need a difference here to be able to "punch out" button and camera access holes
            linear_extrude(height = sleeveInner_l, center = false, convexity = 10)
              difference () {
              // main outline/profile
              rounded_square(size = [sleeveOuter_w, sleeveOuter_h], corner_r = sleeveOuter_r, center=true);

              sleeveInnerProfile(w=sleeveInner_w, trim_w=sleeveInner_trim__width,
                                 h=sleeveInner_h, r=sleeveInner_r, r_rear=sleeveInner_rear_r,
                                 trim_r=sleeveInner_trim__r_flatten, trim_r_rear=sleeveInner_trim__r_flatten_rear,
                                 center=true);
              // include groove for buttons along whole extrude - filled in above for bottom portions (below buttons)
              translate([0,-(1/4)*3.0])
                rounded_square(size=[buttonsIncludedInner_w,  buttonsIncludedInner_h],
                               corner_r = buttonsIncludedInner_r, center=true);
              // cut for screen and add bevel
              bevel_angle = 46.5 - 1.5;
              // main front opening
              translate ([-iphoneScreenOpening_w/2, -sleeveInner_h ])
                square([iphoneScreenOpening_w, sleeveInner_h],  center = false);
              // front left side
              translate ([-(1/2)*(sleeveInner_w + 1*tolerance), -(sleeveInner_h + 0*tolerance/2) + sleeveTopThickness/2])
                rotate((360 - bevel_angle) * [0, 0, 1])
                square([sleeveInner_h, sleeveInner_h],  center = false);
              // front right side
              translate ([+(1/2)*(sleeveInner_w + 1*tolerance), -(sleeveInner_h + 0*tolerance/2) + sleeveTopThickness/2])
                rotate((90 + bevel_angle) * [0, 0, 1])
                square([sleeveInner_h, sleeveInner_h],  center = false);
            }

            if (CONTROL_RENDER_bottom_back_flap) {
              translate([-(1/2)*(bottomRearFlapCutoutWidth + 1*tolerance) -e,
                         (1/2)*(sleeveInner_h) - tolerance - e,
                         -e])
                usbcBackFlapOpening(flap_opening_height = bottomRearFlapCutoutHeight,
                                         flap_opening_width = bottomRearFlapCutoutWidth,
                                         thickness = sleeveBottomThickness + 1*tolerance + 2*e);
            }

            // power button cutout
            translate([+1 * ((1/2) * sleeveOuter_w + e),
                       -(1/2) * (powerButtonCutoutDepth) - sleeve_button__y_translate_adjust,
                       powerButtonHeightFromBottom])
              rotate([0, 180 + 90, 0])
              scale([1,sleeve_button__y_scale_factor,1])
              linear_extrude(height = sleeveSideThickness__button_cutout + 2*e, center = false,
                             scale = sleeveSideThickness__button_cutout_ratio, convexity = 10)
              rounded_square(size = [powerButtonCutoutHeight, powerButtonCutoutDepth],
                             corner_r = powerButtonCutoutRadius, center=false);

            // volume buttons cutout
            translate([-1 * ((1/2)*sleeveOuter_w + e),
                       -(1/2) * (volumeButtonsCutoutDepth) - sleeve_button__y_translate_adjust,
                       volumeButtonsHeightFromBottom])
              mirror([1,0,0])
              rotate([0, 180 + 90, 0])
              scale([1,sleeve_button__y_scale_factor,1])
              // height is in the X direction
              linear_extrude(height = sleeveSideThickness__button_cutout + 2*e, center = false,
                             scale = sleeveSideThickness__button_cutout_ratio)
              rounded_square(size = [volumeButtonsCutoutHeight, volumeButtonsCutoutDepth],
                             corner_r = volumeButtonsCutoutRadius, center=false);

            // mute switch cutout
            mute_switch_expand_for_flap = add_mute_flap_cutout ? 2.9 : 0;
            mute_switch_addl_cutout     = add_mute_flap_cutout ? 4.0 : 0;
            mute_switch_shift_down_z    = add_mute_flap_cutout ? 2.0 : 3;
            mute_switch__y_scale_factor = add_mute_flap_cutout ? 1.16*sleeve_button__y_scale_factor : 1.0*sleeve_button__y_scale_factor;
            translate([-1 * ((1/2) * sleeveOuter_w + e),
                       -(1/2) * (actionButtonCutoutDepth) - sleeve_button__y_translate_adjust - (0/2)*mute_switch_expand_for_flap,
                       actionButtonHeightFromBottom - mute_switch_shift_down_z])
              mirror([1,0,0])
              rotate([0, 180 + 90, 0])
              scale([1,mute_switch__y_scale_factor,1])
              linear_extrude(height = sleeveSideThickness__button_cutout + mute_switch_addl_cutout + 2*e, center = false,
                             scale = sleeveSideThickness__button_cutout_ratio, convexity = 10)
              rounded_square(size = [actionButtonCutoutHeight + mute_switch_shift_down_z,
                                     actionButtonCutoutDepth + mute_switch_expand_for_flap],
                             corner_r = actionButtonCutoutRadius, center=false);

            // camera cutout
            extend_camera_opening = want_camera_hole_to_be_slot ? 0 : 3 ;

            // normal one
            extra_for_interior_corner = 3*tolerance;
            translate([cameraHoleOffcenter - cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline ,
                       (1/2) * sleeveInner_h - (extra_for_interior_corner + e),
                       cameraHeightFromBottom])
              rotate([90, 0, 0])
              mirror([0,0,1])
              linear_extrude(height = sleeveBottomThickness + extra_for_interior_corner + 2*e, center = false, convexity = 10)
              complexRoundSquare( [cameraCutoutHeight + cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline,
                                   cameraCutoutDepth + extend_camera_opening],
                                  [cameraCutoutRadius, cameraCutoutRadius],
                                  [cameraCutoutRadius_diag, cameraCutoutRadius_diag],
                                  [cameraCutoutRadius, cameraCutoutRadius],
                                  [cameraCutoutRadius_diag, cameraCutoutRadius_diag],
                                  center = false);

            // TODO: REFACTOR to avoid code duplication (copy-and-pasted from above)
            if (want_camera_hole_to_be_slot) {
              // shift up camera cutout past top to make it a slot
              shiftUpAmount = +4;
              translate([cameraHoleOffcenter - cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline ,
                         (1/2) * sleeveInner_h - (extra_for_interior_corner + e),
                         cameraHeightFromBottom + shiftUpAmount])
                rotate([90, 0, 0])
                mirror([0,0,1])
                linear_extrude(height = sleeveBottomThickness + extra_for_interior_corner + 2*e, center = false, convexity = 10)
                complexRoundSquare( [cameraCutoutHeight + cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline,
                                     cameraCutoutDepth + shiftUpAmount + 10],
                                    [cameraCutoutRadius, cameraCutoutRadius],
                                    [cameraCutoutRadius_diag, cameraCutoutRadius_diag],
                                    [0,0],
                                    [0,0],
                                    center = false);
            }

            if (CONTROL_RENDER_chop_side_button_side            ) {

              // back of sleeve from camera area
              translate([sideButtonChopCameraPosition,
                          (1/2) * sleeveInner_h - (extra_for_interior_corner + e) - sideButtonChopCameraExtraThickness,
                          sideButtonChopCameraFromButtom])
                rotate([90, 0, 0])
                mirror([0,0,1])
                linear_extrude(height = sleeveBottomThickness + extra_for_interior_corner + sideButtonChopCameraExtraThickness + 2*e,
                               center = false, convexity = 10)
                square([cameraCutoutHeight - cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline,
                        cameraCutoutDepth + extend_camera_opening], center = false);

              // side of sleeve bide side button
              translate([sideButtonChopCameraPosition,
                          (1/2) * sleeveInner_h - (extra_for_interior_corner + e) - sideButtonChopCameraExtraThickness + 2*e,
                          powerButtonHeightFromBottom])
                rotate([90, 0, 0])
                mirror([0,0,0])
                linear_extrude(height = sleeveBottomThickness + extra_for_interior_corner + sideButtonChopCameraExtraThickness + 12 + 2*e,
                               center = false, convexity = 10)
                square([cameraCutoutHeight - cameraHoleAddOffsetForCase_midline + cameraHoleAddOffsetForCase_sideline,
                        cameraCutoutDepth + extend_camera_opening + 25], center = false);



            }

            if (CONTROL_RENDER_cutoff_top) { // chop off some amount of sleeve top
              cutHeight  = CONTROL_RENDER_experiment3 ? 5 : l - cutoff_top_length ;
              extrHeight = CONTROL_RENDER_experiment3 ? 200 :  cutoff_top_length + 2*e  ;

              echo("cutHeight:", cutHeight);
              translate([0,0, cutHeight])
                linear_extrude(height = extrHeight, center = false, convexity = 10)
                complexRoundSquare([sleeveOuter_w + 2*e, sleeveOuter_h + 2*e],
                                   [0,0], [0,0], [0,0], [0,0],
                                   center = true);
              if (trim_front_bars) {
                translate([-(1/2)*sleeveOuter_w, - (1/2)*sleeveOuter_h, volumeButtonsHeightFromBottom])
                  linear_extrude(height = extrHeight + 10, center = false, convexity = 10)
                  complexRoundSquare([sleeveOuter_w + 2*e, sleeveOuter_h + 2*e],
                                     [0,0], [0,0], [0,0], [0,0],
                                     center = true);
                translate([(1/2)*sleeveOuter_w, - (1/2)*sleeveOuter_h, powerButtonHeightFromBottom])
                  linear_extrude(height = extrHeight + 10, center = false, convexity = 10)
                  complexRoundSquare([sleeveOuter_w + 2*e, sleeveOuter_h + 2*e],
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
        capCaseHeight = sleeveInner_l + 2*tolerance; //
        capCaseWidth = sleeveOuter_w + tolerance; //
        powerSideCut = powerButtonHeightFromBottom;
        powerSideHeight = powerButtonCutoutHeight;
        powerButtonCapClip_z = capCaseHeight - powerSideCut - powerSideHeight;

        muteSideCut = actionButtonHeightFromBottom;
        muteSideHeight = actionButtonCutoutHeight;
        actionButtonCapClip_z = capCaseHeight - muteSideCut - muteSideHeight;

        echo("capDepth:",  capDepth );
        echo("capCaseHeight:", capCaseHeight);
        echo("capCaseWidth:", capCaseWidth);
        echo("powerButtonCapClip_z:", powerButtonCapClip_z);
        echo("actionButtonCapClip_z:", actionButtonCapClip_z);

        translate([0, -sleeve_button__y_translate_adjust, capCaseHeight])
          generateCap(capArmThickness, capCapThickness, capDepth, capCaseWidth,
                      powerButtonCapClip_z, actionButtonCapClip_z);
      }

      // "base" flat/bottom part of sleeve
      if (with_sleeve) {
        translate([0,0,e]) // to ensure overlap with main extrude (may not be needed?)
          difference() {
          translate([0,0, -base_l])
            linear_extrude(height = base_l, center = false, convexity = 10,
                           scale = sleeve_base_taper_scale)
            // 2D view for base of sleeve - matches main extrude
            rounded_square(size = [sleeve_base_start_w, sleeve_base_start_h],
                           corner_r = sleeveOuter_r/sleeve_base_taper_scale, center=true);

          // handle speaker and mic, USB-C, USB-C access
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
            // USB-C access and case flap handling
            extend_out_flap_space = true ? 5 : 0;
            if (CONTROL_RENDER_bottom_usbc_access) {
              rotate([180,0,0])
                translate([-tolerance/2, 0, -1*e])
                linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
                union () {
                // main stretch strip on bottom
                rounded_square(size = [usbcCutoutHeight, usbcCutoutDepth + 8.0 + tolerance],
                               corner_r = usbcFlapCutoutRadius, center=true);
                // extend up so flap has a place to go when inserting usbc connector
                translate([0, extend_out_flap_space, 0])
                  rounded_square(size = [usbcCutoutHeight, usbcCutoutDepth + 7.6 + 3*tolerance],
                                 corner_r = usbcFlapCutoutRadius, center=true);
                // cutout at rear of base, aligns with back flap cutout
                if (CONTROL_RENDER_bottom_back_flap) {
                  translate([0, -(1/2)*(sleeveInner_h + sleeveBottomThickness), 0])
                    rounded_square(size = [bottomRearFlapCutoutWidth, sleeveBottomThickness + 3.0 + 3*tolerance],
                                   corner_r = 0.5, center=true);
                }
              }
            }
          }
        }
      }

      // bottom "lip", above base
      bottom_lip_rounded_corners__radius = 7.5 + 5 ;
      extraBottomLipHeight = bottom_lip_rounded_corners ? 22 : 0;
      bottomLipDisplayOpeningWidth = w - 11.0 + 2*3.0; // added width
      bottomLipDisplayOpeningHeight = extraBottomLipHeight;

      // Bottom lip, including front band and back band
      if (with_sleeve) {
        difference() {
          // main 2D view/outline for height of lip
          linear_extrude(height = bottomLipCutout_h + extraBottomLipHeight, center = false, convexity = 10)
            difference () {
            rounded_square(size=[sleeveOuter_w, sleeveOuter_h], corner_r = sleeveOuter_r, center=true);

            // by bottom screen edge, front bottom lip, cut out size of iphone - should also match main extrude
            sleeveInnerProfile(w=sleeveInner_w, trim_w=sleeveInner_trim__width,
                               h=sleeveInner_h+2*e, r=sleeveInner_r, r_rear=sleeveInner_rear_r,
                               trim_r=sleeveInner_trim__r_flatten, trim_r_rear=sleeveInner_trim__r_flatten_rear,
                               center=true);
          }
          if (CONTROL_RENDER_bottom_back_flap) {
            translate([-(1/2)*(bottomRearFlapCutoutWidth + 1*tolerance)-e ,
                       (1/2)*(sleeveInner_h) - tolerance - e, -e])
              usbcBackFlapOpening(flap_opening_height = bottomRearFlapCutoutHeight,
                                       flap_opening_width = bottomRearFlapCutoutWidth,
                                       thickness = sleeveBottomThickness + 1*tolerance + 2*e);
          }
          // previously cutout for fingerprint - appropriated for space for
          // sliding up from bottom edge of display for home indicator
          if (home_indicator_cutout) {
            echo ("Width of face bottom lip cutout: ", bottomLipCutout_MinWidth);
            translate([-e, -(sleeveOuter_h/2)-e, -e])
              linear_extrude(height = bottomLipCutout_h + 2*e + 0.05, center = false,
                             convexity = 10, scale=bottomLipCutout_scale) {
              mirror([1,0,0])
                square([bottomLipCutout_MinWidth/2, sleeveSideThickness + 2*e], center=false);
              square([bottomLipCutout_MinWidth/2, sleeveSideThickness + 2*e ], center=false);
            }
          }
          // rounded bottom corners for finger access to screen area corners / follows case curve
          if (bottom_lip_rounded_corners) {
            translate([0, 0, bottomLipCutout_h + bottomLipDisplayOpeningHeight/2])
              rotate([90, 0, 0])
              linear_extrude(height = 20, center = false, convexity = 10)
              complexRoundSquare([bottomLipDisplayOpeningWidth, bottomLipDisplayOpeningHeight + 2*e],
                                 [bottom_lip_rounded_corners__radius, bottom_lip_rounded_corners__radius + 6],
                                 [bottom_lip_rounded_corners__radius, bottom_lip_rounded_corners__radius + 6],
                                 [0,0],
                                 [0,0],
                                 center = true);
          }
        } // end difference
      }
      // mounting wedge on back
      if (with_sleeve) {
        // add mounting wedge
        mountInsertWidth = 22;
        mountInsertThickness = 3;
        mountInsertHeight = 42;

        // y dimension needs to overlap with sleeve
        mountInsert_yTranslation = (1/2)*(tolerance + h) + sleeveBottomThickness - 1*e;

        // y dimension needs to overlap with sleeve
        translate([-mountInsertWidth/2, mountInsert_yTranslation, (0.65) * l - mountInsertHeight + base_l])
          difference() {
          sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, tweak_mount_surface);

          if (true) {
            // chop off top 1.5 mm of insert (as it seems to not fully insert into slot)
            translate([-e, -e, mountInsertHeight - 1.5])
              cube([mountInsertWidth + 2*e, mountInsertThickness*2 + 2*e, 6]);
          }
        }
      }
    }
    // intersection of a bounding volume
    if (CONTROL_RENDER_prototype_bottom) {
      keepHeight = 55;
      cutHeight  = 30;
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

  tolerance = 0.3;

  capCaseWidth = cap_case_width;
  capCapThickness = cap_thickness;
  capArmThickness = cap_arm_thickness;
  capDepth = cap_depth;
  capCornerSupportThickness = 2.5; //
  capCornerSupportWidth = 9.0;  //
  capCornerSupportHeight = 5.0;
  capCornerSupportHeight_overlap = cap_thickness - 0.6;  //
  caseOverlap = 10.0 + -1.0;
  overlapSleeveCornerSupportRear = false;
  capCornerSupportHeight_power_z = capCornerSupportHeight_overlap + (overlapSleeveCornerSupportRear ? mute_switch_z : caseOverlap - 0.76);
  capCornerSupportHeight_mute_z = capCornerSupportHeight_overlap + (overlapSleeveCornerSupportRear ? mute_switch_z : caseOverlap - 0.76) ;

  with_split_top_of_sleeve = true;
  with_tab_corner_support =  true;

  fudge =  true;
  powerButtonCapClip_z = fudge ? power_button_z + 1.5 : power_button_z;
  actionButtonCapClip_z  = fudge ? mute_switch_z  + 2.0 : mute_switch_z;

  tabInsertDepth = 4.6;

  sleeve_button__y_translate_adjust = 1.85;

  powerButtonCap_tabHeight = 15.2;
  powerButtonCap_tabWidth = 10 - 1*tolerance;
  actionButtonCap_tabHeight = 15.2;
  actionButtonCap_tabWidth = 10 - 1*tolerance;

  capSideDistance = (capCaseWidth + capArmThickness + tolerance)/2;

  // main bar across tab
  linear_extrude(height = capCapThickness + e, center = false, convexity = 10)
    // 2D view for cap (base of cap)
    complexRoundSquare([capCaseWidth + 2*capArmThickness + tolerance, capDepth],
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
    translate([capSideDistance, ((1/2)*capDepth) - e, - (capCornerSupportHeight_power_z - capCornerSupportHeight_overlap)])
      mirror([1,0,0])

      linear_extrude(height = capCornerSupportHeight_power_z, center = false, convexity = 10)
      complexRoundSquare([capCornerSupportWidth, capCornerSupportThickness],
                         [0,0],
                         [0,0],
                         [1.5,1.5],
                         [1.5,1.5],
                         center = false);
  }
  // mute switch side - length to tab
  translate([-(capSideDistance), 0,  - actionButtonCapClip_z])
    linear_extrude(height = actionButtonCapClip_z, center = false, convexity = 10)
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
  translate([-(capSideDistance), 0, - actionButtonCapClip_z - actionButtonCap_tabHeight])
    rotate([0,0,0])
    generateCapTab(capArmThickness, capDepth,
                   actionButtonCap_tabHeight, actionButtonCap_tabWidth, tabInsertDepth, direction = false);
  // mute switch side - corner reinforcement
  if (with_tab_corner_support) {
    translate([-(capSideDistance - 0), (1/2)*capDepth  - e, - (capCornerSupportHeight_mute_z - capCornerSupportHeight_overlap)])
      mirror([0,0,0])
      linear_extrude(height = capCornerSupportHeight_mute_z, center = false, convexity = 10)
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
  tab_r = 2.5;
  translate([(1/2)*capArmThickness - e, cap_tab_y_shift ,(1/2)*tabHeight])
    rotate([0,90,0])
    // greater than scale [,] x =~ 0.50 generally will imply supports to print
    scale([1,cap_tab_y_scale,1])
    linear_extrude(height = tabInsertDepth, scale = [0.68, 0.85],  twist=0, center = false)
    rounded_square(size=[tabHeight, tabWidth], corner_r=tab_r,
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

  insertPartialHeight = 25.0 ;
  insertSlantedHeight = insertFullHeight - insertPartialHeight;
  insertSlantAngle = 62;
  insertSlantAngle2 = 65;

  tolerance = 0.5;

  insertChopThickness_x = shouldTweak ? insertChopThickness + tolerance : insertChopThickness;
  insertChopThickness_y = shouldTweak ? insertChopThickness + tolerance : insertChopThickness;
  r1 = shouldTweak ? 0 : 0;
  // empirically determined value when shouldTweak == false
  start_of_leading_edge = (1/2) * insertSlantedHeight * sin (insertSlantAngle);
  z_cover_leading_edge = start_of_leading_edge + 0.12 ;
  y_rot2_leading_edge = - 180 + insertSlantAngle2;

  rotateAngle = 12;

  echo("insertChopThickness_x:", insertChopThickness_x);
  echo("insertChopThickness_y:", insertChopThickness_y);

  difference() {
    linear_extrude(height = insertFullHeight, center = false, convexity = 10)
      difference() {
      complexRoundSquare([insertTailWidth, insertThickness],
                         [0,0], [0,0], [0,0], [0,0],
                         center = false);

      // vertical side nearest attach surface
      translate([-e, -e, 0])
        complexRoundSquare([insertChopThickness_x + e, insertChopThickness_y + e],
                           [0,0], [0,0], [r1,r1], [0,0],
                           center = false);

      // other vertical side nearest attach surface
      translate([insertTailWidth - insertChopThickness_x - e, -e, 0])
        complexRoundSquare([insertChopThickness_x + e, insertChopThickness_y + e],
                           [0,0], [0,0], [0,0], [r1,r1],
                           center = false);

      // this carves a small slant on the side rails
      if (shouldTweak) {
        translate([insertChopThickness_x, insertChopThickness_y, 0])
          rotate([0,0,180-rotateAngle])
          complexRoundSquare([insertChopThickness_x+2, insertChopThickness_y/2],
                             [0,0], [0,0], [0,0], [0,0],
                             center = false);
        translate([insertTailWidth - insertChopThickness_x, 0, 0])
          translate([0, insertChopThickness_y,0])
          rotate([0,0,270+rotateAngle])
          complexRoundSquare([insertChopThickness_x/2, insertChopThickness_y+2],
                             [0,0], [0,0], [0,0], [0,0],
                             center = false);
      }
    }
    // leading edges of upper wings of slot
    translate([insertChopThickness_x + 0*e + 0.1,
               insertChopThickness_y - 1*e ,
               start_of_leading_edge - 1*e - 0.0])
      rotate([0, y_rot2_leading_edge, 0])
      cube(10 + 2);
    translate([insertTailWidth - insertChopThickness_x - 0*e - 0.1,
               insertChopThickness_y - 1*e ,
               start_of_leading_edge - 1*e - 0.0])
      rotate([0, 90 - insertSlantAngle2 ,0])
      cube(10 + 2);
    translate([-e, -e, 0])
      mirror([0,0,0])
      rotate([0,0,0])
      cube([insertChopThickness_x + 2*e,insertChopThickness_y+2, z_cover_leading_edge]);
    translate([insertTailWidth + e, -e , 0])
      mirror([1,0,0])
      rotate([0,0,0])
      cube([insertChopThickness_x + 2*e,insertChopThickness_y+2, z_cover_leading_edge]);

    // carve leading edge main slope/angle
    translate([-1*e, -1*e, -1*e])
      rotate([-(90-insertSlantAngle),0,0])
      cube([insertTailWidth+2*e, insertFullHeight/2+2*e, insertFullHeight/2+2*e]);
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
  actionButtonCapClip_z = 14.0; // caseHeight - muteSideCut - muteSideHeight;

  translate([100, 0, capCapThickness])
    rotate([180,0,0])
    generateCap(capArmThickness, capCapThickness, capDepth, capCaseWidth,
                powerButtonCapClip_z, actionButtonCapClip_z);
}

module test_generateCapTab(cap_arm_thickness, cap_case_width, tab_height, tab_width, tab_insert_depth ) {
  generateCapTab(cap_arm_thickness, cap_case_width, tab_height, tab_width, tab_insert_depth);
}



module showTogether() {

  tweakMountSurface = true;
  withCap = !true;
  withSleeve = true;
  tolerance = tol;

  show_with_phone_and_case = true;

  if (show_with_phone_and_case) {
    // iPhone 15 Pro Max
    // use this ratio since case back is thicker than front inset
    %translate([tw, tl, (icase_h_ratio)*th ])
      iphone_15_pro_max(iw, il, ih, show_keepouts = true);
    // case model
    %color("Grey", alpha=0.85)
    translate([0,0,0]) otterboxDefenderCase();
  }

  // sleeve mount design
  translate([w_use/2-(1/2)*tolerance, 0, h_use/2]) rotate([360-90,0,0]) sleeveForEncasediPhone(w_use, l, h_use,  tweakMountSurface, withCap, withSleeve );
}

if (show_everything) {
  showTogether();
 } else {
  // $preview requires version 2019.05
  fn = $preview ? 30 : 100;

  tweakMountSurface =  true;


  if (!printCap) {
    translate([0,0,0])
      sleeveForEncasediPhone(w_use, l, h_use, tweakMountSurface, false, true);
  } else { // print sleeve
    scale ([1.0,1.0,1.0])
      translate([0,0,3+l+0.5])
      rotate([180,0,0])
      sleeveForEncasediPhone(w_use, l, h_use, tweakMountSurface, true, false);
  }

  // *test_sleeveMountInsert(tweakMountSurface, 0);
 }
