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


  // light bar
  light_bar_length = 76.0;
  light_bar_height = 2.0;
  light_bar_edge_offset = (length - light_bar_length) / 2.0;

  // driver side side port
  side_port_length = 35.0;
  side_port_height = 1.0;
  side_port_edge_offset = (depth - side_port_length) / 2.0;
  side_port_edge_height = ext_height_bumper + (height_shell/2);
  side_port_depth = 1.2;

  // passenger side ports
  aux_port_diameter = 5.0;
  aux_port_height_from_base = 3.4;
  aux_port_inset_from_side = 4.5;
  microb_port_width = 8.2;
  microb_port_height = 3.6;
  microb_port_height_from_base = 5.0;
  microb_port_inset_from_side = 19.4;

  // bottom contours
  bottom_cutout_length = 33.0;
  bottom_cutout_height = 3.2;
  bottom_cutout_corner_radius = 4.0;
  bottom_semicircle_height = bottom_cutout_height;
  bottom_semicircle_radius = 15.0/2 ;
  bottom_semicircle_center_offset = 1.0;

  // bottom bumpers - see addBottomBumpers() for additional placement information
  bottom_bumper_height = ext_height_bumper;
  bottom_bumper_short_side_offset = 6.0;
  bottom_bumper_edge_to_edge_distance = 34.0;

  // color("#08080880")
  difference () {
    echoAutoRoughShell(length, depth_prism, height_shell, ext_height_bumper, ext_height_side_radius);


    // top buttons (subtractive)
    translate([0,0, ext_height])
    topButtons(length, top_button_side_offset, top_button_edge_offset,
               top_button_diameter /2, top_button_depth);

    // FIXME: eight holes on top surface

    // light bar outline (subtractive)
    // light_bar_height subtracted since lightbar itselfis completely below mid-line
    translate([depth, 0, ((1/2)*ext_height) - (light_bar_height) ])
      rotate(a=[90, 0, 90])
      frontLightBar(length = light_bar_length,
                    height = light_bar_height,
                    edge_offset = light_bar_edge_offset );

    // driver-side port (subtractive)
    translate([0, 0, 0])
      rotate(a=[0, 0, 0])
      driversSidePort(length = side_port_length,
                      height = side_port_height,
                      edge_height = side_port_edge_height,
                      edge_offset = side_port_edge_offset,
                      depth =  side_port_depth );

    // passenger-side ports (subtractive)
    // TODO: microB, aux jack keepouts
    translate([0, length, 0])
      rotate(a=[90, 0, 0])
      passengersSidePorts(aux_diameter = aux_port_diameter,
                          usb_width = microb_port_width,
                          usb_height = microb_port_height,
                          aux_height_from = aux_port_height_from_base,
                          aux_inset_from = aux_port_inset_from_side,
                          usb_height_from = microb_port_height_from_base,
                          usb_inset_from = microb_port_inset_from_side);

    // bottom cutouts (subtractive)
    translate([0, 0, ext_height_bumper])
      rotate(a=[0, 0, 0])
      bottomMountCutouts(length = length,
                         width = depth,
                         cutout_square_width = bottom_cutout_length,
                         cutout_square_depth = bottom_cutout_height,
                         cutout_square_corner_radius  = bottom_cutout_corner_radius,
                         cutout_circle_radius = bottom_semicircle_radius,
                         cutout_circle_depth = bottom_semicircle_height,
                         cutout_circle_center_offset = bottom_semicircle_center_offset);

  }

  if (true) {
    addBottomBumpers(length = length,
                     width = depth,
                     bumper_height = bottom_bumper_height,
                     short_edge_offset = bottom_bumper_short_side_offset,
                     outside_distance = bottom_bumper_edge_to_edge_distance);
  }

}




// Rough outline of the Echo Auto
module echoAutoRoughShell (length, depth, height, height_bumpers, side_radius) {

  shellColor = "#080808A8";

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
module topButtons (echo_length, side_offset, edge_offset, button_radius, button_depth) {

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
    linear_extrude(height=(1/4) * button_depth)
      circle(r=button_radius/7);
  }

}

