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
//   Alternative dash mount for Echo Auto - Cross bars are "y" shaped
//
// Revisions/Notes:
//
//   - Requires OpenSCAD 2019.5 features (let(), $preview, e.g.)
//
//
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


module dash_mount_a (length = auto_length, width = auto_depth, height = auto_height) {

  echo ("dash_mount_a ", length, width, height);
  center = [width/2, length/2];
  arc_width = 2*6.0;
  bar_width = (1/2)*arc_width;

  bracket_size = 10.0;
  bracket_thickness = 3.5;

  driver_side_arc(center = center, chord_length = width, arc_thickness = arc_width, height = mount_thickness);

  corner_brackets(auto_length = length, auto_width = width, bracket_size = bracket_size, thickness = bracket_thickness);

  crossbars(auto_length = length, auto_width = width, bar_width = bar_width,  thickness = mount_thickness);
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



module  corner_brackets(auto_length, auto_width, bracket_size, thickness) {

  origin = [0.0, 0.0];
  bracket_height = auto_height + mount_thickness + thickness;

  // amount that center of corner block should be positioned toward Echo Auto
  overhang = 2;
  z_enlarge_for_fit = 1.05;

  corner_positions = [[origin.x + overhang,              origin.y + overhang],
                      [origin.x + auto_width - overhang, origin.y + overhang],
                      [origin.x + overhang,              origin.y + auto_length - overhang]];

  cornerColor ="#808000";

  // form by putting a "block" on each corner, then subtracting out Echo Auto profile
  difference () {
    union () {
      // three corners
      for (pos = corner_positions) {
      color(cornerColor)
        translate([pos[0], pos[1], 0])
        // the call should be pre-positioned at the center of the corner
        drawCorner(size = bracket_size, height = bracket_height, thickness = thickness);
      }
    }
    translate([0,0,mount_thickness ])
      if ($preview) {
        scale([1,1,z_enlarge_for_fit])
          modelEchoAuto();
      } else {
        // the convex hull() function here eliminates reliefs/holes on the
        // surface and smooths them (only done for render since it is computationally expensive)
        hull () {
          scale([1,1,z_enlarge_for_fit])
            modelEchoAuto();
        }
      }
  }

}


module drawCorner(size, height, thickness) {

  rounded_size = 2;
  square_size = size - rounded_size;

  linear_extrude(height = height)
  minkowski() {
    square(square_size, center=true);
    circle(r = rounded_size);
  }
}


module  crossbars(auto_length, auto_width, bar_width, thickness, near_center_hole = true) {

  echo("crossbars: (", auto_length, auto_width, bar_width, thickness, ")");

  origin = [0,0];
  center = [auto_width/2, auto_length/2];

  // trace out a shape that is like the letter "y"
  crossbars_points = [
    [origin.x, origin.y],
    [origin.x + auto_width, origin.y],
    [center.x -e, center.y - e],
    [center.x +e, center.y + e],
    [origin.x, origin.y + auto_length]];

  order = [[1,2,0,3,4]];
  echo ("points ", crossbars_points);

  difference () {
    linear_extrude(height = thickness) {
      offset(r=bar_width/2) {
        polygon(points = crossbars_points, paths = order);
      }
    }
    if (near_center_hole) {
        translate ([center.x, center.y - 1.5, -e]) {
          linear_extrude(height = thickness + 2*e) {
            circle(r=0.75);
          }
        }
    }
  }


}


//showEchoAuto = false;
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
