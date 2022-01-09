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
//   2019-Dec-29: First draft mount
//
//   2019-Dec-30: Add a linkage
//
//   2019-Dec-31: Completed installation
//
///////////////////////////////////////////////////////////////////////////////

// Additional parts needed to fully assemble
// -----------------------------------------
//
//  - Four (4) M2.5 bolts (~10 mm) - for mounting camera pcb into holder
//
//    - Two of these self-tap with sufficient fastening on their own
//    - (optional) M2.5 washers and nuts
//
//  - Two (2) M3 bolts (~20 mm; 16mm barely long enough) - for connecting
//    linkage to camera case and mount
//
//    - M3 nuts
//
//  - Two (2) M3 screws (6 mm) - for attaching surface mount
//
//    - use short M3 bolts as screws to directly burrow into a 3mm thick 3d
//      printed plate
//

include <mockup/elp_usbfhd01m_l28_dummy.scad>
use <../libraries/MCAD/2Dshapes.scad>

e = 1/128; // small number

// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

RENDER_FOR_PRINT = true;
INCLUDE_STAND_LINKAGE_SPAN = true; // a linkage for positioning cam
INCLUDE_STAND_SURFACE_MOUNT = true; // for bolting into a surface
ONLY_RENDER_STAND_LINKAGE_SPAN = !true;
ONLY_RENDER_STAND_SURFACE_MOUNT = !true;
SHOW_CAMERA = RENDER_FOR_PRINT ? false : true;
CASE_TONGUE_HORIZONTAL_MOUNT = !true;
CASE_TONGUE_VERTICAL_MOUNT   = true;

module __Customizer_Limit__ () {}

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

bracket_length = 10.0;
bracket_width = 12.0;
bracket_height = 5.0;  // "tongue" size

bracket_hole_diameter = 3.6;
bracket_hole_length = bracket_height;
bracket_hole_pos_x = 5.5;
bracket_hole_pos_y = 7.5;

case_tongue_horizontal_pos_x = 22.8;
case_tongue_horizontal_pos_y = case_sidewall_thickness;
case_tongue_horizontal_pos_z = backside_mount_exterior_height;

case_tongue_vertical_pos_x = 22.8;
case_tongue_vertical_pos_y = 0;
case_tongue_vertical_pos_z = -3;

// additional parameters for linkages / brackets / mounts
linkage_length = 70.0;
linkage_groove_length = bracket_width;
linkage_width = bracket_length;

linkage_groove_height = bracket_height + 2*0.18;
linkage_tongue_height = bracket_height - 1;
linkage_height = linkage_groove_height + 2*linkage_tongue_height;
linkage_hole_diameter = bracket_hole_diameter;
linkage_hole_pos_x = 5.0;
linkage_hole_pos_y = 5.0;

surface_mount_base_length = 40.0;
surface_mount_base_width =  bracket_length + 2*2.8;
surface_mount_pad_length = 16.0;
surface_mount_pad_width =  bracket_length + 2*0.8;
surface_mount_thickness = 4.0;

surface_mount_tongue_height = bracket_height;
surface_mount_height = linkage_groove_height + 2*linkage_tongue_height;
surface_mount_hole_diameter = bracket_hole_diameter;
surface_mount_hole_pos_x = 5.0;
surface_mount_hole_pos_y = 5.0;



// position and flip-over camera board model
if (SHOW_CAMERA) {
  translate([camera_pcb_length + case_sidewall_thickness + case_sidewall_tol,
             case_sidewall_thickness + case_sidewall_tol,
             camera_pcb_thickness])
    rotate([0,180,0])
    %elp_usbfhd01m_l28_dummy();
}

module cutout_cylinder (cylinder_diameter = pad_screw_hole_diameter, cylinder_length = backside_mount_exterior_height) {
  translate([0,0,-e])
    linear_extrude(height = cylinder_length + 2*e, center = false) {
    circle(r=cylinder_diameter / 2);
  }
}

module bracket_tongue (length = bracket_length, width = bracket_width, height = bracket_height) {
  r  = width / 2.2;
  r2 = width / 3.6;

  difference() {
    linear_extrude(height = height)
      complexRoundSquare([length, width],
                         [0,0],[0,0], [r2,r2],[r,r],
                         center=false);

    // cutout hole
    translate([bracket_hole_pos_x, bracket_hole_pos_y, 0])
      rotate([0, 0, 0])
      cutout_cylinder (cylinder_diameter = bracket_hole_diameter, cylinder_length = bracket_hole_length);
  }
}

module linkage_span (length = linkage_length, width = linkage_width, height = linkage_tongue_height, groove_height = linkage_groove_height) {
  r  = width / 2.2;
  r2 = width / 3.6;

  solid_height = groove_height + 2*height;
  linkage_far_hole_pos_x = linkage_hole_pos_x;
  linkage_far_hole_pos_y = length - linkage_hole_pos_y;

