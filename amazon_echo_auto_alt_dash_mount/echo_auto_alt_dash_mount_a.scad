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
//   Alternative dash mount for Echo Auto
//
// Revisions/Notes:
//
//
////////////////////////////////////////////////////////////////////////

// contains dimensional model of Echo Auto
use <model_echo_auto.scad>

/* use <MCAD/2Dshapes.scad> */
/* use <../psychic-winner/MCAD/2Dshapes.scad> */
use <2Dshapes.scad>
use <../../libraries/scad-utils/morphology.scad>

e = 0.02; // small number


auto_length = 85.0;
auto_depth = 47.0;
auto_height = 12.85;
mount_thickness = 2.0;


// TBD!
module dash_mount_a (length = auto_length, width = auto_depth, height = auto_height) {

  echo ("dash_mount_a ", length, width, height);
  center = [width/2, length/2];
  thickness = 2*6.0;

  driver_side_arc(center = center, chord_length = width, arc_thickness = thickness, height = mount_thickness);

}


module driver_side_arc (center, chord_length, arc_thickness, height) {

  echo ("driver_side_arc ", center, chord_length, arc_thickness, height);
  arc_trace_thickness = 4.5;

  thickness = arc_thickness /2;

  // http://mathworld.wolfram.com/IsoscelesTriangle.html
  radius = sqrt(pow(center.x/2, 2) + pow(center.y,2));

  // http://mathworld.wolfram.com/CircularSegment.html
  theta = 2 * asin(chord_length / (2*radius));
  inset = thickness - (1/2)*(radius - center.y);
  echo("theta:", theta, "R:", radius, "inset:", inset);


  inner_size = radius - thickness;
  outer_size = radius + thickness;
  start_angle = 270 - (theta/2);
  end_angle =   270 + (theta/2);
  echo (inner_size, outer_size, start_angle, end_angle);


  translate([0, -thickness/2, 0])
    linear_extrude(height=height)
    union ()
  {
    shell(d=-arc_trace_thickness)
    translate([center.x, center.y, 0])
      donutSlice(innerSize = inner_size, outerSize = outer_size, start_angle = start_angle, end_angle= end_angle);
    translate([0, inset, 0])
      circle(r=thickness);
    translate([chord_length, inset, 0])
      circle(r=thickness);
  }


}

showEchoAuto = false;
showEchoAuto = true;

$fn = $preview ? 12 : 100;

if (showEchoAuto) {
  if ($preview) {
    #translate([0,0,mount_thickness + 2*e])
      modelEchoAuto();
  } else {
    // does not get rendered
    %translate([0,0,mount_thickness + 2*e])
      modelEchoAuto();
  }
} else {
  translate([0,0,20])
    modelEchoAuto();
}

dash_mount_a();
