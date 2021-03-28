///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2021-Mar-26
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//   Use models from MCAD and others
//
// Revisions/Notes:
//
//   2021-Mar-26 : Initial
//
//
///////////////////////////////////////////////////////////////////////////////

use <MCAD/servos.scad>
//use <../libraries/MCAD/servos.scad>

e = 1/128; // small number

module towerprosg90_inst () {
  towerprosg90(position=[0,0,0], rotation=[0,0,90], screws = 1, 
    axle_length = 2, cables = 1);
}

module alignds420_inst () {
    alignds420(position=[0,0,0], rotation=[0,0,0], screws = 2, 
    axle_lenght = 2);
}

module futabas3003_inst() {
    futabas3003(position=[0,0,0], rotation=[0,0,0]);
}

module showTogether() {

  show_with_a = true;

  if (show_with_a) {
    translate([0,0,0]) towerprosg90_inst();
    translate([20,0,0]) alignds420_inst();
    translate([40,0,0]) futabas3003_inst();

  }

}

show_everything = true;

// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

if (show_everything) {
  showTogether();
 } else {
    towerprosg90_inst();
 }
