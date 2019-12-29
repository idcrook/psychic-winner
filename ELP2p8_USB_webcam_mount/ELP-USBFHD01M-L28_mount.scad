///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2019-Dec-28
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//
//
// Revisions/Notes:
//
//   2019-Dec-28: Initial PCB dimensions
//
//   2019-Dec-28: First draft mount
//
///////////////////////////////////////////////////////////////////////////////

include <mockup/elp_usbfhd01m_l28_dummy.scad>
use <MCAD/2Dshapes.scad>

e = 1/128; // small number

// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

RENDER_FOR_PRINT = false;
SHOW_CAMERA = RENDER_FOR_PRINT ? false : true;

// capture variables from included model
camera_pcb_thickness = pcb_thickness;
camera_pcb_length = pcb_length;
camera_pcb_spacer_side_length = keepout_spacer_side;
camera_pcb_pad_thickness = pcb_keepout_back;
camera_pcb_castelated_from_x = 6.5;

case_sidewall_thickness = 2.0;
case_sidewall_tol = 0.12;
case_backwall_thickness = case_sidewall_thickness + 1;
case_screwpad_height = pcb_keepout_back;

backside_mount_exterior_length = 2*(case_sidewall_thickness + case_sidewall_tol) + camera_pcb_length;  // x dim
backside_mount_exterior_width = 2*(case_sidewall_thickness + case_sidewall_tol) + camera_pcb_length;  // y dim
backside_mount_exterior_height = camera_pcb_thickness + case_screwpad_height + case_backwall_thickness; // z dims

backside_mount_side_cutout_length = camera_pcb_length - (2 * camera_pcb_castelated_from_x);
backside_mount_side_cutout_offset = (0*case_sidewall_thickness + camera_pcb_castelated_from_x);

usb_cutout_length = usb_connector_length + 1; // +1 after test_print1
usb_cutout_width = usb_connector_width;
usb_cutout_height = backside_mount_exterior_height;

pad_screw_fudge_radius = 0.19;
pad_screw_hole_diameter = hole_diameter + 2*pad_screw_fudge_radius;
pad_screw_hole_spacing = hole_spacing;
pad_screw_hole_pos_x = hole_pos_x - pad_screw_fudge_radius ;
pad_screw_hole_pos_y = hole_pos_y - pad_screw_fudge_radius ;


// position and flip-over camera board model
if (SHOW_CAMERA) {
  translate([camera_pcb_length + case_sidewall_thickness, case_sidewall_thickness, camera_pcb_thickness])
    rotate([0,180,0])
    %elp_usbfhd01m_l28_dummy();
}

module cutout_cylinder (cylinder_diameter = pad_screw_hole_diameter, cylinder_length = backside_mount_exterior_height) {
  translate([0,0,-e])
    linear_extrude(height = cylinder_length + 2*e, center = false) {
    circle(r=cylinder_diameter / 2);
  }
}


module backside_case () {

  r = 0.9;
  length = backside_mount_exterior_length;
  width =  backside_mount_exterior_width;
  height = backside_mount_exterior_height;

  case_sidewall = case_sidewall_thickness;
  case_sidewall_tolerance = case_sidewall_tol;

  cam_pcb_thickness = camera_pcb_thickness;
  cam_pcb_length = camera_pcb_length + 2*case_sidewall_tolerance;
  cam_pcb_width = cam_pcb_length;

  case_cutout_side_offset = backside_mount_side_cutout_offset + 1*case_sidewall_tolerance;
  cutout_length = backside_mount_side_cutout_length;
  cutout_width  = backside_mount_exterior_width;

  //pcb_cutout_side_offset = backside_mount_side_cutout_offset + 1*case_sidewall_tolerance + camera_pcb_spacer_side_length;
  pcb_cutout_side_offset = camera_pcb_spacer_side_length;
  pcb_cutout_length = cam_pcb_length;
  pcb_cutout_width  = cam_pcb_width - 2*camera_pcb_spacer_side_length;
  pcb_cutout_height = case_screwpad_height;

