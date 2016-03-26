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


use <ruler.scad>
use <MCAD/shapes.scad>
use <MCAD/2Dshapes.scad>

// small number
e=.02;

module displayCover() {
    %import("/Users/dpc/projects/3dprint/OctoPi_LulzMini_7in/Raspberry_Pi_7in_display_Case_and_stand/files/Front.stl");
}

module raspiCover() {
    %import("/Users/dpc/projects/3dprint/OctoPi_LulzMini_7in/Raspberry_Pi_7in_display_Case_and_stand/files/Back.stl");
}

module mountBrace() {
    %import("/Users/dpc/projects/3dprint/OctoPi_LulzMini_7in/7_inch_raspberry_pi_touch_screen_stand/files/7-inch-raspberry-pi-stand-wide-hole.stl");
}


module updated_mountBrace() {
    import("/Users/dpc/projects/3dprint/OctoPi_LulzMini_7in/7_inch_raspberry_pi_touch_screen_stand/files/7-inch-raspberry-pi-stand-wide-hole.stl");
}

module exampleBrace() {
    import("/Users/dpc/projects/3dprint/OctoPi_LulzMini_7in/MatterControl_Touch_holder_for_Lulzbot_Min/MCTouch_Holder.STL");
}


$fn = 36;
module myBrace(brace_width, drill_hole_offset) {
    
  braceWidth = brace_width;
  frontRounded_r = braceWidth / 4;

  braceFrontThickness = 8;
  againstFrontLength = 46;

  crossbarInsideLength = 62;
  crossbarThickness = 0.4 * braceFrontThickness;
  crossbarRounded_r = crossbarThickness/2.5;
  
  crossTopCorner = [0, againstFrontLength, 0];
  crossbarOrigin =  crossTopCorner + [0, -crossbarThickness, 0];
  crossbarTopLength = crossbarInsideLength + crossbarThickness;

  crossbarOverhangInsideLength = 3.5;

  crossbarOverhangOrigin =  crossbarOrigin + [-crossbarTopLength,0,0];
  crossbarOverhangLength = crossbarOverhangInsideLength + crossbarThickness;
  crossbarLipInsideLength = 3;

  crossbarLipOrigin =  crossbarOverhangOrigin + [0, -crossbarOverhangInsideLength, 0];
  crossbarLipLength =  crossbarLipInsideLength + 1;
  
  slopeInsideLength = 120;
  slopeThickness = 0.5 * braceFrontThickness;
  slopeRounded_r = slopeThickness/2;

  slopeTopCorner = crossTopCorner;
  slopeOrigin =  slopeTopCorner + [1/2*(braceFrontThickness) + 1/4*(slopeThickness),0,0];
  slopeLength = slopeInsideLength + slopeThickness;

  slopeAngle = 90 - 60;
  slopeRotationAngle = 180 + slopeAngle;

  slopeUnderhangInsideLength = 15;
  slopeUnderhangAngleOrigin =  slopeRotationAngle + 90;
  
  slopeToUnderhangOriginLength = slopeLength - slopeThickness;
  slopeUnderhangOrigin =  slopeOrigin + slopeToUnderhangOriginLength * [ cos(slopeUnderhangAngleOrigin),
                                                                         sin(slopeUnderhangAngleOrigin), 0];
  slopeUnderhangLength = slopeUnderhangInsideLength + slopeThickness; 
  
  slopeLipInsideLength = 10;
  slopeLipAngleOrigin =  slopeRotationAngle + 180;
  
