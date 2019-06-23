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

  // used for generating rough outline
  depth_prism = depth - (2 * ext_height_side_cylinder_center_inset );

  // top buttons
  top_button_diameter = 16.6;
  top_button_side_offset =  depth / 2;
  top_button_edge_offset =  12.0;
  top_button_depth = 1.2;

  difference () {
    echoAutoRoughShell(length, depth_prism, height_shell, ext_height_bumper, ext_height_side_radius);

    // top buttons
    // TODO: eight holes on top surface
    translate([0,0, ext_height])
    topButtonsOutline(length, top_button_side_offset, top_button_edge_offset,
                        top_button_diameter /2, top_button_depth);

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
  // contructed as rectangular solid prism with semi-circle cylinders along
  // each long side
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

// subtractive volumes for top buttons
module topButtonsOutline (echo_length, side_offset, edge_offset, button_radius, button_depth) {

  // "Microphone off" button
  translate([side_offset, edge_offset + button_radius, 0])  // position to center of circle/sphere
    resize(newsize=2*[button_radius, button_radius, button_depth])
    sphere(r=button_radius);

  // "Action" button (with a circular bump in center)
  translate([side_offset, echo_length - (edge_offset + button_radius), 0])  // position to center of circle/sphere
    difference ()
  {
    resize(newsize=2*[button_radius, button_radius, button_depth])
      sphere(r=button_radius);

    // make the bump by subtracting out of the difference volume :)
    translate([0, 0, -button_depth])
    linear_extrude(height=(1/3) * button_depth)
      circle(r=button_radius/7);

  }

}

$fn = $preview ? 30 : 100;
modelEchoAuto();
