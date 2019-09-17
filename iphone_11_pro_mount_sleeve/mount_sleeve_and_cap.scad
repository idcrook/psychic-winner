////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2019-Sep-16
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//   I decided to re-implement this iphone sleeve phone, to fit my iPhone 6
//   Plus case and using OpenSCAD
//
// Revisions/Notes:
//
//   2019-Sep-16: Preparing for iPhone 11 Pro
//
////////////////////////////////////////////////////////////////////////


use <mockup/iPhone_11_Pro_Mockup.scad>;
use <MCAD/2Dshapes.scad>
use <../libraries/wedge.scad>

e = 0.02; // small number


// -	[FORM by Monoprice iPhone 11 Pro 5.8 Rugged Slim Case, Clear](https://www.monoprice.com/product?c_id=309&cp_id=30901&cs_id=3090101&p_id=39619)
// Blind guesses to start
//  - Length 150.0 mm
//  - Width  77.5 mm
//  - Depth  12.7 mm

l = 150.0;  //
w = 77.5;
h = 12.7;   // at corners; elsewhere as low as 10.1 mm


// https://developer.apple.com/accessories/Accessory-Design-Guidelines.pdf
//  § 29.2 iPhone 11 Pro  (Downloaded 2019-Sep-16, Release R10)
//  - Length: 143.99 mm
//  - Width:   71.36 mm
//  - Depth:    8.10 mm

il = 144.00;
iw =  71.36;
ih =   8.10;
tol = 0.2;

dw = w - iw;
dl = l - il;
dh = h - ih;

tw = (1/2) * dw  ;
tl = (1/2) * dl  ;
th = (1/2) * dh  ;

// display cutout
cut_w = 62.33;
cut_l = 134.95;
cut_r = 2.5;

// display
dcw = (w - cut_w) / 2;
dcl = (l - cut_l) / 2;

function translate_y_from_top (from_top)  = il - from_top;


//
module monopriceRuggedThinCase () {

  difference() {
    // case outer dimensions
    //color ("Green") shell(w, l, h, 10, 3);
    shell(w, l, h, 10, 3);

    // carve out iphone and some tolerance
    translate([tw - tol, tl - tol, th]) {
      shell(iw + 2*tol, il + 2*tol, ih + 2*tol, 9.5 + 2*tol, 3);
    }

    // cut out above phone too (rounded rect with dimensions 73.3 x 153.8)
    translate ([dcw,dcl,th+ih-tol])
      linear_extrude(height = 10, center = false, convexity = 10)
      complexRoundSquare([cut_w, cut_l],
                         [cut_r, cut_r],
                         [cut_r, cut_r],
                         [cut_r, cut_r],
                         [cut_r, cut_r],
                         center = false);
  }
}


module sleeveForEncasediPhone (w, l, h, tweak_mount_surface, with_cap, with_sleeve) {

  tolerance = 0.5;

  CONTROL_RENDER_cutoff_top = true;
  CONTROL_RENDER_cutoff_top = false;

  CONTROL_RENDER_prototype_bottom = true;
  CONTROL_RENDER_prototype_bottom = false;

  CONTROL_RENDER_experiment3 = true;
  CONTROL_RENDER_experiment3 = false;

  CONTROL_RENDER_experiment4 = true;
  CONTROL_RENDER_experiment4 = false;

  CONTROL_RENDER_experiment5 = true;
  CONTROL_RENDER_experiment5 = false;

  wantThinner = true;
  //wantThinner = false;

  sleeveSideThickness   =  wantThinner ? 2.8 : 3.5;
  sleeveBottomThickness =  wantThinner ? 2.8 : 3.5;
  sleeveTopThickness    =  wantThinner ? 2.8 : 3.5;
  sleeveBaseThickness   =  wantThinner ? 2.8 : 3.5;

  base_l = sleeveBaseThickness;

  sleeveInner_w =  tolerance + w + tolerance;
  sleeveInner_h =  tolerance + h + ( tolerance / 2 );
  sleeveInner_r = 1.7;

