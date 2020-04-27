///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2020-Apr-19
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//   Vertical stand for Raspberry Pi plus 7-inch HDMI touchscreen display with
//   push-buttons
//
// Revisions/Notes:
//
//   2020-Apr-19: Initial dimensions
//
//   2020-Apr-19:
//
///////////////////////////////////////////////////////////////////////////////


use <MCAD/2Dshapes.scad>

include <../libraries/misc/fillet.scad>

include <../libraries/Chamfers-for-OpenSCAD/Chamfer.scad>

/* LCD monitor model */
//use <mockup/HDMI_7inch_touchscreen__dummy.scad>
include <mockup/HDMI_7inch_touchscreen__dummy.scad>



e = 1/128; // small number

case_side_edge_width = 6;
case_top_bottom_edge_extra = 3;
panel_width  = pcb_width + 2*(case_side_edge_width);
panel_height  = pcb_height + 2*(case_top_bottom_edge_extra);

module monitorAndPiAssembly (showPi = false) {

  HDMI_7inch_touchscreen__dummy(showPi);

}


module caseFrontPanel () {
    chamfer_size_face = 2;
    thickness_face = 2.0;

    scale_cutout = 0.95;
    translate_scale_cutout = (1/2) * (1/scale_cutout - 1);
    translate_x_cutout = translate_scale_cutout  * panel_width;
    translate_y_cutout = translate_scale_cutout  * panel_height;

    translate_x_screen_cutout = 0;
    translate_y_screen_cutout = 0;


    // bulk - {bulk cutout, screen cutout}
    difference () {
        intersection() {
            // outline with rounded corners
            cube_fillet([panel_width, panel_height, pcb_to_lcd_glass], radius=4, $fn=25);

            // add chamfer to top
            scale ([1.0, 1.0, 1.0])
                translate([0,0, -chamfer_size_face])
                rotate([0,0,0])
                chamferCube([panel_width, panel_height, pcb_to_lcd_glass + chamfer_size_face+ e], ch=chamfer_size_face);
        }

        // bulk cutout
        translate([translate_x_cutout, translate_y_cutout, -e])
            rotate([0,0,0])
            cube_fillet([panel_width * scale_cutout,
                         panel_height * scale_cutout,
                         pcb_to_lcd_glass - chamfer_size_face + 2*e],
                        radius=4, $fn=25);

        // screen cutout
        translate([translate_x_screen_cutout, translate_y_screen_cutout, -e])
            rotate([0,0,0])
            cube_fillet([panel_width * scale_cutout,
                         panel_height * scale_cutout,
                         pcb_to_lcd_glass - chamfer_size_face + 2*e],
                        radius=4, $fn=25);

    }

}

module caseBackPanel () {

    cube([panel_width, panel_height, pcb_to_lcd_glass]);

}




module showTogether() {

    %scale ([1.0,1.0,1.0])
        translate([case_side_edge_width, case_top_bottom_edge_extra,0])
        rotate([0,0,0])
        monitorAndPiAssembly(showPi = !true);

    scale ([1.0,1.0,1.0])
        translate([0,0,30])
        rotate([0,0,0])
        caseFrontPanel();

    *scale ([1.0,1.0,1.0])
        translate([0,0,-10])
        rotate([0,0,0])
        caseBackPanel();


}


show_everything = true ;

show_monitor_assembly = true ;

if (show_everything) {
  showTogether();
} else {

  // $preview requires version 2019.05
  fn = $preview ? 30 : 100;

  if (show_monitor_assembly) {

    scale ([1.0,1.0,1.0])
        translate([0,0,0])
        rotate([0,0,0])
        monitorAndPiAssembly();
  }


}