  slopeUnderhangToLipLength = slopeUnderhangLength - slopeThickness;
  slopeLipOrigin = slopeUnderhangOrigin + slopeUnderhangToLipLength * [ cos(slopeLipAngleOrigin), sin(slopeLipAngleOrigin), 0];
  slopeLipLength = slopeLipInsideLength + slopeThickness; 
  
  
  difference() {
    linear_extrude(height = braceWidth, center = false, convexity = 10,  $fn = 100)
      union() {

      //////////////////////////////////////////////////////////////////////////
      // Front of Lulzbot mini frame
      //////////////////////////////////////////////////////////////////////////
      complexRoundSquare([braceFrontThickness, againstFrontLength],
                         [0,0],
                         [frontRounded_r, frontRounded_r],
                         [frontRounded_r, frontRounded_r],
                         [0,0],
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


      translate(crossbarOverhangOrigin + [crossbarThickness,0,0]) rotate ([0,0,180])
        complexRoundSquare([crossbarThickness, crossbarOverhangLength],
                           [0,0],
                           [0,0],
                           [crossbarRounded_r, crossbarRounded_r],
                           [0,0],
                           center = false);

      translate(crossbarLipOrigin + [crossbarThickness,0,0]) rotate ([0,0,270])
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
        complexRoundSquare([slopeThickness, slopeUnderhangLength],
                           [0,0],
                           [0,0],
                           [slopeRounded_r, slopeRounded_r],
                           [slopeRounded_r, slopeRounded_r],
                           center = false);
    
    
    }

    
    // some math for screw holes placement
    // Reference: https://github.com/raspberrypi/documentation/raw/master/hardware/display/7InchDisplayDrawing-14092015.pdf
    screwHoleDiameter = 3; // M3.0 screws
    screwHoleLength = slopeThickness + 2*e ;

    toolHoleDiameter = 8; // Driver bit
    toolHoleLength = 3*braceFrontThickness + 2*e ;

    screwHoleSeparationInFrame = 65.65;
    screwTopHoleFromFrameEdge = 21.58;
    FrameEdgeToBezelEdge = 6.63;
    measuredDistanceFromUnderhangToBottomHole = 28;
    screwHolePlacementZHeight = drill_hole_offset;
    screwBottomHoleTranslation = [-e, slopeInsideLength - measuredDistanceFromUnderhangToBottomHole, screwHolePlacementZHeight];
    screwTopHoleTranslation = screwBottomHoleTranslation + [0, -screwHoleSeparationInFrame, 0];
    screwToolHoleTranslation = screwTopHoleTranslation + [screwHoleLength, 0, 0];

    translate(slopeOrigin)   rotate ([0, 0, slopeRotationAngle])
      union() {
      // drill two holes in slope
      translate(screwBottomHoleTranslation) rotate ([0, 90, 0]) 
        cylinder(h = screwHoleLength, r1 = screwHoleDiameter/2, r2 = screwHoleDiameter/2, centered = true); 
      
      translate(screwTopHoleTranslation) rotate ([0, 90, 0])
        cylinder(h = screwHoleLength, r1 = screwHoleDiameter/2, r2 = screwHoleDiameter/2, centered = true);

      // another hole for tool access in front of clamp
      translate(screwToolHoleTranslation) rotate ([0, 90, 0])
        cylinder(h = toolHoleLength, r1 = toolHoleDiameter/2, r2 = toolHoleDiameter/2, centered = true);
      }


  }

  
}


module assemblyWithBraces() {
//translate([0,0,0]) xruler(); 

translate([152,0,52]) displayCover();
translate([152,0,52]) raspiCover();

translate([38,34,120-46+10])  rotate([90, 90 - 60, -90]) myBrace(brace_width = 20, drill_hole_offset = 6.5);
translate([167,34,120-46+10]) rotate([90, 90 - 60, -90]) myBrace(brace_width = 20, drill_hole_offset = 20/2);
}

//assemblyWithBraces();
myBrace(brace_width = 20, drill_hole_offset = 8);

//translate([149, 22, 48])  rotate([0,90,0]) mountBrace();
// color("Yellow") translate([40,0,0]) rotate([0,0,135]) updated_mountBrace(); 
/* color("Green")  translate([0,0,0]) rotate([0,90,0]) exampleBrace(); 
                translate([64.5,32.5,00]) rotate([0,0,0]) myBrace(); */
