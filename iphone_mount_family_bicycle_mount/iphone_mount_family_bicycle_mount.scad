////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////


use <files/iPhone_6_and_6_Plus_Mockups.scad>;
use <../libraries/MCAD/2Dshapes.scad>
use <../libraries/local-misc/wedge.scad>

// Width across for mount (should not be wider than handlebar column)
Width_Of_Mount = 30.8;

// Curvature for particular bicycle's handlebar column
Height_Of_Arced_Portion = 10.0;

// Tilt angle wrt frame. Should be small (0-15) positive angle, expressed in degrees
tilt_angle = 0;

// Additional height above bike frame from default
elevate_above_frame = 4.0;

// How much to overlap bottom of tongue on slot insert (shouldn't need to change)
mount_insert_shift = 0.0;

module __Customizer_Limit__ () {}

e = 1/128; // small number

tolerance = 0.5;

module sleeveMountInsert (width, thickness, height, shouldTweak) {

  insertTailWidth = width;
  insertThickness = 2*thickness;
  insertChopThickness = thickness;
  insertFullHeight = height;

  insertPartialHeight = 25.0 ;
  insertSlantedHeight = insertFullHeight - insertPartialHeight;
  insertSlantAngle = 62;
  insertSlantAngle2 = 65;

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
  block_x = Width_Of_Mount;        // width of mount
  block_y = 24.0 + elevate_above_frame ; // height of mount above bike frame
  block_z = 39.0 + 0.0 ; // length of mount along frame

  mountInsert_w = mount_insert_w;
  mountInsert_h = 2*mount_insert_thickness;

  mountInsert_position = 0;  // this needs to be manually centered

  enlargePunchScale = 1.08;

  // http://mathworld.wolfram.com/CircularSegment.html
  heightOfArcedPortion = Height_Of_Arced_Portion ;  // for particular bicycle's handlebar column

  chordLength = block_x;

  // R = (1/2) (a^2/4h + h)
  radiusOfCurvature = (1/2) * (pow(chordLength,2)/(4*heightOfArcedPortion) + heightOfArcedPortion);

  // r = R - h
  circleCenterDistanceFromCut = radiusOfCurvature - heightOfArcedPortion;

  thicknessOfBandSupport = 4.5;
  bandCutoutDistanceFromBlock = block_y / 2 - (3/5) * thicknessOfBandSupport;

  bandCutoutStartOfNegative = (3/10)*block_z;
  bandCutoutStopOfNegative = (7/10)*block_z;

  //angle_height_adjust = block_z * sin(tilt_angle) * 0;

  difference() {
    union() {
      linear_extrude(height = block_z, center = false, convexity = 10)
        difference () {
        complexRoundSquare([block_x, block_y],
                           [0,0], [0,0], [0,0], [0,0],
                           center = false);

        //  1. curvature for bike frame (cutout a circle segment)
        translate([block_x/2, block_y + circleCenterDistanceFromCut,0])
          circle(r= radiusOfCurvature);
      }
      translate([0, e, 0])
        rotate([tilt_angle, 0, 0])
        linear_extrude(height = block_z , center = false, convexity = 10)
        complexRoundSquare([block_x, mountInsert_h + 3 * block_z * (1 - cos(tilt_angle))],
                           [0,0], [0,0], [0,0], [0,0],
                           center = false);

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
    translate_y = (mountInsert_h - enlargePunchScale*mountInsert_h);

    scale([enlargePunchScale, enlargePunchScale, 1])
      translate([-mountInsert_position + (1/2) * (block_x - (mountInsert_w * enlargePunchScale)) - tolerance ,
                 translate_y , block_z - mount_insert_h + mount_insert_shift + e])
      translate([0, -e, 0])
      rotate([tilt_angle, 0, 0])
      test_sleeveMountInsert(fitBetter, mountInsert_position);
  }
}


module test_bicycleMount(fit_better) {
  mountInsertWidth = 22;
  mountInsertThickness = 3;
  mountInsertHeight = 42;

  fitBetter = fit_better;

  translate([0, 0, 0])
    bicycleMount(mountInsertWidth, mountInsertThickness, mountInsertHeight, fitBetter);
}


module test_sleeveMountInsert (fit_better = true, translate_x = 0) {
  mountInsertWidth = 22;
  mountInsertThickness = 3;
  mountInsertHeight = 42;

  fitBetter = fit_better;

  translate([translate_x, 0, 0])
    sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, fitBetter);
}


CONTROL_OUTPUT_bicycleMount = true;

$fn = 100;

tweakMountSurface = true;

if (CONTROL_OUTPUT_bicycleMount) {
  // translate([-90,0,39])
  test_bicycleMount(tweakMountSurface);
 }

//%test_sleeveMountInsert (true, 6);