  buttonsIncludedInner_w =  tolerance + 64.7 + tolerance + 0.5;
  buttonsIncludedInner_h =            +  3.0 + tolerance;
  buttonsIncludedInner_r =  tolerance ;

  sleeveOuter_w =  sleeveSideThickness + sleeveInner_w + sleeveSideThickness;
  sleeveOuter_h =  sleeveBottomThickness + sleeveInner_h + sleeveTopThickness;
  sleeveOuter_r = 3.2;

  iphoneDisplay_w = 48.5;
  iphoneScreenBezel_w = 3.5;

  iphoneScreenOpening_w = iphoneScreenBezel_w + iphoneDisplay_w + iphoneScreenBezel_w;
  caseNonViewable = (1/2) * (sleeveOuter_w - iphoneScreenOpening_w );

  sleeveInner_l = l;
  //volumeButtonsHeightFromBottom = 78.0;
  volumeButtonsCutoutHeight = 34; // big enough to be continuous
  volumeButtonsHeightFromBottom = translate_y_from_top(51.37) - 5.88;
  volumeButtonsCutoutDepth = 7.7 + 2.3;
  volumeButtonsCutoutRadius = 2;
  erase_sleeveInner_l_left  = volumeButtonsHeightFromBottom;

  //muteSwitchHeightFromBottom = 99.5;
  muteSwitchCutoutHeight = 12.2 + 3.0;
  muteSwitchHeightFromBottom = translate_y_from_top(24.72) - (1/2)*5.7;
  muteSwitchCutoutDepth = 7.7 + 2.3;
  muteSwitchCutoutRadius = 2;

  //powerButtonHeightFromBottom = 102;
  powerButtonCutoutHeight = (8.77*2) + 10;
  powerButtonHeightFromBottom = translate_y_from_top(44.61) - 8.77;
  powerButtonCutoutDepth = 7.7 + 2.3;
  powerButtonCutoutRadius = 2;
  erase_sleeveInner_l_right =   powerButtonHeightFromBottom;


  cameraHeightFromBottom = translate_y_from_top(32.71) - 1.5/2;
  cameraCutoutHeight = 30.59 + 1.3;
  cameraCutoutDepth = 32.71 + 1.3;
  cameraCutoutRadius = 7.5;
  //cameraHoleOffcenter = 3.0 - 0.5;
  cameraHoleOffcenter = 0.65;

  speakerCutoutHeight = 18;
  speakerCutoutDepth = 5.5;
  speakerCutoutRadius = speakerCutoutDepth/2;
  // speakerHoleOffcenter = 8.8 ;
  speakerHoleOffcenter = 8.5 ;

  lightningCutoutHeight = 13.85;
  lightningCutoutDepth = 6.85;
  lightningCutoutRadius = 3.4;
  lightningHoleOffcenter = 0;

  headphoneMicCutoutHeight = 15 - 2 - 1;
  headphoneMicCutoutDepth = 6.0;
  headphoneMicCutoutRadius = lightningCutoutDepth/2;
  headphoneMicHoleOffcenter = 20.0;

  // Use some trig: http://mathworld.wolfram.com/CircularSegment.html
  //bottomLipHeight = 18.0 - 3;
  bottomLipHeight = 5;
  bottomLipFingerprintDiameter = 17;
  bottomLipCutoutMaxWidth = 1.6 * bottomLipFingerprintDiameter;
  bottomLipCutoutArcRadius = 2.6*bottomLipCutoutMaxWidth;  // pick a multiple
  bottomLipCutoutArcDegrees = 2*asin(bottomLipCutoutMaxWidth/(2*bottomLipCutoutArcRadius));  // figure out how many degrees of arc this is
  fingerprint_sensor_cutout = false;

  // calculate the width of cutout at junction with base
  bottomLipCutout_r2 = bottomLipCutoutArcRadius - bottomLipHeight;
  bottomLipCutout_MinWidth = 2 * bottomLipCutout_r2 * tan((1/2) *bottomLipCutoutArcDegrees);

  // calculate how far we need to translate below to cut out enough
  bottomLipCutout_h = bottomLipCutoutArcRadius * cos((1/2)*bottomLipCutoutArcDegrees);

