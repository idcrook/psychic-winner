////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   27-Mar-2016 
//
// Author:
//
//   David Crook <dpcrook@users.noreply.github.com>
//
// Inspired by:
//
//   - http://www.thingiverse.com/thing:4382/ iPhone Bike Mount
//   - http://www.thingiverse.com/thing:18020/ Dodge Ram Vent Mount for iPhone
//
// Description:
//
//   I decided to re-implement this iphone sleeve phone, to fit my iPhone 6
//   Plus case and using OpenSCAD
//
// Revisions/Notes:
//
//   v1:
//
//   - used .STL imported into OpenSCAD to base dimensions on, and firstly
//     modeled my incipio iPhone case
//
//   - after many iterations, experiments and tweaks, have an iPhone mount and
//     sleeve for my bicycle.  plan to work on a mount system for my car/truck
//     next
//   
//   v2:
//
//   - cupholder mount system for my truck
//   
//   - tweaks for cap
//
////////////////////////////////////////////////////////////////////////


use <files/iPhone_6_and_6_Plus_Mockups.scad>;
use <MCAD/2Dshapes.scad>
use <../libraries/wedge.scad>

  e = 0.02; // small number

  w = 81.5;
  l = 161.9;  // 
  h = 10.5;   // at corners; elsewhere as low as 10.1 mm

  iw = 77.8;
  il = 158.1;
  ih = 7.1;
  tol = 0.2;

  dw = w - iw;
  dl = l - il;
  dh = h - ih;

  tw = (1/2) * dw  ;
  tl = (1/2) * dl  ;
  th = (1/2) * dh  ;

  cut_w = 73.3;
  cut_l = 153.8;
  cut_r = 9.5;

  dcw = (w - cut_w) / 2;
  dcl = (l - cut_l) / 2;
    


// http://www.amazon.com/IPhone-Incipio-Impact-Resistant-Translucent/dp/B00MUQ9V1Q
// "Incipio NGP Case for iPhone 6+"
// 6.5 x 3.3 x 0.5 inches  -> 165.1 x 83.8 x 12.7
module incipioNgpCase () {

  difference() {
    // case outer dimensions
    % shell(w, l, h, 14);

    // carve out iphone 6 Plus and some tolerance
    translate([tw - tol, tl - tol, th]) {
      shell(iw + 2*tol, il + 2*tol, ih + 2*tol, 9.5 + 2*tol);
    }
    
    // cut out above phone too (rounded rect with dimensions 73.3 x 153.8)
    translate ([dcw,dcl,th+ih-tol]) 
      linear_extrude(height = 10, center = false, convexity = 10)
      complexRoundSquare([cut_w, cut_l],
                           [cut_r, cut_r],
                           [cut_r, cut_r],
                           [cut_r, cut_r],
                           [cut_r, cut_r],
                           center = false);
  }
}









module showTogether() {

 
  // iphone 6 Plus
  translate([tw, tl, th ]) iphone(77.8, 158.1, 7.1, 9.5);

  // incipio case
  translate([0,0,0]) incipioNgpCase();

//  // design
//  %translate([w/2,0,h/2]) rotate([360-90,0,0]) sleeveForEncasediPhone(w, l, h, false, withCap);

  
}



module show_iPhone_6_plus_Portrait_Cradle() {
    
   // % scale([1,1,1] * 25.4) import( "/Users/dpc/Downloads/3dprint/models/Downloads/iPhone_6_6+_CD_Tray_Mount/files/iPhone_6+_Portrait_Cradle.stl");

     // color ("red") scale([1,1,1]) import("/Users/dpc/Downloads/3dprint/models/Downloads/Universal_Car_CD_Slot_-_Smartphone_Holder/files/CD_Slot_Phone_V02_resized_plus_weld.stl");


    //incipio case
    //translate([0,0,0]) rotate([90,0,0]) incipioNgpCase();
    //import("/Users/dpc/Downloads/3dprint/models/Downloads/iPhone_Plus_and_watch_dock.STL");

    translate ([81, 5, 5]) 
        rotate([90,-90,0])  showTogether();
}




show_iPhone_6_plus_Portrait_Cradle() ;
    


