
use <iPhone_6_and_6_Plus_Mockups.scad>;
use <MCADlocal/2Dshapes.scad>
use <wedge.scad>

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

  tolerance = 0.5;

  CONTROL_RENDER_cutoff_top = true;
  // CONTROL_RENDER_cutoff_top = false;

  CONTROL_RENDER_experiment3 = true;
  CONTROL_RENDER_experiment3 = false;

  CONTROL_RENDER_experiment4 = true;
  CONTROL_RENDER_experiment4 = false;

  wantThinner = true;
  //wantThinner = false;

  sleeveSideThickness   =  wantThinner ? 3.0 : 3.5;
  sleeveBottomThickness =  wantThinner ? 3.0 : 3.5;
  sleeveTopThickness    =  wantThinner ? 3.0 : 3.5;
  sleeveBaseThickness   =  wantThinner ? 3.0 : 3.5;

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
  volumeButtonsCutoutDepth = 7.7 + 2.3;
  volumeButtonsCutoutRadius = 2;
  erase_sleeveInner_l_left  = volumeButtonsHeightFromBottom;
  
  powerButtonHeightFromBottom = 117.7 - 1.0;
  powerButtonCutoutHeight = 12.2 + 2.0 + 1.0;
  powerButtonCutoutDepth = 7.7 + 2.3;
  powerButtonCutoutRadius = 2;
  erase_sleeveInner_l_right =   powerButtonHeightFromBottom;
  
  muteSwitchHeightFromBottom = 132.7;
  muteSwitchCutoutHeight = 12.2 + 3;
  muteSwitchCutoutDepth = 7.7 + 2.3;
  muteSwitchCutoutRadius = 2;

  cameraHeightFromBottom = 144.8;
  cameraCutoutHeight = 0.5 + 28.2 + 0.5;
  cameraCutoutDepth = 12.1;
  cameraCutoutRadius = cameraCutoutDepth/2-1;
  cameraHoleOffcenter = 5.5 - 0.5;

  speakerCutoutHeight = 22;
  speakerCutoutDepth = 5;
  speakerCutoutRadius = speakerCutoutDepth/2;
  speakerHoleOffcenter = 10.8 ;

  lightningCutoutHeight = 14.4;
  lightningCutoutDepth = lightningCutoutHeight/2;
  lightningCutoutRadius = lightningCutoutDepth/2;
  lightningHoleOffcenter = 0;

  headphoneMicCutoutHeight = 15 - 2;
  headphoneMicCutoutDepth = 7.2;
  headphoneMicCutoutRadius = lightningCutoutDepth/2;
  headphoneMicHoleOffcenter = 28.5 + 3.9 - 2;
  headphoneJackDiameter = 3.5;
  
  headphoneMicBoreDiameter = 8.0 + 0.2;
  headphoneMicBoreOffcenter = 28.5 + 2.6 + headphoneMicCutoutDepth -
    headphoneMicBoreDiameter;
  

  // Use some trig: http://mathworld.wolfram.com/CircularSegment.html
  bottomLipHeight = 18.0;
  bottomLipFingerprintDiameter = 17;
  bottomLipCutoutMaxWidth = 1.6 * bottomLipFingerprintDiameter;
  bottomLipCutoutArcRadius = 2.6*bottomLipCutoutMaxWidth;  // pick a multiple
  bottomLipCutoutArcDegrees = 2*asin(bottomLipCutoutMaxWidth/(2*bottomLipCutoutArcRadius));  // figure out how many degrees of arc this is
  
  // calculate the width of cutout at junction with base
  bottomLipCutout_r2 = bottomLipCutoutArcRadius - bottomLipHeight;
  bottomLipCutout_MinWidth = 2 * bottomLipCutout_r2 * tan((1/2) *bottomLipCutoutArcDegrees);

  // calculate how far we need to translate below to cut out enough
  bottomLipCutout_h = bottomLipCutoutArcRadius * cos((1/2)*bottomLipCutoutArcDegrees);

  intersection() {
    union() {
      union () {

        // fill in groove for part of sleeve below buttons
        if (!CONTROL_RENDER_experiment3) {
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
  
  
            // cut out size of iphone in case (includes tolerance)
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
            linear_extrude(height = sleeveSideThickness + 2*e, center = false, scale = 0.9, convexity = 10)
            complexRoundSquare( [volumeButtonsCutoutHeight, volumeButtonsCutoutDepth],
                                [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                [volumeButtonsCutoutRadius, volumeButtonsCutoutRadius],
                                center = false);

          // power button cutout
          translate([+1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (powerButtonCutoutDepth), powerButtonHeightFromBottom])
            rotate([0, 180 + 90, 0])
            linear_extrude(height = sleeveSideThickness + 2*e, center = false, scale = 0.9, convexity = 10)
            complexRoundSquare( [powerButtonCutoutHeight, powerButtonCutoutDepth],
                                [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                [powerButtonCutoutRadius, powerButtonCutoutRadius],
                                center = false);
      
          // mute switch cutout
          translate([-1 * ((1/2) * sleeveOuter_w + e), -(1/2) * (muteSwitchCutoutDepth), muteSwitchHeightFromBottom])
            mirror()
            rotate([0, 180 + 90, 0], center = true)
            linear_extrude(height = sleeveSideThickness + 2*e, center = false,  scale = 0.9, convexity = 10)
            complexRoundSquare( [muteSwitchCutoutHeight, muteSwitchCutoutDepth],
                                [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                [muteSwitchCutoutRadius, muteSwitchCutoutRadius],
                                center = false);

          // camera cutout
          /// echo("FIXME: camera hole placement");
          translate([cameraHoleOffcenter, (1/2) * sleeveInner_h - tolerance - e, cameraHeightFromBottom])
            rotate([90, 0, 0])
            mirror([0,0,1])
            linear_extrude(height = sleeveBottomThickness + 2*tolerance +2*e, center = false, convexity = 10)
            complexRoundSquare( [cameraCutoutHeight, cameraCutoutDepth],
                                [cameraCutoutRadius, cameraCutoutRadius],
                                [cameraCutoutRadius, cameraCutoutRadius],
                                [cameraCutoutRadius, cameraCutoutRadius],
                                [cameraCutoutRadius, cameraCutoutRadius],
                                center = false);

          if (CONTROL_RENDER_cutoff_top) {
            cutHeight  = CONTROL_RENDER_experiment3 ? 5 : l - 10.0 ;
            extrHeight = CONTROL_RENDER_experiment3 ? 200 : 26 ;
          
            echo("cutHeight:", cutHeight);
            translate([0,0, cutHeight])
              linear_extrude(height = extrHeight, center = false, convexity = 10)
              complexRoundSquare([sleeveOuter_w+e, sleeveOuter_h+e],
                                 [0,0],
                                 [0,0],
                                 [0,0],
                                 [0,0],
                                 center = true);
          }
        }
      }

      // base
      difference() {
        translate([0,0, -base_l])
          linear_extrude(height = base_l, center = false, convexity = 10)
          // 2D view for base of sleeve
          complexRoundSquare([sleeveOuter_w, sleeveOuter_h],
                             [sleeveOuter_r, sleeveOuter_r],
                             [sleeveOuter_r, sleeveOuter_r],
                             [sleeveOuter_r, sleeveOuter_r],
                             [sleeveOuter_r, sleeveOuter_r],
                             center = true);

        // handle speaker hole, lightning, headphone

        // speaker hole
        rotate([180,0,0])
          translate([-tolerance + speakerHoleOffcenter, -(1/2) * speakerCutoutDepth, -e])
          linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
          complexRoundSquare( [speakerCutoutHeight, speakerCutoutDepth],
                              [speakerCutoutRadius/2, speakerCutoutRadius/2],
                              [speakerCutoutRadius, speakerCutoutRadius],
                              [speakerCutoutRadius, speakerCutoutRadius],
                              [speakerCutoutRadius/2, speakerCutoutRadius/2],
                              center = false);

        // lightning hole
        rotate([180,0,0])
          translate([-tolerance, 0, -e])
          linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
          complexRoundSquare( [lightningCutoutHeight, lightningCutoutDepth],
                              [lightningCutoutRadius, lightningCutoutRadius],
                              [lightningCutoutRadius, lightningCutoutRadius],
                              [lightningCutoutRadius, lightningCutoutRadius],
                              [lightningCutoutRadius, lightningCutoutRadius],
                              center = true);

        // widen lightning hole
        rotate([180,0,0])
          translate([-tolerance, 0, -e])
          linear_extrude(height = base_l + 2*e, center = false, convexity = 10)
          complexRoundSquare( [lightningCutoutHeight - 5, lightningCutoutDepth + 2],
                              [lightningCutoutRadius/2, lightningCutoutRadius/2],
                              [lightningCutoutRadius/2, lightningCutoutRadius/2],
                              [lightningCutoutRadius/2, lightningCutoutRadius/2],
                              [lightningCutoutRadius/2, lightningCutoutRadius/2],
                              center = true);

        // headphone and Mic hole
        rotate([180,0,0]) {
          translate([-headphoneMicHoleOffcenter, -(1/2) * headphoneMicCutoutDepth, -e])
            linear_extrude(height = base_l + 2*e, center = false, convexity = 10) 
            complexRoundSquare( [headphoneMicCutoutHeight, headphoneMicCutoutDepth],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                center = false);
      
          translate([-headphoneMicBoreOffcenter, -(1/2) * headphoneMicBoreDiameter, -e])
            linear_extrude(height = base_l + 2*e, center = false, convexity = 10) 
            complexRoundSquare( [headphoneMicBoreDiameter, headphoneMicBoreDiameter],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                [headphoneMicCutoutRadius, headphoneMicCutoutRadius],
                                center = false);
      
        }    

    
      }    

      // Bottom lip with cutout for Home button / thumbprint sensor

      difference() {
        // 2D view for height of lip
        linear_extrude(height = bottomLipHeight, center = false, convexity = 10)
          difference () {
          complexRoundSquare([sleeveOuter_w, sleeveOuter_h],
                             [sleeveOuter_r, sleeveOuter_r],
                             [sleeveOuter_r, sleeveOuter_r],
                             [sleeveOuter_r, sleeveOuter_r],
                             [sleeveOuter_r, sleeveOuter_r],
                             center = true);
      
          // cut out size of iphone plus some additional
          scale ([1,1.22,1])
            complexRoundSquare([sleeveInner_w, sleeveInner_h],
                               [sleeveInner_r, sleeveInner_r],
                               [sleeveInner_r, sleeveInner_r],
                               [sleeveInner_r, sleeveInner_r],
                               [sleeveInner_r, sleeveInner_r],
                               center = true);
      
        }

        if (CONTROL_RENDER_cutoff_top) {
          cutHeight  = CONTROL_RENDER_experiment3 ? 5 : l - 10.0 ;
          extrHeight = CONTROL_RENDER_experiment3 ? 200 : 26 ;
          
          echo("cutHeight:", cutHeight);
          translate([0,0, cutHeight])
            linear_extrude(height = extrHeight, center = false, convexity = 10)
            complexRoundSquare([sleeveOuter_w+e, sleeveOuter_h+e],
                               [0,0],
                               [0,0],
                               [0,0],
                               [0,0],
                               center = true);
        }
    
    
        // cutout for fingerprint
        //// wedge(height, radius, degrees);
        echo ("Width of fingerprint cutout at base: ", bottomLipCutout_MinWidth);
        //echo("FIXME: add bevel to fingerprint cutout");

        translate([0, 0, bottomLipHeight-bottomLipCutout_h+e])
          rotate([90, 360-(90-bottomLipCutoutArcDegrees/2), 0])
          wedge (10, bottomLipCutoutArcRadius, bottomLipCutoutArcDegrees);
    
      }

    

      if (!CONTROL_RENDER_experiment3) {
        mountInsertWidth = 22;
        mountInsertThickness = 3;
        mountInsertHeight = 42;
  
        mountInsert_yTranslation = (1/2)*( tolerance + h + tolerance) + sleeveBottomThickness - e;
  
        translate([-mountInsertWidth/2, mountInsert_yTranslation, (0.56) * l - mountInsertHeight + base_l])
          sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, true);
      }
    }
    
    if (CONTROL_RENDER_cutoff_top && CONTROL_RENDER_experiment4) {
      keepHeight = 55;
      cutHeight  = l - 10.0 ;
      extrHeight = keepHeight ;
    
      translate([0,0, cutHeight - keepHeight])
      linear_extrude(height = extrHeight, center = false, convexity = 10)
        complexRoundSquare([sleeveOuter_w+e, sleeveOuter_h+e],
                           [0,0],
                           [0,0],
                           [0,0],
                           [0,0],
                           center = true);
    }
  } 
  
}

module sleeveMountInsert (width, thickness, height, shouldTweak) {

  insertTailWidth = width;
  insertThickness = 2*thickness;
  insertChopThickness = thickness;  
  insertFullHeight = height;
  
  insertPartialHeight = 30;
  insertSlantedHeight = insertFullHeight - insertPartialHeight;
  insertSlantAngle = 60;

  tolerance = 0.5;

  insertChopThickness_x = shouldTweak ? insertChopThickness + tolerance : insertChopThickness;
  insertChopThickness_y = shouldTweak ? insertChopThickness + tolerance : insertChopThickness;

  rotateAngle = 15;
  
  echo("insertChopThickness_x:", insertChopThickness_x);
  echo("insertChopThickness_y:", insertChopThickness_y);

  difference() {
    intersection () {
      linear_extrude(height = insertFullHeight, center = false, convexity = 10)
        difference() {
        complexRoundSquare([insertTailWidth, insertThickness],
                           [0,0],
                           [0,0],
                           [0,0],
                           [0,0],
                           center = false);
      
        translate([-e, -e, 0])
          complexRoundSquare([insertChopThickness_x, insertChopThickness_y],
                             [0,0],
                             [0,0],
                             [0,0],
                             [0,0],
                             center = false);
    
        translate([insertTailWidth - insertChopThickness_x + e, -e, 0])
          complexRoundSquare([insertChopThickness_x, insertChopThickness_y],
                             [0,0],
                             [0,0],
                             [0,0],
                             [0,0],
                             center = false);

        if (shouldTweak) {
          translate([insertChopThickness_x, insertChopThickness_y*(1),0])
            rotate([0,0,180-rotateAngle])
            complexRoundSquare([insertChopThickness_x+1, insertChopThickness_y],
                               [0,0],
                               [0,0],
                               [0,0],
                               [0,0],
                               center = false);
          
          translate([insertTailWidth - insertChopThickness_x + e, -e, 0])
            translate([0, insertChopThickness_y*(1),0])
            rotate([0,0,270+rotateAngle])
            complexRoundSquare([insertChopThickness_x, insertChopThickness_y+1],
                               [0,0],
                               [0,0],
                               [0,0],
                               [0,0],
                               center = false);

        }
      }

    
      rotate([insertSlantAngle,0,0])
        cube(insertFullHeight);
    
    }

    translate([insertChopThickness,
               insertChopThickness - 2*e,
               (1/2) * insertSlantedHeight * sin (insertSlantAngle) - e])
      rotate([360-(90-insertSlantAngle),0,90])
      cube(7);
  
    translate([insertTailWidth - insertChopThickness,
               insertChopThickness - 2*e,
               (1/2) * insertSlantedHeight * sin (insertSlantAngle) - e])
      rotate([0, (90 - insertSlantAngle) ,0])
      cube(7);
  }

}

module bicycleMount() {

  // there are four basic design features of the bike mount:
  //
  //  1. curvature for bike frame
  // 
  //  2. through hole around this curvature for a metal screw-band (for
  //     attaching to bike frame)
  //
  //  3. mount insert piece for inserting phone carrier
  //
  //  4. clip latch to "lock" iphone carrier into the mount unless released
  //

  block_x = 30.5;
  block_y = 24.0;
  block_z = 39.0;

  mountInsert_w = 22;
  mountInsert_h = 2*3;
  enlargePunchScale = 1.08;

  // http://mathworld.wolfram.com/CircularSegment.html
  heightOfArcedPortion = 7.8;
  chordLength = block_x;

  // R = (1/2) (a^2/4h + h)
  radiusOfCurvature = (1/2) * (pow(chordLength,2)/(4*heightOfArcedPortion) + heightOfArcedPortion);

  // r = R - h
  circleCenterDistanceFromCut = radiusOfCurvature - heightOfArcedPortion;
  
  thicknessOfBandSupport = 3.0;
  bandCutoutDistanceFromBlock = 10.5;

  bandCutoutStartOfNegative = (3/10)*block_z;
  bandCutoutStopOfNegative = (7/10)*block_z;

  lockClip_square = 10.0;
  lockClip_x = lockClip_square;
  lockClip_y = lockClip_square;
  lockClip_z = 6.6;
  lockClip_r = lockClip_square/2;
  lockClip_fr = lockClip_square/3;

  lockClipScrewDiameter = 2.5;
  
  difference() {
    linear_extrude(height = block_z, center = false, convexity = 10)
      difference () {
      complexRoundSquare([block_x, block_y],
                         [0,0],
                         [0,0],
                         [0,0],
                         [0,0],
                         center = false);

      //  1. curvature for bike frame
      translate([block_x/2, block_y + circleCenterDistanceFromCut,0])
        circle(r= radiusOfCurvature);
    }

    //  2. through hole around this curvature for a metal screw-band 
    translate([0,0,bandCutoutStartOfNegative])
      linear_extrude(height = bandCutoutStopOfNegative - bandCutoutStartOfNegative, center = false, convexity = 10)
      difference() {
      translate([-e, bandCutoutDistanceFromBlock,0])
        square([block_x+2*e, block_y]);
      
      translate([block_x/2, block_y + circleCenterDistanceFromCut,0])
        circle(r= radiusOfCurvature + thicknessOfBandSupport);
    }
      
   //  3. mount insert piece for inserting phone carrier
   scale([enlargePunchScale, enlargePunchScale, 1], center = false)
     translate([-50 + (1/2) * (block_x - (mountInsert_w * enlargePunchScale)) ,
                (mountInsert_h - enlargePunchScale*mountInsert_h), block_z - 42 + e])
     //test_sleeveMountInsert(true);
     test_sleeveMountInsert(false);
  }


  translate ([block_x , 0, block_z - lockClip_z]) {   
    linear_extrude(height = lockClip_z, center = false, convexity = 10)
      union() {

      difference () {
        complexRoundSquare([lockClip_x, lockClip_y],
                           [0,0],
                           [0,0],
                           [lockClip_r, lockClip_r],
                           [0,0],
                           center = false);
        translate([lockClip_x/2, lockClip_y/2,0])
          circle(r=lockClipScrewDiameter/2);

      }

      // upper curve
      translate([0, lockClip_y, 0]) {
        difference() {
          complexRoundSquare([lockClip_x, lockClip_y],
                             [0,0],
                             [0,0],
                             [0,0],
                             [0,0],
                             center = false);
          translate([-e, -e, 0])
            complexRoundSquare([lockClip_x + 2*e, lockClip_y + 2*e],
                               [lockClip_fr, lockClip_fr],
                               [0,0],
                               [0,0],
                               [0,0],
                               center = false);
        }
      }
    }
    
  }
  
  
}


module test_bicycleMount() {
        mountInsertWidth = 22;
        mountInsertThickness = 3;
        mountInsertHeight = 42;

        fitBetter = true;
        
        tolerance = 0.5;
        sleeveBottomThickness = 3.0;
          
        mountInsert_yTranslation = (1/2)*( tolerance + h + tolerance) + sleeveBottomThickness;
  
        translate([0, 0, 0])
          rotate([180,0,0])
          bicycleMount(mountInsertWidth, mountInsertThickness, mountInsertHeight, fitBetter);

}

module test_sleeveMountInsert (fit_better) {

        mountInsertWidth = 22;
        mountInsertThickness = 3;
        mountInsertHeight = 42;

        fitBetter = fit_better;
        
        tolerance = 0.5;
        sleeveBottomThickness = 3.0;
          
        mountInsert_yTranslation = (1/2)*( tolerance + h + tolerance) + sleeveBottomThickness;

        
        translate([50, 0, 0])
          sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, fitBetter);
}

module showTogether() {
  // iphone 6 Plus
  translate([tw, tl, th ]) iphone(77.8, 158.1, 7.1, 9.5);

  // incipio case
  * translate([0,0,0]) incipioNgpCase();

  * color ("White")
    translate ([200, 50, 0])
    import ("files/iPhone_Bike_Mount/mount_v4-case.stl");

  // design
  %translate([w/2,0,h/2]) rotate([360-90,0,0]) sleeveForEncasediPhone(w, l, h);
  
}

test1 = true;
test1 = false;


if (test1) {
  showTogether();
} else {
  $fn = 100;
  *translate([0,0,0]) sleeveForEncasediPhone(w, l, h);
  //test_sleeveMountInsert(true);
  test_bicycleMount();
}


