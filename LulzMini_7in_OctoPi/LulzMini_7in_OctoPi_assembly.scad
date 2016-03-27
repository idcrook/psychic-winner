////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   24-Mar-2016 
//
// Author:
//
//   David Crook <dpcrook@users.noreply.github.com>
//
// Inspired by:
//
//  Multiple
//
// Description:
//
//
//
// Revisions/Notes:
//
//   v1:
//   - 
//
////////////////////////////////////////////////////////////////////////


// use <ruler.scad>
// use <MCAD/shapes.scad>
use <MCADlocal/2Dshapes.scad>

// small number
//e=0.02;
e=0.02;

module displayCover() {
    import("files/Front.stl");
}

module raspiCover() {
    import("files/Back.stl");
}

module mountBrace() {
    import("files/7-inch-raspberry-pi-stand-wide-hole.stl");
}

module exampleBrace() {
    import("files/MCTouch_Holder.STL");
}


SLOPE_ANGLE = 90 - 68;
BRACKET_WIDTH = 20;

module myBrace(brace_width, drill_hole_offset) {
    
  braceWidth = brace_width;
  slopeAngle = SLOPE_ANGLE;

  ////////////////////////////////////////////////////////////////////////
  // Some Constants
  ////////////////////////////////////////////////////////////////////////
  startOrigin = [0,0,0];
  slopeRotationAngle = 180 + slopeAngle;
  slopeUnderhangAngleOrigin =  slopeRotationAngle + 90;
  slopeLipAngleOrigin =  slopeRotationAngle + 180;
  
  braceFrontThickness = 4;
  slopeThickness = 4;
  crossbarThickness = 3;

  frontRounded_r = braceFrontThickness / 2;
  crossbarRounded_r = crossbarThickness/2.5;
  slopeRounded_r = slopeThickness/2;
    
  slopeInsideLength = 120; // MEASURED: 119.0 mm
  againstFrontLength = (1/2) * cos(slopeAngle) * (slopeInsideLength + braceFrontThickness) + 1 ;
  
  crossbarInsideLength = 62;
  crossbarOverhangInsideLength = 2.1; // MEASURED on other brace: 2.0 mm
  crossbarLipInsideLength = 2.5;
  
  slopeUnderhangInsideLength = 14.2; // MEASURED: 14.0 mm
  slopeLipInsideLength = 5; 

  ////////////////////////////////////////////////////////////////////////
  // Some derived values
  ////////////////////////////////////////////////////////////////////////
  bracketOrigin = startOrigin + [0, braceFrontThickness, 0];
  bracketThickness = braceFrontThickness;
  bracketCrossbarLength = againstFrontLength * sin(slopeAngle) + slopeThickness * (1/cos(slopeAngle)) ;
  
  crossTopCorner = startOrigin + [0, againstFrontLength, 0];
  crossbarOrigin =  crossTopCorner + [e, -crossbarThickness, 0];
  crossbarTopLength = crossbarInsideLength + crossbarThickness;

  crossbarOverhangOrigin =  crossbarOrigin + [crossbarThickness-crossbarTopLength,0,0];
  crossbarOverhangLength = crossbarOverhangInsideLength + crossbarThickness;

  crossbarLipOrigin =  crossbarOverhangOrigin + [0, -crossbarOverhangInsideLength, 0];
  crossbarLipLength =  crossbarLipInsideLength + 1;
  
  slopeTopCorner = crossTopCorner;
  slopeOrigin =  slopeTopCorner + [braceFrontThickness*cos(slopeAngle),0,0];
  slopeLength = slopeInsideLength + slopeThickness;

  slopeToUnderhangOriginLength = slopeLength - slopeThickness;
  slopeUnderhangOrigin =  slopeOrigin + slopeToUnderhangOriginLength * [ cos(slopeUnderhangAngleOrigin),
                                                                         sin(slopeUnderhangAngleOrigin), 0];
  slopeUnderhangLength = slopeUnderhangInsideLength + slopeThickness; 
  
