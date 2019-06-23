////////////////////////////////////////////////////////////////////////
// Initial Revision:
//  2019-Jun-23
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
//   -
//
// Description:
//
//   Echo Auto, to be used as dimensional model:
//    https://www.amazon.com/Introducing-Echo-Auto-first-your/dp/B0753K4CWG
//
// Revisions/Notes:
//
//
////////////////////////////////////////////////////////////////////////


use <MCAD/2Dshapes.scad>
use <../libraries/wedge.scad>

e = 0.02; // small number


// Measurements, as positioned on dash mount (expressed in millimeters)
//
//  - Length 85.0 mm
//  - Depth  47.0 mm
//  - Height (shell) 12.85 mm
//  - Height (including bumpers) ~13.0-13.5 mm

ext_length = 85.0;
ext_depth = 47.0;
ext_height = 12.85;

module modelEchoAuto (length = ext_length, depth = ext_depth, height_shell = ext_height) {

  ext_height_bumper = 0.15;
  ext_height = height_shell + ext_height_bumper;
  ext_height_side_radius = (height_shell / 2);
  ext_height_side_cylinder_center_inset = ext_height_side_radius;

  depth_prism = depth - (2 * ext_height_side_cylinder_center_inset );

  difference () {
    echoAutoRoughShell(length, depth_prism, height_shell, ext_height_bumper, ext_height_side_radius);
    // TODO: top buttons
    // TODO: USB microB, aux jack
    // TODO: Front light bar
    // TODO: side slit
  }


  // TODO: bottom mount and bumber contours
  // TODO: USB microB, aux jack keepouts
}

// Rough outline of the Echo Auto
module echoAutoRoughShell (length, depth, height, height_bumpers, side_radius) {

  shellColor = "#080808A0";

   // case outer dimensions
  union () {
    // body block
    color (shellColor)
      translate([side_radius, 0, height_bumpers])
      cube([depth, length, height], center = false);

    // semicircular solid along one side
    color (shellColor)
      rotate(a = [0, 270, 270])
      translate([side_radius + height_bumpers,
                 side_radius, 0])
      linear_extrude(height = length)
    {
      circle(r=side_radius);
    }

    // semicircular solid along other side
    color (shellColor)
      rotate(a = [0, 270, 270])
      translate([side_radius + height_bumpers,
                 side_radius + depth, 0])
      linear_extrude(height = length)
    {
      circle(r=side_radius);
    }
  }

}


$fn = 100;
modelEchoAuto();
