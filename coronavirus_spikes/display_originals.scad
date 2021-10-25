/*



  Modeled by David Crook - https://github.com/idcrook

  2021-Oct-25

  Thingiverse: http://www.thingiverse.com/thing:TBD/

  GitHub: https://github.com/idcrook/psychic-winner/tree/main/

  NOTES:

  - See README.md for other notes.
*/

// * All measurements in millimeters * //

// If true, model is instantiated by this file
DEVELOPING_model = false;

use <MCAD/2Dshapes.scad>

use <../libraries/dotSCAD/src/rounded_square.scad>

// very small number
e = 1/128;

module test_1_corona_time_2 () {
  start_pos = [10, 10];

  // bunch of spheres
  its_offset = [31, 30.4];
  print_scale = [3.1431, 3.1431, 16.763];
  z_height_scaled = 9.4 * print_scale.z;
  translate([0,0,z_height_scaled])
  rotate([180,0,0])
    scale(print_scale)
    translate([its_offset.x, its_offset.y])

    import("files/corona_time_2.stl");
}


module display_originals () {

  start_pos = [10, 10];

  // 3d contours
  translate([start_pos.x + 0, start_pos.y + 0])
    rotate([])
    import("files/Spike.stl");

  // simple end tapered to spheres
  z_offset = 16.73;
  translate([start_pos.x + 15, start_pos.y + 0, - z_offset])
    rotate([])
    import("files/SpikeProtein.stl");

  // bunch of spheres
  its_offset = [30, 30];
  translate([start_pos.x + 30 + its_offset.x, start_pos.y + 0 + its_offset.y])
    rotate([])
    import("files/corona_time_2.stl");

}


// $preview requires version 2019.05
$fn = $preview ? 50 : 100;

if (DEVELOPING_model)  {
  display_originals();
  test_1_corona_time_2();
}
