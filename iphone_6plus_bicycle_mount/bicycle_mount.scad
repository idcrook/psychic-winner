////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   27-Mar-2016
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
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




module generateCap(cap_arm_thickness, cap_thickness, cap_depth, cap_case_width,
                      power_button_z, mute_switch_z) {

  tolerance = 0.5;

  capCaseWidth = cap_case_width;
  capCapThickness = cap_thickness;
  capArmThickness = cap_arm_thickness;
  capDepth = cap_depth;

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
  //  5. catch, to "lock" carrier into the mount
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
      test_sleeveMountInsert(fitBetter, 50);
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
  printable = false;
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

module test_generateCatch() {
    translate([0, 0, 0])
      rotate([0, 0, 0])
      import ("files/mount_v6-catch.stl");
}




CONTROL_OUTPUT_bicycleMount = true;
// CONTROL_OUTPUT_bicycleMount = false;



$fn = 100;

tweakMountSurface = false;

if (CONTROL_OUTPUT_bicycleMount) {
  translate([-90,0,39]) test_bicycleMount(tweakMountSurface);
}

* test_generateCatch();
