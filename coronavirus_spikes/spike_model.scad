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
DEVELOPING_spike_model = true;

include <MCAD/units.scad>
use <MCAD/2Dshapes.scad>

use <../libraries/dotSCAD/src/torus_knot.scad>

include <display_originals.scad>
//   test_1_corona_time_2();

// very small number
e = 1/128;

printer_z_size = (157.99) * mm;
full_print_z_size = (2/3)*printer_z_size;

module stem (length = (2/3)*full_print_z_size, max_width = 1.0 * inch, generate_coupler = false) {

  half_l = length/2;
  width_taper = (3/4);

  // mirrored halves, form stem
  translate([0,0,0])
    mirror([0,0,0])
    cylinder(h = half_l, d1 = max_width, d2 = max_width*width_taper);

  translate([0,0, length-e])
    mirror([0,0,1])
    cylinder(h = half_l, d1 = max_width, d2 = max_width*width_taper);
}

module prolate_spheroid (radius = (1/4)*inch, factor = 2.3) {
  scale([1,1,factor])
    sphere(r = radius, $fn = 14);
}

module tip (height = (1/3)*full_print_z_size, width = 2.3*inch, coupler_w = 1.0*inch,
            generate_coupler = false) {

  spheroid_r = (1/2) * width/4;

  coupler_flare_d = min(1.66*coupler_w, width);

  // generate points along a torus knot
  // https://openhome.cc/eGossip/OpenSCAD/lib3x-torus_knot.html
  pts_scale = (1/8)*width;
  z_scale = 1.60;
  echo ("// tip  height:", height, " width:", width);
  p = 5; q = 7;
  phi_step = 0.11;
  pts = pts_scale * torus_knot(p, q, phi_step);

  // generate 500 random numbers in range (-1 .. 1)
  seed = 44.71828;
  N = 500;
  random_vect = rands(-1, 1, N, seed);

  angle1 = 15;
  rot0_x = -19.5;  // starting offset of rotation
  rot0_y = -45;  // starting offset of rotation
  rot1_x = (90-angle1);  // random rotations +/- this angle
  rot1_y = (90-angle1);  // random rotations +/- this angle

  intersection () {
    union () {
      // guide for bounding box of tip; most features should be within
      %linear_extrude(height = height)
        square(1.0*width, center = true);
      // prunes outcrops along bottom surface
      linear_extrude(height = 1.2*height)
        square(1.2*width, center = true);
    }

    translate([0,0,height/2])
      union () {
      cylinder(h = height/2, d1 = coupler_flare_d, d2 = coupler_w);
      for (i = [0 : len(pts)-1]) {
        translate([pts[i].x, pts[i].y, z_scale*pts[i].z])
          // rotate ellipsoid in random orientation
          rotate([rot0_x +  rot1_x*random_vect[i*2], rot0_y + rot1_y*random_vect[i*2+1], 0])
          prolate_spheroid(radius=spheroid_r, factor=1.75);
      }
    }
  }
}

module spike_model (stem_length = (2/3)*full_print_z_size,
                    stem_width = (2/3) * inch,
                    tip_height = (1/3)*full_print_z_size,
                    tip_width = 1.8 * inch) {

  assert(printer_z_size >= (stem_length + tip_height));

  tip_coupler_width = stem_width;

  translate([0,0,tip_height - e])
  stem (length = stem_length, max_width = stem_width);
  tip (height = tip_height, width = tip_width, coupler_w = tip_coupler_width);

}


// $preview requires version 2019.05
$fn = $preview ? 20 : 50;

show_reference = false;

if (DEVELOPING_spike_model)  {

  stem_proportion = (3/5);
  tip_proportion = 1 - stem_proportion;

  // spike_model();
  spike_model(stem_length = stem_proportion * full_print_z_size,
              stem_width = (4/4) * inch,
              tip_height = tip_proportion * full_print_z_size,
              tip_width = 2.3 * inch);

  if (show_reference) {
    translate([-35, 0])
    test_1_corona_time_2();
  }
}
