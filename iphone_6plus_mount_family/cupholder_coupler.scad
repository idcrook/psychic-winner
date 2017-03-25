////////////////////////////////////////////////////////////////////////
// Initial Revision: 2017-Mar-25
//
// Author:
//
//   David Crook <dpcrook@users.noreply.github.com>
//
// Description:
//
// A couple that is used to connect between/mount
//   1. sleeve insert on phone holder
//   2. Cupholder top mount shaft end
//
// Revisions/Notes:
//
//  2017-Mar-25: Extracted code from the monolithic file and tweaked based on
//               print feedback to enlarge the sleeve insert hole
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


module generateLidBracketCoupler () {

  coupler_diam = 12.5 - 0.1;
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


module generateLidBracketCoupler2 () {

  coupler_diam = 12.5 - 0.1;
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


module test_generate_coupler() {
  enlargePunchScale = 1.08;

  difference()
  {
    rotate([360-90,0,0])
      generateLidBracketCoupler() ;

    translate([-11, -(0.5)*enlargePunchScale,-20])
      scale([enlargePunchScale, enlargePunchScale, 1], center = false)
      test_sleeveMountInsert (false, 0);
  }
}


module test_generate_coupler2() {
  enlargePunchScale = 1.16;

  { difference()
    {
      rotate([360-90,0,0])
	generateLidBracketCoupler2() ;

      translate([-(1.0)*enlargePunchScale*11, -(e/2)*enlargePunchScale, -20])
	scale([enlargePunchScale, enlargePunchScale, 1], center = false)
	test_sleeveMountInsert (false, 0.0);

    }
  }

}

$fn = 200;

// * rotate([360-90,0,0]) generateLidBracketCoupler() ;
// * test_generate_coupler();

// * rotate([360-90,0,0]) generateLidBracketCoupler2() ;
rotate([90,0,0])  test_generate_coupler2();