  linkage_far_groove_pos_y = length -  linkage_groove_length;


  difference() {
    // main solid of linkage
    linear_extrude(height = solid_height)
      complexRoundSquare([width, length],
                         [r,r],[r2,r2],
                         [r2,r2],[r,r],
                         center=false);

    // punch hole
    translate([linkage_hole_pos_x, linkage_hole_pos_y, 0])
      rotate([0, 0, 0])
      cutout_cylinder (cylinder_diameter = linkage_hole_diameter, cylinder_length = solid_height);

    // punch far hole
    translate([linkage_far_hole_pos_x, linkage_far_hole_pos_y, 0])
      rotate([0, 0, 0])
      cutout_cylinder (cylinder_diameter = linkage_hole_diameter, cylinder_length = solid_height);

    // punch groove
    translate([-e, 0, height])
      rotate([0, 0, 0])
      cube ([width + 2*e, linkage_groove_length, groove_height + 2*e], center = false);

    // punch far groove
    translate([-e, linkage_far_groove_pos_y, height])
      rotate([0, 0, 0])
      cube ([width + 2*e, linkage_groove_length, groove_height + 2*e], center = false);
  }
}

module surface_mount (length = surface_mount_base_length, width = surface_mount_base_width,
                      pad_length = surface_mount_pad_length, pad_width = surface_mount_pad_width,
                      thickness = surface_mount_thickness, tongue_height = surface_mount_tongue_height) {
  r  = width / 1.2;
  r2 = width / 5;

  pad_pos_t_x = (1/2)*(length - pad_length);
  pad_pos_t_y = (1/2)*(width - pad_width);

  hole_pos_x = (3/5) * pad_pos_t_x;
  hole_pos_y = (1/2) * width;

  hole_far_pos_x = length - hole_pos_x;
  hole_far_pos_y = hole_pos_y;

  tongue_t_x = (1/2)*(length - bracket_length) + (1/2)*tongue_height;
  tongue_t_y = (1/2)*(width - bracket_length);
  tongue_t_z = thickness;

  difference() {

    union () {

      // "base" of mount
      hull () {
        // base solid
        linear_extrude(height = thickness / 2)
          complexRoundSquare([length, width],
                             [r,r2],[r,r2],
                             [r,r2],[r,r2],
                             center=false);
        // pad solid
        translate([pad_pos_t_x, pad_pos_t_y, thickness / 2])
          linear_extrude(height = thickness / 2)
          complexRoundSquare([pad_length, pad_width],
                             [r,r2],[r,r2],
                             [r,r2],[r,r2],
                             center=false);
      }

      // "tongue" on mount
        translate([tongue_t_x, tongue_t_y, tongue_t_z - e])
          rotate([90,0,90])
          bracket_tongue(height = tongue_height);

    }


    // punch hole
    translate([hole_pos_x, hole_pos_y, 0])
      rotate([0, 0, 0])
      cutout_cylinder (cylinder_diameter = surface_mount_hole_diameter, cylinder_length = thickness);

    // punch far hole
    translate([hole_far_pos_x, hole_far_pos_y, 0])
      rotate([0, 0, 0])
      cutout_cylinder (cylinder_diameter = surface_mount_hole_diameter, cylinder_length = thickness);


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

      if (CASE_TONGUE_HORIZONTAL_MOUNT) {
          translate([case_tongue_horizontal_pos_x, case_tongue_horizontal_pos_y, case_tongue_horizontal_pos_z - e])
            rotate([90,0,90])
            bracket_tongue();
      }

      if (CASE_TONGUE_VERTICAL_MOUNT) {
        translate([case_tongue_vertical_pos_x, case_tongue_vertical_pos_y + e, case_tongue_vertical_pos_z + e])
          rotate([90,270,90])
          bracket_tongue();
      }
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

    // subtract PCB area so can sit flush on corner "pads" (the components on back side need extra space)
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

  if (INCLUDE_STAND_LINKAGE_SPAN) {
    translate([0, 54 , 0 + 7])
      rotate([90,90,0])
      linkage_span();
  }

  if (INCLUDE_STAND_SURFACE_MOUNT) {
    translate([40, -3.5, 7])
      rotate([180,0,90])
      surface_mount();
  }

}

if (RENDER_FOR_PRINT) {

  if (ONLY_RENDER_STAND_LINKAGE_SPAN) {
    rotate([0,90,0])
      linkage_span();
  }
  else if (ONLY_RENDER_STAND_SURFACE_MOUNT) {
    rotate([0,0,0])
      surface_mount();
  } else {
    rotate([0,180,0])
      backside_case();
  }

} else if (!true) {
  //translate([0,0,5])
    %backside_case();
} else {
  //translate([0,0,5])
  translate([0,0,0])
    backside_case();
}
