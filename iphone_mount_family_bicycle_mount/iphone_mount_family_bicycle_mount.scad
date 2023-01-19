////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   27-Mar-2016
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Description:
//
//
// Revisions/Notes:
//
//   2023-Jan-19: Update starting from previous design
//
// TODO:
//
//   - use external function for insertion slot (sleeve mount insert)
//
//
////////////////////////////////////////////////////////////////////////


use <files/iPhone_6_and_6_Plus_Mockups.scad>;
use <../libraries/MCAD/2Dshapes.scad>
use <../libraries/local-misc/wedge.scad>

e = 1/128; // small number

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
  elevate_above_frame = 6.0;

  block_x = 33.2 + 0.0 ;        // width of mount
  block_y = 24.0 + elevate_above_frame ; // height of mount above bike frame
  block_z = 39.0 + 0.0 ; // length of mount along frame


  mountInsert_w = mount_insert_w;
  mountInsert_h = 2*mount_insert_thickness;

  mountInsert_position = 50;  // this needs to be manually centered

  enlargePunchScale = 1.08;

  // http://mathworld.wolfram.com/CircularSegment.html
  heightOfArcedPortion = 5.8 + 1.0;  // for particular bicycle's handlebar column
  chordLength = block_x;

  // R = (1/2) (a^2/4h + h)
  radiusOfCurvature = (1/2) * (pow(chordLength,2)/(4*heightOfArcedPortion) + heightOfArcedPortion);

  // r = R - h
  circleCenterDistanceFromCut = radiusOfCurvature - heightOfArcedPortion;

  thicknessOfBandSupport = 3.5 + 0.0;
  //bandCutoutDistanceFromBlock = 10.7 + elevate_above_frame;
  bandCutoutDistanceFromBlock = block_y / 2;

  bandCutoutStartOfNegative = (3/10)*block_z;
  bandCutoutStopOfNegative = (7/10)*block_z;

  difference() {
    linear_extrude(height = block_z, center = false, convexity = 10)
      difference () {
      complexRoundSquare([block_x, block_y],
                         [0,0], [0,0], [0,0], [0,0],
                         center = false);

      //  1. curvature for bike frame (cutout a circle segment)
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
    scale([enlargePunchScale, enlargePunchScale, 1])
      translate([-mountInsert_position + (1/2) * (block_x - (mountInsert_w * enlargePunchScale)) ,
                 (mountInsert_h - enlargePunchScale*mountInsert_h), block_z - mount_insert_h + e])
      test_sleeveMountInsert(fitBetter, mountInsert_position);
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
    //rotate([180,0,0])
    bicycleMount(mountInsertWidth, mountInsertThickness, mountInsertHeight, fitBetter);
}

module test_sleeveMountInsert (fit_better = true, translate_x = 0) {
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

CONTROL_OUTPUT_bicycleMount = true;
// CONTROL_OUTPUT_bicycleMount = false;



$fn = 100;

tweakMountSurface = false;

if (CONTROL_OUTPUT_bicycleMount) {
  // translate([-90,0,39])
  test_bicycleMount(tweakMountSurface);
 }

//%test_sleeveMountInsert ();
