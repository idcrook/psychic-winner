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

// very small number
e = 1/128;

printer_z_size = (157.99) * mm;
full_print_z_size = (2/3)*printer_z_size;
shorten_height = true;
shorten_height_factor = shorten_height ? 0.48 : 1.0;

joint_height = (10/20)*inch * (1/shorten_height_factor);
joint_tolerance = 0.5 * mm;
base_flange_thickness = 1.20*mm * (1/shorten_height_factor);

module base_flange (stem_width = (4/4) * inch, base_thickness = base_flange_thickness) {

  leg_thickness = (1/3)*base_thickness;
  t_z_r = [0,0,base_thickness - leg_thickness];

  R = stem_width/2;
  wing_width = (9/20)*stem_width;
  r = wing_width/2;
  t_x = (R + (9/4)*r);
  t2 = [(t_x - e), (t_x - e), 0];
  total_width = 2*R + 2*r + 2*t_x;
  echo ("// flange approx width (inches):", total_width/inch);

  hull()  {
    linear_extrude(height = base_thickness)
      circle(R, $fn = 50);
    translate(t_z_r)
    linear_extrude(height = leg_thickness)
      translate([cos(120) * t2.x, sin(120) * t2.y, 0]) circle(r);
  }

  hull()  {
    linear_extrude(height = base_thickness)
      circle(R, $fn = 50);
    translate(t_z_r)
    linear_extrude(height = leg_thickness)
      translate([cos(-120) * t2.x, sin(-120) * t2.y, 0]) circle(r);
  }

  hull()  {
    linear_extrude(height = base_thickness)
      circle(R, $fn = 50);
    translate(t_z_r)
    linear_extrude(height = leg_thickness)
      translate([(t_x - e), 0, 0]) circle(r);
  }

  // stepped taper in center
  union() {
    *hull()  {
      translate(t_z_r)
        linear_extrude(height = leg_thickness)
        circle(1.10*R, $fn = 50);
      translate([0,0,-base_thickness+e])
        linear_extrude(height = base_thickness + (base_thickness - leg_thickness))
        circle(1.04*R, $fn = 50);
    }
    hull()  {
      translate([0,0,-base_thickness+e])
        linear_extrude(height = base_thickness)
        circle(1.06*R, $fn = 50);
      translate([0,0,-2*base_thickness])
        linear_extrude(height = 3*base_thickness)
        circle(1.00*R, $fn = 50);
    }
  }
}

// tenon == false is "negative" shape for volume difference
module joint (max_width = 1.0*inch, height = joint_height, tenon = true) {
  tolerance = joint_tolerance;

  diagonal = (1/2) * max_width;
  side_length = diagonal / sqrt(2);
  side   = tenon ? side_length : side_length + 2*tolerance;
  extr_h = tenon ? height : height + 2*tolerance*(1/shorten_height_factor);

  linear_extrude (height = extr_h) {
    square(side, center = true);
  }
}

module stem (length = (2/3)*full_print_z_size, max_width = 1.0 * inch, generate_coupler = false, $fn=50) {

  base_thickness = base_flange_thickness;
  half_l = length/2;
  width_taper = (3/4);

  joint_h = joint_height;

  if (generate_coupler) {
    translate([0,0, length-2*e])
      base_flange(stem_width = max_width, base_thickness = base_thickness);
    translate([0,0, -joint_h+e])
      joint(max_width = max_width, height = joint_h, tenon = true);
  }

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
    sphere(r = radius, $fn = 15);
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
  seed = 41.1828;
  N = 500;
  random_vect = rands(-1, 1, N, seed);

  angle1 = 15;
  rot0_x = -19.5;  // starting offset of rotation
  rot0_y = -45;  // starting offset of rotation
  rot1_x = (90-angle1);  // random rotations +/- this angle
  rot1_y = (90-angle1);  // random rotations +/- this angle

  difference () {
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
    // SUBTRACT
    if (generate_coupler) {
      // empty out the mortise piece
      translate([0,0,height - (joint_height + 2*joint_tolerance) + e])
        joint(max_width = coupler_w, height = joint_height, tenon = false);
      // delete any outcrops that made it through so they don't interfere
      translate([0,0,height])
         cylinder(h = 1*inch, d = coupler_w + 2*joint_tolerance);
    }
  }
}


