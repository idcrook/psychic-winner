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

use <../libraries/dotSCAD/src/bauer_spiral.scad>
use <../libraries/dotSCAD/src/fibonacci_lattice.scad>
use <../libraries/dotSCAD/src/torus_knot.scad>

include <display_originals.scad>
//   test_1_corona_time_2();

// very small number
e = 1/128;

printer_z_size = (158.0 - 2.0) * mm;


module stem (length = (4/5)*printer_z_size, max_width = 0.8 * inch) {

  half_l = length/2;
  width_taper = (3/4);

  // mirrored halves
  translate([0,0,0])
    mirror([0,0,0])
    cylinder(h = half_l, d1 = max_width, d2 = max_width*width_taper);

  translate([0,0, length-e])
    mirror([0,0,1])
    cylinder(h = half_l, d1 = max_width, d2 = max_width*width_taper);

  /* cyl_w = (4/5)*max_width; */
  /* translate([0,0,0]) */
  /*   hull() { */
  /*   cylinder(h = half_l/10, d = max_width); */
  /*   cylinder(h = half_l, d1 = cyl_w, d2 = cyl_w*width_taper); */
  /* } */

}

module prolate_spheroid (radius = (1/4)*inch, factor = 2.3) {

  scale([1,1,factor])
    sphere(r = radius);

}

module tip (height = (1/5)*printer_z_size, width = 1.5*inch, coupler_w = 1.0*inch) {

  spheroid_r = (1/2) * width/4.5;

  coupler_flare_d = min(1.66*coupler_w, width);

  // generate points on a sphere
  //n = 18;
  //radius = width/3;
  //pts = bauer_spiral(n, radius);
  //pts = fibonacci_lattice(n, radius);

  // generate points in 3D on a torus knot
  pts_scale = (1/8)*width;
  z_scale = 2.1;
  echo ("// tip  height:", height, " width:", width);
  p = 3; q = 7;
  phi_step = 0.1;
  pts = pts_scale * torus_knot(p, q, phi_step);

  // generate 500 random numbers in range (-1 .. 1)
  seed = 42;
  N = 500;
  random_vect = rands(-1,1, N, seed);

  // guide for bounding box of tip; most features should be within
  %linear_extrude(height = height)
     square(1.0*width, center = true);

  translate([0,0,height/2])
    union () {
    cylinder(h = height/2, d1 = coupler_flare_d, d2 = coupler_w);
    //for (p = pts) {
    for (i = [0 : len(pts)-1]) {
      translate([pts[i].x, pts[i].y, z_scale*pts[i].z])
        // skew ellipsoid a random direction
        rotate([random_vect[i]*90, random_vect[i+1]*90, 0])
        prolate_spheroid(radius=spheroid_r, factor=1.80);
    }

  }
}

module spike_model (stem_length = (3/4)*printer_z_size,
                    stem_width = (2/3) * inch,
                    tip_height = (1/4)*printer_z_size,
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

  // spike_model();
  spike_model(stem_length = (3/4)*printer_z_size,
              stem_width = (2/3) * inch,
              tip_height = (1/4)*printer_z_size,
              tip_width = 1.8 * inch);

  if (show_reference) {
    translate([-35, 0])
    test_1_corona_time_2();
  }
}