  slopeUnderhangToLipLength = slopeUnderhangLength - slopeThickness;
  slopeLipOrigin = slopeUnderhangOrigin + slopeUnderhangToLipLength * [ cos(slopeLipAngleOrigin), sin(slopeLipAngleOrigin), 0];
  slopeLipLength = slopeLipInsideLength + slopeThickness; 
  
  difference() {
    linear_extrude(height = braceWidth, center = false, convexity = 10)
      union() {

      //////////////////////////////////////////////////////////////////////////
      // Front of Lulzbot mini frame
      //////////////////////////////////////////////////////////////////////////
      translate(startOrigin)
        complexRoundSquare([braceFrontThickness, againstFrontLength],
                           [frontRounded_r, frontRounded_r],
                           [0,0],
                           [frontRounded_r, frontRounded_r],
                           [0,0],
                           center = false);

      translate(bracketOrigin) rotate ([0,0,-90])
        complexRoundSquare([bracketThickness, bracketCrossbarLength],
                           [0,0],
                           [frontRounded_r, frontRounded_r],
                           [0,0],
                           [frontRounded_r, frontRounded_r],
                           center = false);
      
      //////////////////////////////////////////////////////////////////////////
      // Crossbar and rear attachment with lip
      //////////////////////////////////////////////////////////////////////////
      translate(crossbarOrigin) rotate ([0,0,90])
        complexRoundSquare([crossbarThickness, crossbarTopLength],
                           [0,0],
                           [0,0],
                           [crossbarRounded_r, crossbarRounded_r],
                           [0,0],
                           center = false);


      translate(crossbarOverhangOrigin) rotate ([0,0,180])
        complexRoundSquare([crossbarThickness, crossbarOverhangLength],
                           [0,0],
                           [0,0],
                           [crossbarRounded_r, crossbarRounded_r],
                           [0,0],
                           center = false);

      translate(crossbarLipOrigin) rotate ([0,0,270])
        complexRoundSquare([crossbarThickness, crossbarLipLength],
                           [0,0],
                           [0,0],
                           [crossbarRounded_r, crossbarRounded_r],
                           [crossbarRounded_r, crossbarRounded_r],
                           center = false);

      //////////////////////////////////////////////////////////////////////////
      // Sloped front for holding screen and attachment
      //////////////////////////////////////////////////////////////////////////      
      translate(slopeOrigin)
        rotate ([0, 0, slopeRotationAngle])
        complexRoundSquare([slopeThickness, slopeLength],
                           [slopeRounded_r, slopeRounded_r],
                           [0,0],
                           [slopeRounded_r, slopeRounded_r],
                           [0,0],
                           center = false);

      translate(slopeUnderhangOrigin) rotate ([0, 0, slopeUnderhangAngleOrigin])
        complexRoundSquare([slopeThickness, slopeUnderhangLength],
                           [0,0],
                           [0,0],
                           [slopeRounded_r, slopeRounded_r],
                           [0,0],
                           center = false);

      translate(slopeLipOrigin) rotate ([0, 0, slopeLipAngleOrigin])
        complexRoundSquare([slopeThickness, slopeLipLength],
                           [0,0],
                           [0,0],
                           [slopeRounded_r, slopeRounded_r],
                           [slopeRounded_r, slopeRounded_r],
                           center = false);
    
    }

    //////////////////////////////////////////////////////////////////////////
    // some math for screw holes placement
    //
    // Reference:
    //  - https://github.com/raspberrypi/documentation/raw/master/hardware/display/7InchDisplayDrawing-14092015.pdf
    //////////////////////////////////////////////////////////////////////////
    screwHoleDiameter = 2.65; // M3.0 screws
    screwHoleRadius = screwHoleDiameter/2; 
    screwHoleLength = slopeThickness + 2*e ;

    toolHoleDiameter = 7.8; // Driver bit
    toolHoleRadius = toolHoleDiameter /2 ; // Driver bit
    toolHoleLength = 5*braceFrontThickness + 2*e ;

    screwHoleSeparationInFrame = 65.65;
    screwTopHoleFromFrameEdge = 21.58;
    FrameEdgeToBezelEdge = 6.63;
    measuredDistanceFromUnderhangToBottomHole = 28.5;
    screwHolePlacementZHeight = drill_hole_offset;
    screwBottomHoleTranslation = [-e, slopeInsideLength - measuredDistanceFromUnderhangToBottomHole, screwHolePlacementZHeight];
    screwTopHoleTranslation = screwBottomHoleTranslation + [0, -screwHoleSeparationInFrame, 0];
    screwToolHoleTranslation = screwTopHoleTranslation + [screwHoleLength, 0, 0];

    * translate(slopeOrigin)   rotate ([0, 0, slopeRotationAngle]) {
      union() {
        // drill two holes in slope
        translate(screwBottomHoleTranslation) rotate ([0, 90, 0])
          cylinder(h = screwHoleLength, r = screwHoleRadius, centered = true);
      
        translate(screwTopHoleTranslation) rotate ([0, 90, 0])
          cylinder(h = screwHoleLength, r = screwHoleRadius, centered = true);
      }
      // another hole for tool access in front of clamp
      translate(screwToolHoleTranslation) rotate ([0, 90, 0])
        cylinder(h = toolHoleLength, r = toolHoleRadius, centered = true);
    }
  }
  
}