// subtractive volumes for front side (light bar side) features
module frontLightBar (length, height, edge_offset) {

  inset = 0.3;

  echo("frontLightBar", length, height, edge_offset);
  translate([edge_offset, 0, -inset])
    linear_extrude(height=inset)
    square([length, height], center=false);
}

// subtractive volume for drivers side port
module driversSidePort (length, height, edge_height, edge_offset, depth) {

  echo("driversSidePort", length, height, edge_height, edge_offset, depth);
  translate([edge_offset, -e, edge_height - (1/2)*height])
    linear_extrude(height=depth)
    square([length, height], center=false);
}

// subtractive volume for passengers side ports
module passengersSidePorts (aux_diameter, usb_width, usb_height,
                            aux_height_from, aux_inset_from, usb_height_from, usb_inset_from ) {

  aux_radius = (aux_diameter / 2);
  hole_depth = 10.0;

  echo("passengersSidePorts", aux_diameter, usb_width, usb_height);
  echo("passengersSidePorts placement",  aux_height_from, aux_inset_from, usb_height_from, usb_inset_from);

  // aux port
  translate([aux_inset_from + aux_radius, aux_height_from + aux_radius, -e])
    linear_extrude(height=hole_depth)
    circle(r=aux_radius);

  // microUSB B port
  translate([usb_inset_from, usb_height_from, -e])
    linear_extrude(height=hole_depth)
    square([usb_width, usb_height]);


}


module bottomMountCutouts(length, width, cutout_square_width, cutout_square_depth, cutout_square_corner_radius,
                         cutout_circle_radius , cutout_circle_depth , cutout_circle_center_offset ) {

  center_x_pos = (1/2)*(width - cutout_square_width + cutout_square_width);
  center_y_pos = (1/2)*(length - cutout_square_width + cutout_square_width) ;

  // square cutout
  translate([center_x_pos, center_y_pos, -e])  // position to center of rounded rect
    linear_extrude(height = cutout_square_depth)
    roundedSquare(pos=[cutout_square_width, cutout_square_width], r=cutout_square_corner_radius);

  x_pos = center_x_pos;
  y_pos = center_y_pos + (1/2)*cutout_square_width - cutout_circle_center_offset ;

  // hemisperical groove
  translate([x_pos, y_pos, 0])  // position to center of circle/sphere
    resize(newsize=2*[cutout_circle_radius, cutout_circle_radius + cutout_circle_center_offset, cutout_circle_depth])
    sphere(r=cutout_circle_radius);


}

module addBottomBumpers(length, width, bumper_height, short_edge_offset, outside_distance) {

  long_side = 18.5;
  half_long_side = (1/2)*long_side ;
  short_side = 5.5;
  half_short_side = (1/2)*short_side ;

  outside_offset = (1/2) * (width - outside_distance);
  otherside_offset = width - outside_offset;
  farside_pos = length - short_edge_offset;

  positions = [[otherside_offset - half_short_side, short_edge_offset + half_long_side],
               [outside_offset   + half_short_side, short_edge_offset + half_long_side],
               [otherside_offset - half_short_side, farside_pos - half_long_side],
               [outside_offset   + half_short_side, farside_pos - half_long_side]];

  bumperColor = "DimGray";

  echo("addBottomBumpers", length, width, bumper_height, short_edge_offset, outside_distance);

  // four bumpers
  for (i = [0:3]) {
    let (pos = positions[i]) {
      color(bumperColor)
      translate([pos[0], pos[1], 0])
        // the call should be pre-positioned at the center of the bumper
        drawBumper(height = bumper_height, short_side = short_side, long_side = long_side);
    }
  }

}


module drawBumper(height, short_side, long_side) {

  r = short_side/2;
  end_translate = (1/2)*long_side - r;



  linear_extrude(height = height)
    union ()
  {
    square([short_side, long_side - 2*r], center=true);
    translate([0,-end_translate,0])
      circle(r=r);
    translate([0, end_translate,0])
      circle(r=r);
  }



}

$fn = $preview ? 30 : 100;
modelEchoAuto();