  intersection() {
    union() {
      if (with_sleeve) {
        union () {

          // fill in groove for part of sleeve below buttons
          if (!CONTROL_RENDER_experiment3) {
            difference() {
              union () {
                erase_sleeveInner_left = CONTROL_RENDER_experiment5 ? l : erase_sleeveInner_l_left;
                erase_sleeveInner_right = CONTROL_RENDER_experiment5 ? l : erase_sleeveInner_l_right;

                // left side fill-in
                linear_extrude(height = erase_sleeveInner_left, center = false, convexity = 10)
                  translate([-(1/2)*buttonsIncludedInner_w, -(1/2)*buttonsIncludedInner_h, 0])
                  difference () {
                  complexRoundSquare([buttonsIncludedInner_w/2, buttonsIncludedInner_h],
                                     [0, 0], [0, 0], [0, 0], [0, 0],
                                     center = false);

                  // cut out size of iphone in case (plus tolerance)
                  translate([(buttonsIncludedInner_w-sleeveInner_w)/2, 0, 0])
                    complexRoundSquare([(1/2)*sleeveInner_w, sleeveInner_h/2],
                                       [0, 0],
                                       [0, 0],
                                       [sleeveInner_r, sleeveInner_r],
                                       [sleeveInner_r, sleeveInner_r],
                                       center = false);
                }

                // right side fill-in
                linear_extrude(height = erase_sleeveInner_right, center = false, convexity = 10)
                  translate([0, -(1/2)*buttonsIncludedInner_h, 0])
                  difference () {
                  complexRoundSquare([buttonsIncludedInner_w/2, buttonsIncludedInner_h],
                                     [0, 0], [0, 0], [0, 0], [0, 0],
                                     center = false);

                  // cut out size of iphone in case (plus tolerance)
                  translate([0, 0, 0])
                    complexRoundSquare([(1/2)*sleeveInner_w, sleeveInner_h/2],
                                       [0, 0],
                                       [0, 0],
                                       [sleeveInner_r, sleeveInner_r],
                                       [sleeveInner_r, sleeveInner_r],
                                       center = false);
                }
              }
              // fill in groove in cap
              translate([0,0,l - 10.0])
                rotate([180,0,0])
                linear_extrude(height = 40.0, center = false, convexity = 10)
                complexRoundSquare([sleeveOuter_w, sleeveOuter_h],
                                   [0, 0],
                                   [0, 0],
                                   [sleeveInner_r, sleeveInner_r],
                                   [sleeveInner_r, sleeveInner_r],
                                   center = true);
            }
          }

          // need a difference here to be able to punch out button and camera access holes
          difference () {
            // 2D view for length of case
            linear_extrude(height = sleeveInner_l, center = false, convexity = 10)
              difference () {
              complexRoundSquare([sleeveOuter_w, sleeveOuter_h],
                                 [sleeveOuter_r, sleeveOuter_r],
                                 [sleeveOuter_r, sleeveOuter_r],
                                 [sleeveOuter_r, sleeveOuter_r],
                                 [sleeveOuter_r, sleeveOuter_r],
                                 center = true);


              // cut out size of iphone in case (includes tolerance)
              complexRoundSquare([sleeveInner_w, sleeveInner_h],
                                 [sleeveInner_r, sleeveInner_r],
                                 [sleeveInner_r, sleeveInner_r],
                                 [sleeveInner_r, sleeveInner_r],
                                 [sleeveInner_r, sleeveInner_r],
                                 center = true);

              // include groove for buttons (covered back in above)
              complexRoundSquare([buttonsIncludedInner_w,  buttonsIncludedInner_h],
                                 [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                 [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                 [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                 [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                                 center = true);

              bevel_angle = 50;

              // cut for screen and add bevel
              translate ([-iphoneScreenOpening_w/2, -sleeveInner_h ])
                square([iphoneScreenOpening_w, sleeveInner_h],  center = false);

              translate ([-(1/2)*(sleeveInner_w + 2*tolerance), -(sleeveInner_h + tolerance)  + sleeveTopThickness/2])
                rotate((360 - bevel_angle) * [0, 0, 1])
                square([caseNonViewable, sleeveInner_h],  center = false);

              translate ([1/2*(sleeveInner_w + 2*tolerance), -(sleeveInner_h + tolerance) + sleeveTopThickness/2])
                rotate((90 + bevel_angle) * [0, 0, 1])
                square([caseNonViewable, sleeveInner_h],  center = false);
            }

            // volume buttons cutout
            translate([-1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (volumeButtonsCutoutDepth), volumeButtonsHeightFromBottom])
              mirror([1,0,0])
              rotate([0, 180 + 90, 0])
              linear_extrude(height = sleeveSideThickness + 2*e, center = false, scale = 0.9, convexity = 10)
              complexRoundSquare( [volumeButtonsCutoutHeight, volumeButtonsCutoutDepth],
                                  [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                  [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                  [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                  [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                  center = false);

            // power button cutout
            translate([+1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (powerButtonCutoutDepth), powerButtonHeightFromBottom])
              rotate([0, 180 + 90, 0])
              linear_extrude(height = sleeveSideThickness + 2*e, center = false, scale = 0.9, convexity = 10)
              complexRoundSquare( [powerButtonCutoutHeight, powerButtonCutoutDepth],
                                  [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                  [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                  [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                  [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                  center = false);

            // mute switch cutout
            /// echo(muteSwitchCutoutHeight, muteSwitchCutoutDepth, muteSwitchHeightFromBottom);
            translate([-1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (muteSwitchCutoutDepth), muteSwitchHeightFromBottom])
              mirror([1,0,0])
              rotate([0, 180 + 90, 0])
              linear_extrude(height = sleeveSideThickness + 2*e, center = false,  scale = 0.9, convexity = 10)
              complexRoundSquare( [muteSwitchCutoutHeight, muteSwitchCutoutDepth ],
                                  [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                  [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                  [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                  [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                  center = false);

            // camera cutout
            translate([cameraHoleOffcenter, (1/2) * sleeveInner_h - tolerance - e, cameraHeightFromBottom])
              rotate([90, 0, 0])
              mirror([0,0,1])
              linear_extrude(height = sleeveBottomThickness + 2*tolerance +2*e, center = false, convexity = 10)
              complexRoundSquare( [cameraCutoutHeight, cameraCutoutDepth ],
                                  [cameraCutoutRadius, cameraCutoutRadius],
                                  [cameraCutoutRadius, cameraCutoutRadius],
                                  [cameraCutoutRadius, cameraCutoutRadius],
                                  [cameraCutoutRadius, cameraCutoutRadius],
                                  center = false);

            if (CONTROL_RENDER_cutoff_top) {
              cutHeight  = CONTROL_RENDER_experiment3 ? 5 : l - 10.0 ;
              extrHeight = CONTROL_RENDER_experiment3 ? 200 : 26 ;

              echo("cutHeight:", cutHeight);
              translate([0,0, cutHeight])
                linear_extrude(height = extrHeight, center = false, convexity = 10)
                complexRoundSquare([sleeveOuter_w+e, sleeveOuter_h+e],
                                   [0,0], [0,0], [0,0], [0,0],
                                   center = true);
            } else {
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
        capArmThickness = 4;
        capCapThickness = 3.5;
        capDepth = sleeveOuter_h;
        // added 1.5 mm since case sits higher in sleeve
        caseHeight = sleeveInner_l + 1.5;
        capCaseWidth = sleeveOuter_w + 2*tolerance + tolerance;  // tolerance
                                                                 // shouldn't
                                                                 // here be
                                                                 // higher-quality
                                                                 // prints
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

        if (CONTROL_RENDER_experiment5) {
          translate([0, 0, caseHeight])
            generateCap(capArmThickness, capCapThickness, capDepth, capCaseWidth,
                        powerButtonCapClip_z, muteSwitchCapClip_z);
        } else {
          translate([0, 0, caseHeight])
            generateCap(capArmThickness, capCapThickness, capDepth, capCaseWidth,
                        powerButtonCapClip_z, muteSwitchCapClip_z);
        }
      }


      // base
      if (with_sleeve) {
        difference() {
          translate([0,0, -base_l])
            linear_extrude(height = base_l, center = false, convexity = 10)
            // 2D view for base of sleeve
            complexRoundSquare([sleeveOuter_w, sleeveOuter_h],
                               [sleeveOuter_r, sleeveOuter_r],
                               [sleeveOuter_r, sleeveOuter_r],
                               [sleeveOuter_r, sleeveOuter_r],
                               [sleeveOuter_r, sleeveOuter_r],
                               center = true);

          // handle speaker hole, lightning, headphone

          // speaker hole
          rotate([180,0,0])
            translate([-tolerance + speakerHoleOffcenter, -(1/2) * speakerCutoutDepth, -e])
            linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
            complexRoundSquare( [speakerCutoutHeight, speakerCutoutDepth + 4*e],
                                [speakerCutoutRadius/2, speakerCutoutRadius/2],
                                [speakerCutoutRadius, speakerCutoutRadius],
                                [speakerCutoutRadius, speakerCutoutRadius],
                                [speakerCutoutRadius/2, speakerCutoutRadius/2],
                                center = false);

          // lightning hole
          rotate([180,0,0])
            translate([-tolerance/2, 0, -e])
            linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
            complexRoundSquare( [lightningCutoutHeight + tolerance, lightningCutoutDepth + tolerance],
                                [lightningCutoutRadius, lightningCutoutRadius],
                                [lightningCutoutRadius, lightningCutoutRadius],
                                [lightningCutoutRadius, lightningCutoutRadius],
                                [lightningCutoutRadius, lightningCutoutRadius],
                                center = true);

          // headphone and Mic hole
          rotate([180,0,0]) {
            translate([-headphoneMicHoleOffcenter, -(1/2) * headphoneMicCutoutDepth, -e])
              linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
              complexRoundSquare( [headphoneMicCutoutHeight, headphoneMicCutoutDepth],
                                  [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                  [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                  [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                  [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                  center = false);

          }
        }
      }

      // Bottom lip with cutout for Home button / thumbprint sensor
      if (with_sleeve) {
        difference() {
          // 2D view for height of lip
          linear_extrude(height = bottomLipHeight, center = false, convexity = 10)
            difference () {
            complexRoundSquare([sleeveOuter_w, sleeveOuter_h],
                               [sleeveOuter_r, sleeveOuter_r],
                               [sleeveOuter_r, sleeveOuter_r],
                               [sleeveOuter_r, sleeveOuter_r],
                               [sleeveOuter_r, sleeveOuter_r],
                               center = true);

            // cut out size of iphone plus some additional
            scale ([1,1.22,1])
              complexRoundSquare([sleeveInner_w, sleeveInner_h],
                                 [sleeveInner_r, sleeveInner_r],
                                 [sleeveInner_r, sleeveInner_r],
                                 [sleeveInner_r, sleeveInner_r],
                                 [sleeveInner_r, sleeveInner_r],
                                 center = true);
          }

          if (CONTROL_RENDER_cutoff_top) {
            cutHeight  = CONTROL_RENDER_experiment3 ? 5 : l - 10.0 ;
            extrHeight = CONTROL_RENDER_experiment3 ? 200 : 26 ;

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


          // cutout for fingerprint
          if (fingerprint_sensor_cutout) {
            //// wedge(height, radius, degrees);
            echo ("Width of fingerprint cutout at base: ", bottomLipCutout_MinWidth);
            translate([0, 0, bottomLipHeight-bottomLipCutout_h+e])
              rotate([90, 360-(90-bottomLipCutoutArcDegrees/2), 0])
              wedge (10, bottomLipCutoutArcRadius, bottomLipCutoutArcDegrees);
          }
        }
      }


      if (with_sleeve) {
        if (!CONTROL_RENDER_experiment3) {
          mountInsertWidth = 22;
          mountInsertThickness = 3;
          mountInsertHeight = 42;

          mountInsert_yTranslation = (1/2)*( tolerance + h + tolerance) + sleeveBottomThickness - e;

          // y dimension needs to overlap with sleeve
          translate([-mountInsertWidth/2, mountInsert_yTranslation - (2 * e), (0.65) * l - mountInsertHeight + base_l])
            difference() {
            sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, tweak_mount_surface);
            // chop off top 1.5 mm
            translate([-e, -e, mountInsertHeight - 1.5])
              cube([mountInsertWidth + 2*e, mountInsertThickness*2 + 2*e, 6]);
          }
        }
      }
    }

    if ((CONTROL_RENDER_cutoff_top && CONTROL_RENDER_experiment4) || CONTROL_RENDER_experiment5) {
      keepHeight = 45 + 10;
      cutHeight  = l + 10 ;
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

      translate([0,0, cutHeight - keepHeight])
        linear_extrude(height = extrHeight, center = false, convexity = 10)
        complexRoundSquare([sleeveOuter_w+10+e, sleeveOuter_h+10+e],
                           [0,0],
                           [0,0],
                           [0,0],
                           [0,0],
                           center = true);
    }


  }
}


module generateCap(cap_arm_thickness, cap_thickness, cap_depth, cap_case_width,
                   power_button_z, mute_switch_z) {

  tolerance = 0.5;

  capCaseWidth = cap_case_width;
  capCapThickness = cap_thickness;
  capArmThickness = cap_arm_thickness;
  capDepth = cap_depth;
  with_split_top_of_sleeve = false;

  fudge = true;
  //fudge = false;
  powerButtonCapClip_z = fudge ? power_button_z + 1 : power_button_z;
  muteSwitchCapClip_z  = fudge ? mute_switch_z  + 1 : mute_switch_z;

  tabInsertDepth = 2.5 + 1;

  powerButtonCap_tabHeight = 15;
  powerButtonCap_tabWidth = 10 - tolerance;
  muteSwitchCap_tabHeight = 15.2;
  muteSwitchCap_tabWidth = 10 - tolerance;

  capSideDistance = (capCaseWidth + capArmThickness)/2;
  caseOverlap = 10.0;

  linear_extrude(height = capCapThickness, center = false, convexity = 10)
    // 2D view for cap
    complexRoundSquare([capCaseWidth + 2*capArmThickness, capDepth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  // power button side
  translate([capSideDistance, 0, - powerButtonCapClip_z])
    linear_extrude(height = powerButtonCapClip_z, center = false, convexity = 10)
    complexRoundSquare([capArmThickness, capDepth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  if (with_split_top_of_sleeve) {
    translate([capSideDistance - (capArmThickness - 1), 0, - caseOverlap + e])
      linear_extrude(height = caseOverlap, center = false, convexity = 10)
      complexRoundSquare([capArmThickness, capDepth],
                         [0,0], [0,0], [0,0], [0,0],
                         center = true);
  }

  translate([capSideDistance, 0,  - powerButtonCapClip_z - powerButtonCap_tabHeight])
    rotate([0,0,180])
    generateCapTab(capArmThickness, capDepth,
                   powerButtonCap_tabHeight, powerButtonCap_tabWidth, tabInsertDepth);


  // mute switch side
  translate([-(capSideDistance), 0,  - muteSwitchCapClip_z])
    linear_extrude(height = muteSwitchCapClip_z, center = false, convexity = 10)
    complexRoundSquare([capArmThickness, capDepth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  if (with_split_top_of_sleeve) {
    translate([-(capSideDistance - (capArmThickness - 1)), 0, - caseOverlap + e])
      linear_extrude(height = caseOverlap, center = false, convexity = 10)
      complexRoundSquare([capArmThickness, capDepth],
                         [0,0], [0,0], [0,0], [0,0],
                         center = true);
  }

  translate([-(capSideDistance), 0, - muteSwitchCapClip_z - muteSwitchCap_tabHeight])
    rotate([0,0,0])
    generateCapTab(capArmThickness, capDepth,
                   muteSwitchCap_tabHeight, muteSwitchCap_tabWidth, tabInsertDepth);

}


module generateCapTab(cap_arm_thickness, cap_case_width, tab_height, tab_width, tab_insert_depth) {

  capCaseWidth = cap_case_width;
  capArmThickness = cap_arm_thickness;
  tabHeight = tab_height;
  tabWidth = tab_width;
  tabInsertDepth = tab_insert_depth;

  if (true) {
    echo("=== generateCapTab ===");
    echo("capCaseWidth:", capCaseWidth);
    echo("capArmThickness:", capArmThickness);
    echo("tabHeight:", tabHeight);
    echo("tabWidth:", tabWidth);
    echo("tabInsertDepth:", tabInsertDepth);
  }

  translate([0,0,0])
    linear_extrude(height = tabHeight, center = false, convexity = 10)
    complexRoundSquare([capArmThickness, tabWidth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  translate([(1/2)*capArmThickness,0,(1/2)*tabHeight])
    rotate([0,90,0])
    linear_extrude(height = tabInsertDepth, scale = 0.7, center = false, convexity = 10)
    complexRoundSquare([tabHeight, tabWidth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);


  translate([0,0,tabHeight])
    rotate([0,180,0])
    linear_extrude(height = tabHeight/2, center = false, scale = 0.7, convexity = 10)
    //linear_extrude(height = tabHeight/2, center = false, scale = 0.7, convexity = 10)
    complexRoundSquare([capArmThickness, capCaseWidth],
                       [0,0], [0,0], [0,0], [0,0],
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

        translate([-e, -e, 0])
          complexRoundSquare([insertChopThickness_x, insertChopThickness_y],
                             [0,0], [0,0], [0,0], [0,0],
                             center = false);

        translate([insertTailWidth - insertChopThickness_x + e, -e, 0])
          complexRoundSquare([insertChopThickness_x, insertChopThickness_y],
                             [0,0], [0,0], [0,0], [0,0],
                             center = false);

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

      rotate([insertSlantAngle,0,0])
        cube(insertFullHeight);
    }

    translate([insertChopThickness,
               insertChopThickness - 2*e,
               (1/2) * insertSlantedHeight * sin (insertSlantAngle) - e])
      rotate([360-(90-insertSlantAngle),0,90])
      cube(7);

    translate([insertTailWidth - insertChopThickness,
               insertChopThickness - 2*e,
               (1/2) * insertSlantedHeight * sin (insertSlantAngle) - e])
      rotate([0, (90 - insertSlantAngle) ,0])
      cube(7);
  }

}


module test_sleeveMountInsert (fit_better, translate_x) {
  mountInsertWidth = 22;
  mountInsertThickness = 3;
  mountInsertHeight = 42;

  fitBetter = fit_better;

  tolerance = 0.5;
  sleeveBottomThickness = 3.0;

  mountInsert_yTranslation = (1/2)*( tolerance + h + tolerance) + sleeveBottomThickness;

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

  // iPhone 11 Pro
  translate([tw, tl, th ]) iphone_11_pro(71.4, 144.0, 8.1, show_lightning_keepout = true);

  // monopriceRuggedThinCase
  %translate([0,0,0]) monopriceRuggedThinCase();

  // design
  %translate([w/2,0,h/2]) rotate([360-90,0,0]) sleeveForEncasediPhone(w, l, h,  tweakMountSurface, withCap, withSleeve );


}

test1 = true;
test1 = false;



if (test1) {
  showTogether();
} else {
  $fn = 100;

  tweakMountSurface = false;
  tweakMountSurface = true;

  withCap = true;
  withCap = false;

  withSleeve = true;

  printCap = true;
  printCap = false;

  if (! printCap) {
    translate([0,0,3]) sleeveForEncasediPhone(w, l, h, tweakMountSurface, withCap, withSleeve);
  } else {
    scale ([1.01,1.0,1]) translate([0,0,3+l+0.5]) rotate([180,0,0]) sleeveForEncasediPhone(w, l, h, tweakMountSurface, true, ! withSleeve);
  }

  * test_sleeveMountInsert(tweakMountSurface, 0);


}
