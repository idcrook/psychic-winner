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

    cube([panel_width, panel_height, pcb_to_lcd_glass]);

}

module caseBackPanel () {

    cube([panel_width, panel_height, pcb_to_lcd_glass]);

}




module showTogether() {

    scale ([1.0,1.0,1.0])
        translate([case_side_edge_width, case_top_bottom_edge_extra,0])
        rotate([0,0,0])
        monitorAndPiAssembly(showPi = !true);

    %scale ([1.0,1.0,1.0])
        translate([0,0,10])
        rotate([0,0,0])
        caseFrontPanel();

    scale ([1.0,1.0,1.0])
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
