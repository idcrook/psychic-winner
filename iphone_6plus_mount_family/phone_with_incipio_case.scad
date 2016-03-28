

use <iPhone_6_and_6_Plus_Mockups.scad>;
use <MCADlocal/2Dshapes.scad>

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
// 6.5 x 3.3 x 0.5 inches
module incipioNgpCase () {

  difference() {
    // case outer dimensions
    color ("Yellow") shell(w, l, h, 14);

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


module sleeveForEncasediPhone (w, l, h) {

  tolerance = .5;

  sleeveSideThickness = 4;
  sleeveBottomThickness = 4;
  sleeveTopThickness = 4;

  sleeveInner_w =  tolerance + w + tolerance;
  sleeveInner_h =  tolerance + h + tolerance;
  sleeveInner_r = 1.7;

  buttonsIncludedInner_w =  tolerance + 82.3 + tolerance + 0.5;
  buttonsIncludedInner_h =  tolerance + 1.2 + tolerance;
  buttonsIncludedInner_r =  tolerance ;
  
  
  sleeveOuter_w =  sleeveSideThickness + sleeveInner_w + sleeveSideThickness;
  sleeveOuter_h =  sleeveBottomThickness + sleeveInner_h + sleeveTopThickness;
  sleeveOuter_r = 3.2;

  iphoneDisplay_w = 68.8;
  iphoneScreenBezel_w = 3.5;
  
  iphoneScreenOpening_w = iphoneScreenBezel_w + iphoneDisplay_w + iphoneScreenBezel_w;
  caseNonViewable = (1/2) * (sleeveOuter_w - iphoneScreenOpening_w );
  
  sleeveInner_l = 10;
  erase_sleeveInner_l = sleeveInner_l /2;
  
  union () {

    // fill in groove for buttons
    linear_extrude(height = erase_sleeveInner_l, center = false, convexity = 10)
      difference () {
      complexRoundSquare([buttonsIncludedInner_w, buttonsIncludedInner_h],
                         [0, 0],
                         [0, 0],
                         [0, 0],
                         [0, 0],
                         center = true);
      
      // cut out size of iphone in case (plus tolerance)
      complexRoundSquare([sleeveInner_w, sleeveInner_h],
                         [0, 0],
                         [0, 0],
                         [sleeveInner_r, sleeveInner_r],
                         [sleeveInner_r, sleeveInner_r],
                         center = true);
    }
    
    // 2D view for length of case
    linear_extrude(height = sleeveInner_l, center = false, convexity = 10)
      difference () {
      complexRoundSquare([sleeveOuter_w, sleeveOuter_h],
                         [sleeveOuter_r, sleeveOuter_r],
                         [sleeveOuter_r, sleeveOuter_r],
                         [sleeveOuter_r, sleeveOuter_r],
                         [sleeveOuter_r, sleeveOuter_r],
                         center = true);
  
  
      // cut out size of iphone in case (plus tolerance)
      complexRoundSquare([sleeveInner_w, sleeveInner_h],
                         [sleeveInner_r, sleeveInner_r],
                         [sleeveInner_r, sleeveInner_r],
                         [sleeveInner_r, sleeveInner_r],
                         [sleeveInner_r, sleeveInner_r],
                         center = true);

      // groove for buttons
      complexRoundSquare([buttonsIncludedInner_w, buttonsIncludedInner_h],
                         [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                         [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                         [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                         [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                         center = true);

      // cut for screen and add bevel
      translate ([-iphoneScreenOpening_w/2, -sleeveInner_h ]) 
        square([iphoneScreenOpening_w, sleeveInner_h],  center = false);

      translate ([-1/2*sleeveInner_w, -sleeveInner_h + sleeveTopThickness/2])
        rotate((360 - 50) * [0, 0, 1])
        square([caseNonViewable, sleeveInner_h],  center = false);

      translate ([1/2*sleeveInner_w, -sleeveInner_h + sleeveTopThickness/2])
        rotate((90 + 50) * [0, 0, 1]) 
        square([caseNonViewable, sleeveInner_h],  center = false);
    }
  }
  

}

module showTogether() {
  // iphone 6 Plus
  * translate([tw, tl, th ]) iphone(77.8, 158.1, 7.1, 9.5);

  // incipio case
  translate([0,0,0]) incipioNgpCase();

  color ("White")
    translate ([200, 50, 0])
    import ("files/iPhone_Bike_Mount/mount_v4-case.stl");

  // design
  translate([150,0,0]) sleeveForEncasediPhone(w, l, h);
  
}


* showTogether();

$fn = 100;
translate([0,0,0]) sleeveForEncasediPhone(w, l, h);
