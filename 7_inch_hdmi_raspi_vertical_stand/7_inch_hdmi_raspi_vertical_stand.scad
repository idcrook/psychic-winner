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


use <mockup/HDMI_7inch_touchscreen__dummy.scad>;
use <MCAD/2Dshapes.scad>

e = 1/128; // small number

module monitorAndPiAssembly () {

  HDMI_7inch_touchscreen__dummy(showPi = true);

}

module showTogether() {

    scale ([1.0,1.0,1.0])
        translate([0,0,0])
        rotate([180,0,0])
        monitorAndPiAssembly();

}


show_everything = !true ;

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
