

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

  e = 0.02; // small number
  
  echo("sleeve: height=",h);
  tolerance = 0.5;

  sleeveSideThickness = 4;
  sleeveBottomThickness = 4;
  sleeveTopThickness = 4;
  sleeveBaseThickness = 1.5 * sleeveBottomThickness;

  base_l = sleeveBaseThickness;

  sleeveInner_w =  tolerance + w + tolerance;
  sleeveInner_h =  tolerance + h + tolerance;
  sleeveInner_r = 1.7;

  buttonsIncludedInner_w =  tolerance + 82.3 + tolerance + 0.5;
  buttonsIncludedInner_h =            +  3.0 + tolerance;
  buttonsIncludedInner_r =  tolerance ;

  sleeveOuter_w =  sleeveSideThickness + sleeveInner_w + sleeveSideThickness;
  sleeveOuter_h =  sleeveBottomThickness + sleeveInner_h + sleeveTopThickness;
  sleeveOuter_r = 3.2;

  iphoneDisplay_w = 68.8;
  iphoneScreenBezel_w = 3.5;
  
  iphoneScreenOpening_w = iphoneScreenBezel_w + iphoneDisplay_w + iphoneScreenBezel_w;
  caseNonViewable = (1/2) * (sleeveOuter_w - iphoneScreenOpening_w );
  
  sleeveInner_l = l;
  volumeButtonsHeightFromBottom = 105.0;
  volumeButtonsCutoutHeight = 25.3;
  volumeButtonsCutoutDepth = 7.7;
  volumeButtonsCutoutRadius = 2;
  erase_sleeveInner_l_left  = volumeButtonsHeightFromBottom;
  
  powerButtonHeightFromBottom = 117.7;
  powerButtonCutoutHeight = 12.2;
  powerButtonCutoutDepth = 7.7;
  powerButtonCutoutRadius = 2;
  erase_sleeveInner_l_right =   powerButtonHeightFromBottom;
  
  muteSwitchHeightFromBottom = 132.7;
  muteSwitchCutoutHeight = 12.2;
  muteSwitchCutoutDepth = 7.7;
  muteSwitchCutoutRadius = 2;

  union () {

    // fill in groove for part of sleeve below buttons
    union () {
      linear_extrude(height = erase_sleeveInner_l_left, center = false, convexity = 10)
        translate([-(1/2)*buttonsIncludedInner_w, -(1/2)*buttonsIncludedInner_h, 0]) 
        difference () {
        complexRoundSquare([buttonsIncludedInner_w/2, buttonsIncludedInner_h],
                           [0, 0],
                           [0, 0],
                           [0, 0],
                           [0, 0],
                           center = false);
      
        // cut out size of iphone in case (plus tolerance)
        translate([(buttonsIncludedInner_w-sleeveInner_w)/2, 0, 0])
          complexRoundSquare([(1/2)*sleeveInner_w, sleeveInner_h/2],
                             [0, 0],
                             [0, 0],
                             [sleeveInner_r, sleeveInner_r],
                             [sleeveInner_r, sleeveInner_r],
                             center = false);
      }

      linear_extrude(height = erase_sleeveInner_l_right, center = false, convexity = 10)
        translate([0, -(1/2)*buttonsIncludedInner_h, 0]) 
        difference () {
        complexRoundSquare([buttonsIncludedInner_w/2, buttonsIncludedInner_h],
                           [0, 0],
                           [0, 0],
                           [0, 0],
                           [0, 0],
                           center = false);
      
        // cut out size of iphone in case (plus tolerance)
        translate([0, 0, 0])
          complexRoundSquare([(1/2)*sleeveInner_w, sleeveInner_h/2],
                             [0, 0],
                             [0, 0],
                             [sleeveInner_r, sleeveInner_r],
                             [sleeveInner_r, sleeveInner_r],
                             center = false);
      }
    
    }

    // need a difference here to be able to punch out button and camera access holes
    difference () {
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

        // include groove for buttons (covered back in above)
        complexRoundSquare([buttonsIncludedInner_w, buttonsIncludedInner_h],
                           [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                           [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                           [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                           [buttonsIncludedInner_r,  buttonsIncludedInner_r],
                           center = true);

        bevel_angle = 50;
        // cut for screen and add bevel
        translate ([-iphoneScreenOpening_w/2, -sleeveInner_h ]) 
          square([iphoneScreenOpening_w, sleeveInner_h],  center = false);

        translate ([-(1/2)*(sleeveInner_w + 2*tolerance), -(sleeveInner_h + tolerance)  + sleeveTopThickness/2])
          rotate((360 - bevel_angle) * [0, 0, 1])
          square([caseNonViewable, sleeveInner_h],  center = false);

        translate ([1/2*(sleeveInner_w + 2*tolerance), -(sleeveInner_h + tolerance) + sleeveTopThickness/2])
          rotate((90 + bevel_angle) * [0, 0, 1]) 
          square([caseNonViewable, sleeveInner_h],  center = false);
      }
    
      // volume buttons cutout
      translate([-1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (volumeButtonsCutoutDepth), volumeButtonsHeightFromBottom])
      mirror()
      rotate([0, 180 + 90, 0])
        linear_extrude(height = sleeveSideThickness + 2*e, center = false, convexity = 10)
        complexRoundSquare( [volumeButtonsCutoutHeight, volumeButtonsCutoutDepth],
                            [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                            [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                            [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                            [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                            center = false);

      // power button cutout
      translate([+1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (powerButtonCutoutDepth), powerButtonHeightFromBottom])
      rotate([0, 180 + 90, 0])
        linear_extrude(height = sleeveSideThickness + 2*e, center = false, convexity = 10)
        complexRoundSquare( [powerButtonCutoutHeight, powerButtonCutoutDepth],
                            [powerButtonCutoutRadius, powerButtonCutoutRadius],
                            [powerButtonCutoutRadius, powerButtonCutoutRadius],
                            [powerButtonCutoutRadius, powerButtonCutoutRadius],
                            [powerButtonCutoutRadius, powerButtonCutoutRadius],
                            center = false);
      
      // mute switch cutout
      translate([-1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (muteSwitchCutoutDepth), muteSwitchHeightFromBottom])
      mirror()
      rotate([0, 180 + 90, 0])
        linear_extrude(height = sleeveSideThickness + 2*e, center = false, convexity = 10)
        complexRoundSquare( [muteSwitchCutoutHeight, muteSwitchCutoutDepth],
                            [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                            [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                            [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                            [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                            center = false);
    }



    
  }

      
  translate([0,0, -base_l])
  linear_extrude(height = base_l, center = false, convexity = 10)
    // 2D view for base of sleeve
    complexRoundSquare([sleeveOuter_w, sleeveOuter_h],
                       [sleeveOuter_r, sleeveOuter_r],
                       [sleeveOuter_r, sleeveOuter_r],
                       [sleeveOuter_r, sleeveOuter_r],
                       [sleeveOuter_r, sleeveOuter_r],
                       center = true);

}

module showTogether() {
  // iphone 6 Plus
  % translate([tw, tl, th ]) iphone(77.8, 158.1, 7.1, 9.5);

  // incipio case
  * translate([0,0,0]) incipioNgpCase();

  * color ("White")
    translate ([200, 50, 0])
    import ("files/iPhone_Bike_Mount/mount_v4-case.stl");

  // design
  %translate([w/2,0,h/2]) rotate([360-90,0,0]) sleeveForEncasediPhone(w, l, h);
  
}


//showTogether();

//$fn = 100;
translate([0,0,0]) sleeveForEncasediPhone(w, l, h);
