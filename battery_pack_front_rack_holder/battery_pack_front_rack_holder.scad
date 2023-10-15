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
wall_thickness = 3.5;
wall_gap = 2.0;
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


module sleeve(width = sleeve_outer_width,
              height = sleeve_outer_height,
              thickness = sleeve_outer_thicknees) {

  outer_size = [width, thickness, height - sleeve_top_cutoff];

  cutout_size = [ width - 2*wall_thickness,
                  thickness - 2*wall_thickness,
                  height - base_thickness + 1*e];

  r = 2.5;
  corner_r = 5.0;
  vertical=[r,r,r,r];
  top=[0,0,0,0];
  bottom=[corner_r,corner_r,corner_r,corner_r];

  difference() {
    cube_fillet(size = outer_size, radius = 2.5,
                vertical=vertical, top=top, bottom=bottom,
                center = false, $fn = 30);

    translate([wall_thickness, wall_thickness, base_thickness])
    cube_fillet(size = cutout_size,  radius = 2.5,
                vertical=vertical, top=top, bottom=bottom,
                center = false, $fn = 30);
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
