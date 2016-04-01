////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   27-Mar-2016 
//
// Author:
//
//   David Crook <dpcrook@users.noreply.github.com>
//
// Inspired by:
//
//   - http://www.thingiverse.com/thing:4382/ iPhone Bike Mount
//   - http://www.thingiverse.com/thing:18020/ Dodge Ram Vent Mount for iPhone
//
// Description:
//
//   I decided to re-implement this iphone sleeve phone, to fit my iPhone 6
//   Plus case and using OpenSCAD
//
// Revisions/Notes:
//
//   v1:
//
//   - used .STL imported into OpenSCAD to base dimensions on, and firstly
//     modeled my incipio iPhone case
//
//   - after many iterations, experiments and tweaks, have an iPhone mount and
//     sleeve for my bicycle.  plan to work on a mount system for my car/truck
//     next
//   
//
////////////////////////////////////////////////////////////////////////


use <files/iPhone_6_and_6_Plus_Mockups.scad>;
use <MCAD/2Dshapes.scad>
use <../libraries/wedge.scad>

  e = 0.02; // small number

  w = 81.5;
  l = 161.9;  // 
  h = 10.5;   // at corners; elsewhere as low as 10.1 mm

  iw = 77.8;
  il = 158.1;
  ih = 7.1;
  tol = 0.2;

  dw = w - iw;
  dl = l - il;
  dh = h - ih;

  tw = (1/2) * dw  ;
  tl = (1/2) * dl  ;
  th = (1/2) * dh  ;

  cut_w = 73.3;
  cut_l = 153.8;
  cut_r = 9.5;

  dcw = (w - cut_w) / 2;
  dcl = (l - cut_l) / 2;
    


// http://www.amazon.com/IPhone-Incipio-Impact-Resistant-Translucent/dp/B00MUQ9V1Q
// "Incipio NGP Case for iPhone 6+"
// 6.5 x 3.3 x 0.5 inches
module incipioNgpCase () {

