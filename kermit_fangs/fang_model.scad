/*

  Modeled by David Crook - https://github.com/idcrook

  2022-Sep-02

  Thingiverse: http://www.thingiverse.com/thing:TBD/

  GitHub: https://github.com/idcrook/psychic-winner/tree/main/

  NOTES:

  - See README.md for other notes.
*/

// * All measurements in millimeters * //

// If true, model is instantiated by this file
DEVELOPING_fang_model = true;

// If true, print base. Change this to false to print tip for two parts.
PRINT_STEM = true;

// Shorten the base when true. This is recommended.
shorten_height = true;

include <../libraries/MCAD/units.scad>
use <../libraries/MCAD/2Dshapes.scad>

use <../libraries/dotSCAD/src/torus_knot.scad>

include <display_originals.scad>

// very small number
e = 1/128;

printer_z_size = (157.99) * mm;
full_print_z_size = (2/3)*printer_z_size;
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
  t_x = (R + (1/8)*r);
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

  // stepped taper in center from above  below
  union() {
    hull()  {
      translate([0,0,-(0.5)*base_thickness+e])
        linear_extrude(height = (1/2)*base_thickness)
        circle(1.06*R, $fn = 50);
      translate([0,0,-(1.0)*base_thickness])
        linear_extrude(height = (1/2)*base_thickness)
        circle(1.00*R, $fn = 50);
    }
  }
}

module stem (length = (2/3)*full_print_z_size, max_width = 1.0 * inch, $fn=50) {

  base_thickness = base_flange_thickness;
  half_l = length/2;
  width_taper = (3/4);

  joint_h = joint_height;

  translate([0,0, length-2*e])
    base_flange(stem_width = max_width, base_thickness = base_thickness);

  // pointy bit
  translate([0,0, length-e])
    mirror([0,0,1])
    cylinder(h = half_l, d1 = max_width, d2 = 2 * mm);
}


module fang_model (stem_length = (2/3)*full_print_z_size,
                    stem_width = (2/3) * inch,
                    tip_height = (1/3)*full_print_z_size,
                    tip_width = 1.8 * inch) {

  assert(printer_z_size >= (stem_length + tip_height));

  translate([70,0,stem_length + base_flange_thickness])
    rotate([0, 180, 0])
    stem (length = stem_length, max_width = stem_width);
}


// $preview requires version 2019.05
$fn = $preview ? 20 : 50;

show_references = false;
model_base_flange = false;

if (DEVELOPING_fang_model)  {

  stem_proportion = (3/5);
  tip_proportion = 1 - stem_proportion;

  // fang_model();
  scale([1.0, 1.0, shorten_height_factor])
    fang_model(stem_length = 2 * 1.5 * inch,
                stem_width = 23 * mm,
                tip_height = tip_proportion * full_print_z_size,
                tip_width = 2.3 * inch);

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