module tip2 (height = (1/3)*full_print_z_size, width = 2.3*inch, coupler_w = 1.0*inch,
            generate_coupler = false) {

  spheroid_r = (1/2) * width/4;
  coupler_flare_d = min(1.66*coupler_w, width);

  // generate points along a torus knot
  // https://openhome.cc/eGossip/OpenSCAD/lib3x-torus_knot.html
  pts_scale = (1/7.5)*width;
  z_scale = 1.9;
  echo ("// tip  height:", height, " width:", width);
  p = 4; q = 7;
  phi_step = 0.10;
  pts = pts_scale * torus_knot(p, q, phi_step);

  // generate 500 random numbers in range (-1 .. 1)
  seed = 2.71828;
  N = 500;
  random_vect = rands(-1, 1, N, seed);

  angle1 = 5;
  rot0_x = -19.5;  // starting offset of rotation
  rot0_y = -0;  // starting offset of rotation
  rot1_x = (90-angle1);  // random rotations +/- this angle
  rot1_y = (90-angle1);  // random rotations +/- this angle

  difference () {
    intersection () {
      union () {
        // guide for bounding box of tip; most features should be within
        %linear_extrude(height = height)
          square(1.0*width, center = true);
        // prunes outcrops along bottom surface
        translate([0,0, - 0.140*height])
        linear_extrude(height = 1.280*height)
          square(1.280*width, center = true);
      }

      translate([0,0,height/2])
        union () {
        cylinder(h = height/2, d1 = coupler_flare_d, d2 = coupler_w);
        for (i = [0 : len(pts)-1]) {
          translate([pts[i].x, pts[i].y, z_scale*pts[i].z])
            // rotate ellipsoid in random orientation
            rotate([rot0_x +  rot1_x*random_vect[i*2], rot0_y + rot1_y*random_vect[i*2+1], 0])
            prolate_spheroid(radius=spheroid_r, factor=1.8);
        }
      }
    }
    // SUBTRACT
    if (generate_coupler) {
      // empty out the mortise piece
      translate([0,0,height - (joint_height + 2*joint_tolerance) + e])
        joint(max_width = coupler_w, height = joint_height, tenon = false);
      // delete any outcrops that made it through so they don't interfere
      translate([0,0,height])
         cylinder(h = 1*inch, d = coupler_w + 2*joint_tolerance);
    }
  }
}

module spike_model (stem_length = (2/3)*full_print_z_size,
                    stem_width = (2/3) * inch,
                    tip_height = (1/3)*full_print_z_size,
                    tip_width = 1.8 * inch, two_parts = true) {
  if (!two_parts) {
    assert(printer_z_size >= (stem_length + tip_height));
  }

  print_stem = two_parts ? true : false;
  print_tip = !print_stem;

  tip_coupler_width = stem_width;

  if (two_parts) {
    if (print_stem) {
      translate([70,0,stem_length + base_flange_thickness])
        rotate([0, 180, 0])
        stem (length = stem_length, max_width = stem_width, generate_coupler = true);
    }
    if (print_tip) {
      //tip (height = tip_height, width = tip_width, coupler_w = tip_coupler_width, generate_coupler = true);
      tip2 (height = 0.8*tip_height, width = 0.8*tip_width, coupler_w = tip_coupler_width, generate_coupler = true);
    }
  } else {
    translate([0,0,tip_height - e])
      stem (length = stem_length, max_width = stem_width);
    tip (height = tip_height, width = tip_width, coupler_w = tip_coupler_width);
  }
}


// $preview requires version 2019.05
$fn = $preview ? 20 : 50;

show_references = false;
model_base_flange = false;

if (DEVELOPING_spike_model)  {

  stem_proportion = (3/5);
  tip_proportion = 1 - stem_proportion;

  // spike_model();
  scale([1.0, 1.0, shorten_height_factor])
    spike_model(stem_length = stem_proportion * full_print_z_size,
                stem_width = (8/9) * inch,
                tip_height = tip_proportion * full_print_z_size,
                tip_width = 2.3 * inch,
                two_parts = true);

  if (model_base_flange) {
    scale([1.0, 1.0, shorten_height_factor])
    translate([105, 0])
      base_flange(stem_width = (8/9) * inch, base_thickness = base_flange_thickness);
  }

  if (show_references) {
    translate([-35, 0])
    test_1_corona_time_2();
  }
}