module assemblyWithBraces(bracket_width, slope_angle, drill_offset_1, drill_offset_2) {

  a = slope_angle;

  drillHoleOffset1 = drill_offset_1;
  drillHoleOffset2 = drill_offset_2;
  
  displayX = 157.5;
  displayZ = 51;
  
  % translate([displayX,0,displayZ]) displayCover();
  % translate([displayX,0,displayZ]) raspiCover();

  // color("Red") translate([displayX - 3, 22, displayZ - 4])  rotate([0,90,0]) mountBrace();

  bracketWidth = bracket_width;
  bracketsXOffset =  43.5;
  bracketsYOffset =  29.5;
  bracketsZOffset =  120 - 52;

  drillHoleDelta = drillHoleOffset2 - drillHoleOffset1;
  
  translate([ bracketsXOffset      , bracketsYOffset, bracketsZOffset]) rotate([90, a, -90])
    myBrace(brace_width = bracketWidth, drill_hole_offset = drillHoleOffset1);
  translate([ bracketsXOffset + 126.2 + drillHoleDelta, bracketsYOffset, bracketsZOffset]) rotate([90, a, -90])
    myBrace(brace_width = bracketWidth, drill_hole_offset = drillHoleOffset2);
}

// Default behavior is to show printable
printable = false;
//printable = true;
showAssembly = true;
showAssembly = false;

// animation settings for assembly
/// $vpt = [100, 10, 80];
/// $vpr = [90, 0, $t * 360 * 2];
/// $vpd = 800;

if (showAssembly) {
  bracket_width = BRACKET_WIDTH;
  assemblyWithBraces(bracket_width = bracket_width, slope_angle = SLOPE_ANGLE,
                     drill_offset_1 = 6.5, drill_offset_2 = bracket_width/2);
} else {
  if (printable)
  {
     
    // bed two braces (each with different drill hole center-width offsets)
    //  - need to print with supports since there are the drill holes
    bracket_width = BRACKET_WIDTH;
    bracket_bed_spacing = 40;
    bed_spacing_center = bracket_bed_spacing / 2;
    bed_rot_angle = -(1/2)*(90 - SLOPE_ANGLE);
    
    translate([0, -bed_spacing_center, bracket_width]) rotate ([0, 180, bed_rot_angle ])
      myBrace(brace_width = 20, drill_hole_offset = 6.5);
    translate([0, +bed_spacing_center, bracket_width]) rotate ([0, 180, bed_rot_angle ])
      myBrace(brace_width = 20, drill_hole_offset = bracket_width/2);
  }
  else
  {
    bracket_width = BRACKET_WIDTH;

    // overlay on an example brace
    //color("Green")  translate([0,0,0]) rotate([0,90,0]) exampleBrace(); 
    translate([64.5,21,00]) rotate([0,0,0])
      myBrace(brace_width = bracket_width, drill_hole_offset = bracket_width/2);
  }
}

