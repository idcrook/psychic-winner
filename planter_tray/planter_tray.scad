// Need a tray for a ceramic planter, so excess water is caught
//
// Some of the requirements:
//
// - has to fit on 3D printer bed, so this means based on required dimensions,
//   has to be printed in at least two pieces
//
// - base diameter ~160 mm
//
// - inner diameter at top of lip ~170 mm, at a height ~20 mm
//

use <MCAD/2Dshapes.scad>

// 2D profile

module sideView () {

  baseThickness = 4.0;
  sidewallThickness = 3.5;
  sidewallHeight = 20;

  baseSideOverlap = sidewallThickness;

  bottomDiameter = 160;
  topDiameter = 170;

  // calculate sidewall angle
  outclineAngle = atan( (1/2)*(topDiameter-bottomDiameter) / sidewallHeight );

  bottom_r = bottomDiameter/2;
  top_r = topDiameter/2;
  bottomSide_r = baseThickness/2;

  rotate([0,0,0]) {

    difference() {
      planterProfile (bottom_r + baseSideOverlap, bottomSide_r, baseThickness, true);

      translate([0,baseThickness,0])
        planterProfile (bottom_r + baseSideOverlap, bottomSide_r, baseThickness, true);
    }

    // side
    translate([bottom_r + (1/1)*baseSideOverlap, 0, 0])
    rotate([0,0, (90-outclineAngle)])
      difference() {
        planterProfile (sidewallHeight + baseSideOverlap, bottomSide_r, sidewallThickness, false);
        
      }

    
  }
  

}

module planterProfile (bottom_r, side_r, thickness, baseQ) {

  if (baseQ) {
    complexRoundSquare([bottom_r, 2*thickness],
                       [0,0],
                       [side_r, side_r],
                       [0,0],
                       [0,0],
                       center = false);
  } else {
    complexRoundSquare([bottom_r, thickness],
                       [side_r, side_r],
                       [0,0],
                       [0,0],
                       [0,0],
                       center = false);
  }    
}


module revolve () {
  rotate_extrude(angle = 360, convexity = 2) {
    sideView();

  }
}

*sideView();

revolve();