  usb_cutout_surround_tol = 0.43;
  usb_cutout_length = usb_cutout_length + 2*usb_cutout_surround_tol;
  usb_cutout_width = usb_cutout_width + 2*usb_cutout_surround_tol;
  usb_cutout_height = usb_cutout_height;
  usb_cutout_t_x = case_sidewall + usb_from_x - usb_cutout_surround_tol ;
  usb_cutout_t_y = case_sidewall + usb_from_y - usb_cutout_surround_tol ;

  screw_hole_diameter = pad_screw_hole_diameter ;
  screw_hole_spacing = pad_screw_hole_spacing;
  screw_hole_pos_x = pad_screw_hole_pos_x + case_sidewall + case_sidewall_tolerance;
  screw_hole_pos_y = pad_screw_hole_pos_y + case_sidewall + case_sidewall_tolerance;

  hole_origin = [screw_hole_pos_x, screw_hole_pos_y];
  corner_hole_positions = [[hole_origin.x + 0,                  hole_origin.y + 0],
                           [hole_origin.x + screw_hole_spacing, hole_origin.y + 0],
                           [hole_origin.x + 0,                  hole_origin.y + screw_hole_spacing],
                           [hole_origin.x + screw_hole_spacing, hole_origin.y + screw_hole_spacing]];


  difference() {
    union () {
      // rough outline of back of case
      linear_extrude(height = height)
        complexRoundSquare([length, width],
                           [r,r],[r,r],[r,r],[r,r], center=false);
    }

    // subtract PCB area so can sit flush on screw "pads"
    translate([case_sidewall-case_sidewall_tolerance, case_sidewall-case_sidewall_tolerance,-e]) { // pcb "corner"

      // main PCB outline
      linear_extrude(height = cam_pcb_thickness + 2*e, center = false)
        square([cam_pcb_length + 2*case_sidewall_tolerance, cam_pcb_width + 2*case_sidewall_tolerance], center=false);

      // extend for castellated breakoff remnants
      translate([case_cutout_side_offset, -case_sidewall, 0])
        linear_extrude(height = cam_pcb_thickness + 2*e, center = false)
        square([cutout_length + 2*case_sidewall_tolerance, cutout_width + 2*case_sidewall_tolerance], center=false);

      // transpose of extend
      translate([-case_sidewall, case_cutout_side_offset, 0])
        linear_extrude(height = cam_pcb_thickness + 2*e, center = false)
        square([cutout_width + 2*case_sidewall_tolerance, cutout_length + 2*case_sidewall_tolerance, ], center=false);

    }

    // Screw "pad" areas (leave behind)

    // subtract PCB area so can sit flush on screw "pads"
    translate([case_sidewall-case_sidewall_tolerance,
               case_sidewall-case_sidewall_tolerance,
               (cam_pcb_thickness-e)]) { // pcb "corner", but behind pcb


      // subtract one line of "plus sign" for PCB backside keepout
      translate([0, pcb_cutout_side_offset, 0])
        linear_extrude(height = pcb_cutout_height + 2*e, center = false)
        square([pcb_cutout_length + 2*e, pcb_cutout_width + 2*e], center=false);

      // transpose of line to complete the "plus sign"
      translate([pcb_cutout_side_offset, 0, 0])
        linear_extrude(height = pcb_cutout_height + 2*e, center = false)
        square([pcb_cutout_width + 2*e, pcb_cutout_length + 2*e], center=false);

    }

    // subtract USB connector cutout
    translate([usb_cutout_t_x, usb_cutout_t_y, (cam_pcb_thickness - e)]) { // usb "corner"
      // usb cutout
      linear_extrude(height = usb_cutout_height + 2*e, center = false)
        square([usb_cutout_length, usb_cutout_width], center=false);

    }

    // subtract screw Holes
    for (p = corner_hole_positions) {
      translate([p[0], p[1], 0])
        cutout_cylinder(cylinder_diameter = screw_hole_diameter);
    }


  }
}

if (RENDER_FOR_PRINT) {

  backside_case();
} else if (!true) {
  //translate([0,0,5])
    %backside_case();
} else {
  //translate([0,0,5])
  translate([0,0,0])
    backside_case();
}
