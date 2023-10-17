///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2023-Oct-14
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by: MY Iphone bike sleeve holders
//
// Description:
//
//
//
// Revisions/Notes:
//
//   2023-Oct-15: starting
//

//
///////////////////////////////////////////////////////////////////////////////

include <mockup/powerbank_dummy.scad>
use <../libraries/MCAD/2Dshapes.scad>
include <../libraries/local-misc/fillet.scad>

e = 1/128; // small number

// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

RENDER_FOR_PRINT = true;
wall_thickness = 3.2;
wall_gap = 0.75;
base_thickness = 4.0;

module __Customizer_Limit__ () {}

// capture variables from included model
shell_thickness = powerbank__thickness ;
shell_width = powerbank__length;
shell_height = powerbank__height;

sleeve_top_cutoff = button__center_from_top + (1/2)*button__height + 5.5;

sleeve_outer_thicknees = shell_thickness + 2*wall_gap + 2*wall_thickness;
sleeve_outer_width = shell_width + 2*wall_gap + 2*wall_thickness;
sleeve_outer_height = shell_height + 1*base_thickness;

sides_radius = side_corner_radius1 - 1.0;
bottom_corder_radius = 0.60 * face_corner_radius;

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

module sleeve(width = sleeve_outer_width,
              height = sleeve_outer_height,
              thickness = sleeve_outer_thicknees) {

  sleeve_height = height - sleeve_top_cutoff;
  outer_size = [width, thickness, sleeve_height];

  cutout_size = [ width - 2*wall_thickness,
                  thickness - 2*wall_thickness,
                  height - base_thickness + 1*e];

  r = sides_radius;
  corner_r = bottom_corder_radius;
  vertical=[r,r,r,r];
  top=[0,0,0,0];
  bottom=[corner_r,corner_r,corner_r,corner_r];

  difference() {
    cube_fillet(size = outer_size, radius = r,
                vertical=vertical, top=top, bottom=bottom,
                center = false, $fn = 30);

    translate([wall_thickness, wall_thickness, base_thickness])
    cube_fillet(size = cutout_size,  radius = r - 1,
                vertical=vertical, top=top, bottom=bottom,
                center = false, $fn = 30);
  }

  // sleeve mount - add mounting wedge
  mountInsertWidth = 22;
  mountInsertThickness = 3;
  mountInsertHeight = 42;

  // y dimension needs to overlap with sleeve
  mountInsert_yTranslation = thickness-e;

  // y dimension needs to overlap with sleeve
  translate([-mountInsertWidth/2 + (1/2)*width, mountInsert_yTranslation, (0.85) * (sleeve_height - mountInsertHeight)])
    difference() {
    sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, true);

    translate([-e, -e, mountInsertHeight - 1.5])
      cube([mountInsertWidth + 2*e, mountInsertThickness*2 + 2*e, 6]);
  }

}


if (RENDER_FOR_PRINT) {
  sleeve();
 } else {
  wall_pad = wall_gap + wall_thickness;
  %translate([wall_pad,,wall_pad,base_thickness])
    powerbank_dummy();
  sleeve();
 }
