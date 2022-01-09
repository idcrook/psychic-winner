////////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//
//  2019-Sep-03
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
//   - https://www.thingiverse.com/thing:3062864
//     - https://www.thingiverse.com/thing:3062864/comments/#comment-2226273
//
// Description:
//
//  Add a "cutout" on base for better accomodation of USB cable -> egress from
//  "Charger"
//
//
// Revisions/Notes:
//
//  - Developed on OpenSCAD 2019.05
//
////////////////////////////////////////////////////////////////////////////////

// downloaded 2019-Sep-03
//import("Base.STL");

e = 1/128; // small number

cutout_diameter = 5.5;  // cylinder "cutout" diameter

module cutout_solid (cylinder_diameter = cutout_diameter, cylinder_length = 12.0) {

  linear_extrude(height = cylinder_length, center = true) {
    circle(r=cylinder_diameter / 2);
  }


}

// translate and rotate to achieve goal
module carve_cutout  () {

  difference() {
    import("Base.STL");

    // the hardcodes values were empirically iterated upon
    translate([50, 3.5, 55]) {
      rotate(a = [-27, 0, 0])
        cutout_solid();
    }

  }

}


$fn = $preview ? 30 : 100;
carve_cutout();
