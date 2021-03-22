// Need a tray for a ceramic planter, so excess water is caught
//
// Some of the requirements:
//
// - has to fit on 3D printer bed, so this means based on required dimensions,
//   has to be printed in at least two pieces
//
// - base interior diameter 172 mm
//
// - inner diameter at top of lip 185 mm, at a height ~20 mm
//

use <MCAD/2Dshapes.scad>

// small number
e = 0.02;

buildSmall = true;
//buildSmall = false;

baseThickness = 3.0;
sidewallThickness = 3.0;
sidewallHeight = 20;

baseSideOverlap = sidewallThickness;


bottomDiameter = buildSmall ? 135  : 172;
topDiameter = buildSmall ? 140 : 185;

// calculate sidewall angle
outclineAngle = atan( (1/2)*(topDiameter-bottomDiameter) / sidewallHeight );

bottom_r = bottomDiameter/2;
top_r = topDiameter/2;
bottomSide_r = baseThickness/2;


// 2D profile

module sideView () {

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

module linearPlanterProfile(thickness) {

  rotate([90,0,0]) {
    translate([0,0,-1*e])
      linear_extrude(height = thickness+2*e, center = true, convexity = 10)
        sideView();
  }

  *rotate([90,0,0]) {
    translate([0,0,-1*e])
      linear_extrude(height = thickness+e, center = true, convexity = 10)
        sideViewProjection();
  }

  *sideViewProjection(thickness+e);
  
}


// the projection
module sideViewProjection(height) {

  //linear_extrude(height = height, center = true, convexity = 10)
  #rotate([-90,0,0])
  projection(cut=true)
    rotate([90,0,0]) revolve();


}

module cutProfile(thickness) {

  D = topDiameter + 15;
  r = D/2;
  u = r/6;
  rr = thickness/2;

  translate([0, -thickness/2,0])
  difference ()
  {
    union()
    {
      complexRoundSquare([r, thickness],
                         [0,0],
                         [rr, rr],
                         [0,0],
                         [0,0],
                         center = false);
      
      translate([2*u, 0, 0])
        circle(r = u + rr);
    }
    
    translate([2*u, 0, 0])
    {
      circle(r = u - rr);
      
      translate([0,-u,0])
        square([2*(u+rr) + e, 2*(u+rr) + e], center = true);
      
    }
  }    
  
}

module generateCutProfile(width) {

  linear_extrude(height = 2*sidewallHeight+10, center = true, convexity = 10) {
    
    translate([0,-width,0])
      difference()
    {
      cutProfile(2*width) ;
      
      translate([0,-width, 0])
        cutProfile(2*width) ;
      
    }

    translate([0,0,0])
      difference()
    {
      cutProfile(2*width) ;
      
      translate([0,-width, 0])
        cutProfile(2*width) ;
    }
  }
  
}



module revolve () {
  rotate_extrude(angle = 360, convexity = 10) {
    sideView();

  }
}


module revolveHalf () {

  extant = topDiameter + sidewallHeight;
  
  difference() {
    revolve();

    translate([-(extant+e),-extant/2, -e])
      cube([extant, extant, extant]);
  }
  
}

*sideView();
* revolve();


module buildPrintable() {

  separationWidth = 2/2;

  fillIn = true;

  $fn = 200;
  
  difference() {
    union() {
      translate([separationWidth,0,0])
        revolveHalf();

      rotate([0,0,180])
        translate([separationWidth-e,0,0])
        revolveHalf();

      
      if (fillIn) {
        rotate([0,0,90])
          translate([0,0,0])
          linearPlanterProfile(2*separationWidth);
      
        rotate([0,0,270])
          translate([0,0,0])
          linearPlanterProfile(2*separationWidth);
      }
    }

    union () {
      rotate([0,0,  0 + 90])
      {
        generateCutProfile(separationWidth);
      }    
      rotate([0,0,180 + 90])
      {
        generateCutProfile(separationWidth);
      }
    }
  }
  
}


module buildSmall() {
  $fn = 200;
  revolve();
}

buildPrintable();

* buildSmall();