  difference() {
    // case outer dimensions
    color ("Yellow") shell(w, l, h, 14);

    // carve out iphone 6 Plus and some tolerance
    translate([tw - tol, tl - tol, th]) {
      shell(iw + 2*tol, il + 2*tol, ih + 2*tol, 9.5 + 2*tol);
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


module sleeveForEncasediPhone (w, l, h, tweak_mount_surface, with_cap) {

  tolerance = 0.5;

  CONTROL_RENDER_cutoff_top = true;
  //CONTROL_RENDER_cutoff_top = false;

  CONTROL_RENDER_experiment3 = true;
  CONTROL_RENDER_experiment3 = false;

  CONTROL_RENDER_experiment4 = true;
  CONTROL_RENDER_experiment4 = false;

  CONTROL_RENDER_experiment5 = true;
  CONTROL_RENDER_experiment5 = false;
  
  wantThinner = true;
  //wantThinner = false;

  sleeveSideThickness   =  wantThinner ? 3.0 : 3.5;
  sleeveBottomThickness =  wantThinner ? 3.0 : 3.5;
  sleeveTopThickness    =  wantThinner ? 3.0 : 3.5;
  sleeveBaseThickness   =  wantThinner ? 3.0 : 3.5;

  base_l = sleeveBaseThickness;

  sleeveInner_w =  tolerance + w + tolerance;
  sleeveInner_h =  tolerance + h + tolerance;
  sleeveInner_r = 1.7;

  buttonsIncludedInner_w =  tolerance + 82.3 + tolerance + 0.5;
  buttonsIncludedInner_h =            +  3.0 + tolerance;
  buttonsIncludedInner_r =  tolerance ;

  sleeveOuter_w =  sleeveSideThickness + sleeveInner_w + sleeveSideThickness;
  sleeveOuter_h =  sleeveBottomThickness + sleeveInner_h + sleeveTopThickness;
  sleeveOuter_r = 3.2;

  iphoneDisplay_w = 68.8;
  iphoneScreenBezel_w = 3.5;
  
  iphoneScreenOpening_w = iphoneScreenBezel_w + iphoneDisplay_w + iphoneScreenBezel_w;
  caseNonViewable = (1/2) * (sleeveOuter_w - iphoneScreenOpening_w );
  
  sleeveInner_l = l;
  volumeButtonsHeightFromBottom = 105.0;
  volumeButtonsCutoutHeight = 25.3;
  volumeButtonsCutoutDepth = 7.7 + 2.3;
  volumeButtonsCutoutRadius = 2;
  erase_sleeveInner_l_left  = volumeButtonsHeightFromBottom;
  
  powerButtonHeightFromBottom = 117.7 - 1.0;
  powerButtonCutoutHeight = 12.2 + 2.0 + 1.0;
  powerButtonCutoutDepth = 7.7 + 2.3;
  powerButtonCutoutRadius = 2;
  erase_sleeveInner_l_right =   powerButtonHeightFromBottom;
  
  muteSwitchHeightFromBottom = 132.7;
  muteSwitchCutoutHeight = 12.2 + 3.0;
  muteSwitchCutoutDepth = 7.7 + 2.3;
  muteSwitchCutoutRadius = 2;

  cameraHeightFromBottom = 144.8;
  cameraCutoutHeight = 0.5 + 28.2 + 0.5;
  cameraCutoutDepth = 12.1;
  cameraCutoutRadius = cameraCutoutDepth/2-1;
  cameraHoleOffcenter = 5.5 - 0.5;

  speakerCutoutHeight = 22;
  speakerCutoutDepth = 5;
  speakerCutoutRadius = speakerCutoutDepth/2;
  speakerHoleOffcenter = 10.8 ;

  lightningCutoutHeight = 14.4;
  lightningCutoutDepth = lightningCutoutHeight/2;
  lightningCutoutRadius = lightningCutoutDepth/2;
  lightningHoleOffcenter = 0;

  headphoneMicCutoutHeight = 15 - 2;
  headphoneMicCutoutDepth = 7.2;
  headphoneMicCutoutRadius = lightningCutoutDepth/2;
  headphoneMicHoleOffcenter = 28.5 + 3.9 - 2;
  headphoneJackDiameter = 3.5;
  
  headphoneMicBoreDiameter = 8.0 + 0.2;
  headphoneMicBoreOffcenter = 28.5 + 2.6 + headphoneMicCutoutDepth -
    headphoneMicBoreDiameter;
  
  // Use some trig: http://mathworld.wolfram.com/CircularSegment.html
  bottomLipHeight = 18.0 - 3;
  bottomLipFingerprintDiameter = 17;
  bottomLipCutoutMaxWidth = 1.6 * bottomLipFingerprintDiameter;
  bottomLipCutoutArcRadius = 2.6*bottomLipCutoutMaxWidth;  // pick a multiple
  bottomLipCutoutArcDegrees = 2*asin(bottomLipCutoutMaxWidth/(2*bottomLipCutoutArcRadius));  // figure out how many degrees of arc this is
  
  // calculate the width of cutout at junction with base
  bottomLipCutout_r2 = bottomLipCutoutArcRadius - bottomLipHeight;
  bottomLipCutout_MinWidth = 2 * bottomLipCutout_r2 * tan((1/2) *bottomLipCutoutArcDegrees);

  // calculate how far we need to translate below to cut out enough
  bottomLipCutout_h = bottomLipCutoutArcRadius * cos((1/2)*bottomLipCutoutArcDegrees);

  intersection() {
    union() {
      union () {

        // fill in groove for part of sleeve below buttons
        if (!CONTROL_RENDER_experiment3) {
          difference() {
            union () {
              erase_sleeveInner_left = CONTROL_RENDER_experiment5 ? l : erase_sleeveInner_l_left;
              erase_sleeveInner_right = CONTROL_RENDER_experiment5 ? l : erase_sleeveInner_l_right;
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
            complexRoundSquare([buttonsIncludedInner_w, buttonsIncludedInner_h],
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
            mirror()
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
            mirror()
            rotate([0, 180 + 90, 0], center = true)
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
            complexRoundSquare( [cameraCutoutHeight, cameraCutoutDepth + 1.2],
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

      // cap
      if (with_cap) {
        capArmThickness = 4;
        capCapThickness = 3.5;
        capDepth = sleeveOuter_h;
        caseHeight = sleeveInner_l;
        capCaseWidth = sleeveOuter_w + 2*tolerance;  // tolerance here should
                                                     // not be necessary on
                                                     // higher-quality prints
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
          complexRoundSquare( [speakerCutoutHeight, speakerCutoutDepth],
                              [speakerCutoutRadius/2, speakerCutoutRadius/2],
                              [speakerCutoutRadius, speakerCutoutRadius],
                              [speakerCutoutRadius, speakerCutoutRadius],
                              [speakerCutoutRadius/2, speakerCutoutRadius/2],
                              center = false);

        // lightning hole
        rotate([180,0,0])
          translate([-tolerance, 0, -e])
          linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
          complexRoundSquare( [lightningCutoutHeight, lightningCutoutDepth],
                              [lightningCutoutRadius, lightningCutoutRadius],
                              [lightningCutoutRadius, lightningCutoutRadius],
                              [lightningCutoutRadius, lightningCutoutRadius],
                              [lightningCutoutRadius, lightningCutoutRadius],
                              center = true);

        // widen lightning hole
        rotate([180,0,0])
          translate([-tolerance, 0, -e])
          linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
          complexRoundSquare( [lightningCutoutHeight - 5, lightningCutoutDepth + 2],
                              [lightningCutoutRadius/2, lightningCutoutRadius/2],
                              [lightningCutoutRadius/2, lightningCutoutRadius/2],
                              [lightningCutoutRadius/2, lightningCutoutRadius/2],
                              [lightningCutoutRadius/2, lightningCutoutRadius/2],
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
      
          translate([-headphoneMicBoreOffcenter, -(1/2) * headphoneMicBoreDiameter, -e])
            linear_extrude(height = base_l + 2*e, center = false, convexity = 10) 
            complexRoundSquare( [headphoneMicBoreDiameter, headphoneMicBoreDiameter],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                center = false);
        }    
      }

      // Bottom lip with cutout for Home button / thumbprint sensor
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
        //// wedge(height, radius, degrees);
        echo ("Width of fingerprint cutout at base: ", bottomLipCutout_MinWidth);
        translate([0, 0, bottomLipHeight-bottomLipCutout_h+e])
          rotate([90, 360-(90-bottomLipCutoutArcDegrees/2), 0])
          wedge (10, bottomLipCutoutArcRadius, bottomLipCutoutArcDegrees);
      }

    

      if (!CONTROL_RENDER_experiment3) {
        mountInsertWidth = 22;
        mountInsertThickness = 3;
        mountInsertHeight = 42;
  
        mountInsert_yTranslation = (1/2)*( tolerance + h + tolerance) + sleeveBottomThickness - e;
  
        translate([-mountInsertWidth/2, mountInsert_yTranslation, (0.58) * l - mountInsertHeight + base_l])
          difference() {
          sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, tweak_mount_surface);
          // chop off top 1.5 mm
          translate([-e, -e, mountInsertHeight - 1.5])
            cube([mountInsertWidth + 2*e, mountInsertThickness*2 + 2*e, 6]);
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
  }
}


module generateCap(cap_arm_thickness, cap_thickness, cap_depth, cap_case_width,
                      power_button_z, mute_switch_z) {

  capCaseWidth = cap_case_width;
  capCapThickness = cap_thickness;
  capArmThickness = cap_arm_thickness;
  capDepth = cap_depth;

  fudge = true;
  //fudge = false;
  powerButtonCapClip_z = fudge ? power_button_z + 1 : power_button_z;
  muteSwitchCapClip_z  = fudge ? mute_switch_z  + 1 : mute_switch_z;

  tabInsertDepth = 2.5;
  
  powerButtonCap_tabHeight = 15;
  powerButtonCap_tabWidth = 10;
  muteSwitchCap_tabHeight = 15.2;
  muteSwitchCap_tabWidth = 10;
  
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

  translate([capSideDistance - (capArmThickness - 1), 0, - caseOverlap + e])
    linear_extrude(height = caseOverlap, center = false, convexity = 10)
    complexRoundSquare([capArmThickness, capDepth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);
  
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

  translate([-(capSideDistance - (capArmThickness - 1)), 0, - caseOverlap + e])
    linear_extrude(height = caseOverlap, center = false, convexity = 10)
    complexRoundSquare([capArmThickness, capDepth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);
  
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

  translate([0,0,0])
    linear_extrude(height = tabHeight, center = false, convexity = 10)
    complexRoundSquare([capArmThickness, tabWidth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);

  translate([(1/2)*capArmThickness,0,(1/2)*tabHeight])
    rotate([0,90,0])
    linear_extrude(height = tabInsertDepth, scale = 0.3, center = false, convexity = 10)
    complexRoundSquare([tabHeight, tabWidth],
                       [0,0], [0,0], [0,0], [0,0],
                       center = true);


  translate([0,0,tabHeight])
    rotate([0,180,0])    
    linear_extrude(height = tabHeight/2, center = false, scale = 0.7, convexity = 10)
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

module bicycleMount(mount_insert_w, mount_insert_thickness, mount_insert_h, fitBetter) {

  // there are four basic design features of the bike mount:
  //
  //  1. curvature for bike frame
  // 
  //  2. through hole around this curvature for a metal screw-band (for
  //     attaching to bike frame)
  //
  //  3. mount insert piece for inserting phone carrier
  //
  //  4. clip latch to "lock" iphone carrier into the mount unless released
  //

  block_x = 30.5;
  block_y = 24.0;
  block_z = 39.0;

  mountInsert_w = mount_insert_w;
  mountInsert_h = 2*mount_insert_thickness;
  enlargePunchScale = 1.08;

  // http://mathworld.wolfram.com/CircularSegment.html
  /* heightOfArcedPortion = 7.8;  // Original setting */
  heightOfArcedPortion = 5.8;  // for my bicycle's handlebar column
  chordLength = block_x;

  // R = (1/2) (a^2/4h + h)
  radiusOfCurvature = (1/2) * (pow(chordLength,2)/(4*heightOfArcedPortion) + heightOfArcedPortion);

  // r = R - h
  circleCenterDistanceFromCut = radiusOfCurvature - heightOfArcedPortion;
  
  thicknessOfBandSupport = 3.5;
  bandCutoutDistanceFromBlock = 10.7;

  bandCutoutStartOfNegative = (3/10)*block_z;
  bandCutoutStopOfNegative = (7/10)*block_z;

  lockClip_square = 10.0;
  lockClip_x = lockClip_square;
  lockClip_y = lockClip_square;
  lockClip_z = 6.6;
  lockClip_r = lockClip_square/2;
  lockClip_fr = lockClip_square/3;

  lockClipScrewDiameter = 2.0;
  
  difference() {
    linear_extrude(height = block_z, center = false, convexity = 10)
      difference () {
      complexRoundSquare([block_x, block_y],
                         [0,0], [0,0], [0,0], [0,0],
                         center = false);

      //  1. curvature for bike frame
      translate([block_x/2, block_y + circleCenterDistanceFromCut,0])
        circle(r= radiusOfCurvature);
    }

    //  2. through hole around this curvature for a metal screw-band 
    translate([0,0,bandCutoutStartOfNegative])
      linear_extrude(height = bandCutoutStopOfNegative - bandCutoutStartOfNegative, center = false, convexity = 10)
      difference() {
      translate([-e, bandCutoutDistanceFromBlock,0])
        square([block_x+2*e, block_y]);
      
      translate([block_x/2, block_y + circleCenterDistanceFromCut,0])
        circle(r= radiusOfCurvature + thicknessOfBandSupport);
    }
      
   //  3. mount insert piece for inserting phone carrier
   scale([enlargePunchScale, enlargePunchScale, 1], center = false)
     translate([-50 + (1/2) * (block_x - (mountInsert_w * enlargePunchScale)) ,
                (mountInsert_h - enlargePunchScale*mountInsert_h), block_z - mount_insert_h + e])
     test_sleeveMountInsert(fitBetter);
  }

  //  4. clip latch to "lock" iphone carrier into the mount unless released
  //  (attach point)
  translate ([block_x , 0, block_z - lockClip_z]) {   
    linear_extrude(height = lockClip_z, center = false, convexity = 10)
      union() {

      difference () {
        complexRoundSquare([lockClip_x, lockClip_y],
                           [0,0],
                           [0,0],
                           [lockClip_r, lockClip_r],
                           [0,0],
                           center = false);
        translate([lockClip_x/2, lockClip_y/2,0])
          circle(r=lockClipScrewDiameter/2);

      }

      // upper curve
      translate([0, lockClip_y, 0]) {
        difference() {
          complexRoundSquare([lockClip_x, lockClip_y],
                             [0,0],
                             [0,0],
                             [0,0],
                             [0,0],
                             center = false);
          translate([-e, -e, 0])
            complexRoundSquare([lockClip_x + 2*e, lockClip_y + 2*e],
                               [lockClip_fr, lockClip_fr],
                               [0,0],
                               [0,0],
                               [0,0],
                               center = false);
        }
      }
    }
  }
  //  5. catch, to "lock" carrier into the mount 
  //
  printable = true;
  //printable = false;
  align = 3;
  spread = 5;
  if (printable) {
    translate([-align, -spread, block_z])
      rotate([180, 0, 0])
    
      import ("files/mount_v6-catch.stl");
  } else {
    translate([-align, 0.5, block_z])
      rotate([0, 0, 0])
    
      %import ("files/mount_v6-catch.stl");
    
  }
      

}

module generateCup () {
  
  cupRegionHeightAboveHolderBottom = 40.5 + 10;
  cupRegionHeightBelowHolderBottom = 20;

  holderBottomSectionSplitDiameter = 70.4;

  cupBaseThickness = 4.5;
  cupSideThickness = 3.5;
  cupSideSlope = 10/1;
  
  // two parts of side of cup (cones sections)

  // top section
  sideIncreaseTop = cupRegionHeightAboveHolderBottom * (1/cupSideSlope);
  top_t = cupRegionHeightBelowHolderBottom + (1/2)*cupRegionHeightAboveHolderBottom;
  top_h = cupRegionHeightAboveHolderBottom;
  top_r1 = holderBottomSectionSplitDiameter/2;
  top_r2 = holderBottomSectionSplitDiameter/2 + sideIncreaseTop;
  top_thickness = cupSideThickness;
  translate([0,0,top_t])
    difference () {
    cylinder(h = top_h,
             r1 = top_r1, r2 = top_r2, center=true);

    translate([0,0,e/2])
      cylinder(h = top_h + 2*e,
             r1 = top_r1 - top_thickness, r2 = top_r2 - top_thickness, center=true);
    }
  
  // bottom section
  sideDecreaseBottom = cupRegionHeightBelowHolderBottom * (1/cupSideSlope);
  bottom_t = cupRegionHeightBelowHolderBottom/2;
  bottom_h = cupRegionHeightBelowHolderBottom;
  bottom_r1 = holderBottomSectionSplitDiameter/2 - sideDecreaseBottom;
  bottom_r2 = top_r1;
  bottom_thickness = cupSideThickness;
  
  translate([0,0,bottom_t])
    difference () {
    cylinder(h = bottom_h, r1 = bottom_r1, r2 = bottom_r2, center=true);

    translate([0,0,e/2])
    cylinder(h = bottom_h + 2*e,
             r1 = bottom_r1 - bottom_thickness, r2 = bottom_r2 - top_thickness, center=true);
    }

  // base
  base_thickness = cupBaseThickness;
  base_t = base_thickness/2;

  translate([0,0,-base_t])
    linear_extrude(height = base_thickness, center = false, convexity = 10)
    circle(r = bottom_r1, center = true);

  echo("sideIncreaseTop:", sideIncreaseTop);
  echo("Top of cup Diameter:", 2*top_r2);
  echo("sideDecreaseBottom:", sideDecreaseBottom);
  echo("Base Diameter:", 2*bottom_r1);
  
  totalCupHeight = base_t + bottom_h + top_h;
  echo("totalCupHeight:", totalCupHeight);
}


module generateCupLid (d) {
  cupLidThickness = 4.5;

  coin_x = 37.5;
  coin_y = 20.5;

  difference () {
    translate([0,0,0])
      linear_extrude(height = cupLidThickness, center = false, convexity = 10)
      circle(d=d, center=true);

    translate([0,0,-e])
      linear_extrude(height = cupLidThickness + 2*e, center = false, convexity = 10)
        translate([0, d/2 - (1.5)*cupLidThickness - coin_y/2, 0])
        resize([coin_x, coin_y]) circle(d=coin_y);

    translate([0,-d/4,-e])
      lidBracketHoles((3/4) * d/4, 3.0, cupLidThickness+e);
  }
}

module generateLidBracket (d) {

  bracketBase_r = (d/2)/2;
  bracketBase_thickness = 3.5;

  difference () {
    translate([0,0,0])
      linear_extrude(height = bracketBase_thickness, center = false, convexity = 10)
      circle(r=bracketBase_r, center=true);

    lidBracketHoles((3/4) * bracketBase_r, 3.0, bracketBase_thickness);
  }

  column_x = 22;
  column_y = 19;
  column_inner_x = 12.6;
  column_inner_y = 12.5;
  column_h = 40;
  column_angle = 60;

  column_arm_h = 20 + (1/2)*sin(90-column_angle) * max(column_x, column_y) ;
  
  column_y_t =  (1/2)*1/(tan(column_angle)) * (1/2)*column_y;
  column_z_t = bracketBase_thickness - cos(column_angle) * (1/2)*column_y;
  
  column_base_cut_t = cos(column_angle) * (1/2)*column_y;
  column_base_cut_h = 2* column_base_cut_t;

  column_slice_y_t = 0;  
  column_slice_z_t = column_h;

  column_slice_45_d = max(column_x, column_y);
  
  translate([0, column_y_t, column_z_t]) {
    difference ()
    {    
      rotate([90-column_angle, 0, 0])
        translate([0,0,0])
        ellipsoidColumn(column_x, column_y, column_inner_x, column_inner_y, column_h);
      
      // make flush with bracket
      translate([0,0, -column_base_cut_t-e ])
        linear_extrude(height = column_base_cut_h, center = false, convexity = 10)
        circle(r = bracketBase_r, center=true);
      
      // make vertical slice
      rotate([90-column_angle, 0, 0])
      translate([0, column_slice_y_t, column_slice_z_t ]) // translate to end of column
        translate([0, 0, - (1/2) * (tan(column_angle/2)) * column_y ]) 
          rotate([column_angle/2, 0, 0])
          linear_extrude(height = column_slice_45_d , center = false, convexity = 10)
          circle(d = column_slice_45_d + 5);
    }

    // arm extension
    difference ()
    {    
      translate([ 0,
                  (1/2) * column_y * sin(column_angle),
                  -(1/2) * column_y * sin(column_angle) * tan(column_angle/2)])
        rotate([90-column_angle, 0, 0])
        translate([0, column_slice_y_t, column_slice_z_t ]) // translate to end of column
        rotate([column_angle, 0, 0])
        ellipsoidColumn(column_x, column_y, column_inner_x, column_inner_y, column_arm_h);

      rotate([90-column_angle, 0, 0])
      translate([0, column_slice_y_t, column_slice_z_t ]) // translate to end of column
        translate([0, 0, - (1/2) * (tan(column_angle/2)) * column_y ]) 
        rotate([180 + (column_angle/2), 0, 0])
        linear_extrude(height =  column_slice_45_d, center = false, convexity = 10)
        circle(d = column_slice_45_d + 10);
    }
  }
  echo("bracket column z:", bracketBase_thickness + column_h * sin(column_angle));
  
}

module generateLidBracketCoupler () {

  coupler_diam = 12.5;
  coupler_l = 20;
  
  base_d = 3*coupler_diam;
  base_thickness = 3;
  base_mount_thickness = 4*base_thickness;

  support_height = 3 * base_thickness;
  support_thickness = base_thickness;
  support_overlap = 0.5;

  // base plate

  hull() {
    translate([0,0,0])
      linear_extrude(height = 6, center = false, convexity = 10)
      square([base_d, 39], center = true);
    
    translate([0,0,base_mount_thickness/2])
      ellipsoidColumn(base_d, base_d, 0,0, base_mount_thickness/2);
  }
  
  translate([0,0,base_mount_thickness])
  {
    // coupler column
    ellipsoidColumn(coupler_diam, coupler_diam, 0,0, support_height +  coupler_l);

    
    /// translate([0,0,base_thickness]) #supportColumn(support_height, coupler_diam, support_thickness, support_overlap);
    
    // support columns
    couplerSupportColumns(support_height, coupler_diam, support_thickness, support_overlap);
  }
}

module ellipsoidColumn(column_x, column_y, column_inner_x, column_inner_y, column_h) {

  linear_extrude(height = column_h, center = false, convexity = 10)
    difference ()
  {
    resize([column_x, column_y]) circle(d=column_y);
    
    // hollow out a cylinder
    resize([column_inner_x, column_inner_y]) circle(d=column_inner_y);
  }

}

module lidBracketHoles (d, sd, h) {
  
  rotate([0,0,  0 + 45])
    bracketHole(d, sd, h);

  rotate([0,0, 90 + 45])
    bracketHole(d, sd, h);

  rotate([0,0,180 + 45])
    bracketHole(d, sd, h);

  rotate([0,0,270 + 45])
    bracketHole(d, sd, h);
  
}

module bracketHole(d, sd, h) {
  radialDistance  = d;
  screwDiameter = sd;
  
  translate([radialDistance, 0, -e])
    cylinder(h = h + 2*e, d = screwDiameter, center=false);
}

module couplerSupportColumns (support_height, support_width, support_thickness, support_overlap) {
  rotate([0,0,  0 + 45])
    supportColumn(support_height, support_width, support_thickness, support_overlap);

  rotate([0,0, 90 + 45])
    supportColumn(support_height, support_width, support_thickness, support_overlap);

  rotate([0,0,180 + 45])
    supportColumn(support_height, support_width, support_thickness, support_overlap);

  rotate([0,0,270 + 45])
    supportColumn(support_height, support_width, support_thickness, support_overlap);
  
}

module supportColumn (support_height, support_width, support_thickness, support_overlap) {

  coupler_diam = support_width;
  
  support_t = coupler_diam/2 - support_overlap;
    
  translate([0,0,0])
  {
    
    translate([0, support_t, 0])
      rotate([0,360-90,0])
      
      linear_extrude(height = support_thickness, center = true, convexity = 10)
      
      difference()
    {
      square([support_height, coupler_diam], center=false );
      
      translate( (11/9) * [support_height, coupler_diam, 0])
        resize(2*[support_height, coupler_diam]) circle(d = 1);
      
    }
  }
}


module test_bicycleMount(tweak_mount_surface) {
        mountInsertWidth = 22;
        mountInsertThickness = 3;
        mountInsertHeight = 42;

        fitBetter = tweak_mount_surface;
        
        tolerance = 0.5;
        sleeveBottomThickness = 3.0;
          
        mountInsert_yTranslation = (1/2)*( tolerance + h + tolerance) + sleeveBottomThickness;
  
        translate([0, 0, 0])
          rotate([180,0,0])
          bicycleMount(mountInsertWidth, mountInsertThickness, mountInsertHeight, fitBetter);
}

module test_sleeveMountInsert (fit_better) {
        mountInsertWidth = 22;
        mountInsertThickness = 3;
        mountInsertHeight = 42;

        fitBetter = fit_better;
        
        tolerance = 0.5;
        sleeveBottomThickness = 3.0;
          
        mountInsert_yTranslation = (1/2)*( tolerance + h + tolerance) + sleeveBottomThickness;

        translate([0, 0, 0])
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

module test_generateCapTab(cap_arm_thickness, cap_case_width, tab_size) {
  generateCapTab(cap_arm_thickness, cap_case_width, tab_size);
}

module test_generateCatch() {
    translate([0, 0, 0])
      rotate([0, 0, 0])
      import ("files/mount_v6-catch.stl");
}


module test_generateCupholder() {

    $fn = 200;
    *translate([0,0,4.5/2]) generateCup();
    topCupDiameter = 80.5;
    cupHeightWithSeperation = 72.75 + 2;

    bracketColumnZ = 38.1;
    
    translate([0,0,cupHeightWithSeperation]) generateCupLid(topCupDiameter) ;
    
    translate([0, -(1/4)*topCupDiameter, cupHeightWithSeperation + 4.5 + 2])
      generateLidBracket(topCupDiameter) ;

    enlargePunchScale = 1.08;

    translate([0, -(1.25)*topCupDiameter, cupHeightWithSeperation + bracketColumnZ + 4.5 + 2 - 19/2])
    {
      difference()
      {
        rotate([360-90,0,0])
          generateLidBracketCoupler() ;

        translate([-11, -(0.5)*enlargePunchScale,-20])
          scale([enlargePunchScale, enlargePunchScale, 1], center = false)
          test_sleeveMountInsert (false);

        /* *translate([-50 + (1/2) * (block_x - (mountInsert_w * enlargePunchScale)) , */
        /*            (mountInsert_h - enlargePunchScale*mountInsert_h), block_z - mount_insert_h + e]) */
        
      }
    }

}


module showTogether() {

  withCap = true;
  
  // iphone 6 Plus
  translate([tw, tl, th ]) iphone(77.8, 158.1, 7.1, 9.5);

  // incipio case
  translate([0,0,0]) incipioNgpCase();

  * color ("White")
    translate ([200, 50, 0])
    import ("files/iPhone_Bike_Mount/mount_v4-case.stl");

  // design
  %translate([w/2,0,h/2]) rotate([360-90,0,0]) sleeveForEncasediPhone(w, l, h, false, withCap);

  
}

test1 = true;
test1 = false;


if (test1) {
  showTogether();
} else {
  $fn = 100;
  
  tweakMountSurface = false;
  sleeveWithCap = true;
  sleeveWithCap = false;
  
  *translate([0,0,3]) sleeveForEncasediPhone(w, l, h, tweakMountSurface, sleeveWithCap);
  *translate([-90,0,39]) test_bicycleMount(tweakMountSurface);

  // change sleeveWithCap to T and run with experiment5 to generate Cap
  * translate([0,0,3+l+0.5]) rotate([180,0,0]) sleeveForEncasediPhone(w, l, h, tweakMountSurface, sleeveWithCap);

  // test_generateCatch();
  // test_generateCap();
  // test_generateCapTab(4, 4, 10);
  // test_sleeveMountInsert(tweakMountSurface);

  test_generateCupholder();

}


