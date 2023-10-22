////////////////////////////////////////////////////////////////////////
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Description:
//
//
// Revisions/Notes:
//
//   2023-Jan-19: Update starting from previous design
//
// TODO:
//
//   - use external function for insertion slot (sleeve mount insert)
//
////////////////////////////////////////////////////////////////////////


use <files/iPhone_6_and_6_Plus_Mockups.scad>;
use <../libraries/MCAD/2Dshapes.scad>
include <../libraries/MCAD/units.scad>
use <../libraries/local-misc/wedge.scad>


// Width across mount
Width_Of_Mount = 78.74;

// Vertical spacing between crosss bars in basket
Vertical_Bar_Spacing = 114.30;

Height_Of_Mount = Vertical_Bar_Spacing + 10;

//
mount_insert_shift = Height_Of_Mount * (1/4);

module __Customizer_Limit__ () {}

e = 1/128; // small number

tolerance = 0.5;

module sleeveMountInsert (width, thickness, height, shouldTweak) {

  insertTailWidth = width;
  insertThickness = thickness;
  insertChopThickness = (1/2)*thickness;
  insertFullHeight = height;

  insertPartialHeight = 25.0 ;
  insertSlantedHeight = insertFullHeight - insertPartialHeight;
  insertSlantAngle = 62;
  insertSlantAngle2 = 65;

  insertChopThickness_x = shouldTweak ? insertChopThickness + tolerance : insertChopThickness;
  insertChopThickness_y = shouldTweak ? insertChopThickness + tolerance : insertChopThickness;
  r1 = shouldTweak ? 0 : 0;
  // empirically determined value when shouldTweak == false
  start_of_leading_edge = (1/2) * insertSlantedHeight * sin (insertSlantAngle);
  z_cover_leading_edge = start_of_leading_edge + 0.12 ;
  y_rot2_leading_edge = - 180 + insertSlantAngle2;

  rotateAngle = 12;

  echo("insertChopThickness_x:", insertChopThickness_x);
  echo("insertChopThickness_y:", insertChopThickness_y);

  difference() {
    linear_extrude(height = insertFullHeight, center = false, convexity = 10)
      difference() {
      complexRoundSquare([insertTailWidth, insertThickness],
                         [0,0], [0,0], [0,0], [0,0],
                         center = false);

      // vertical side nearest attach surface
      translate([-e, -e, 0])
        complexRoundSquare([insertChopThickness_x + e, insertChopThickness_y + e],
                           [0,0], [0,0], [r1,r1], [0,0],
                           center = false);

      // other vertical side nearest attach surface
      translate([insertTailWidth - insertChopThickness_x - e, -e, 0])
        complexRoundSquare([insertChopThickness_x + e, insertChopThickness_y + e],
                           [0,0], [0,0], [0,0], [r1,r1],
                           center = false);

      // this carves a small slant on the side rails
      if (shouldTweak) {
        translate([insertChopThickness_x, insertChopThickness_y, 0])
          rotate([0,0,180-rotateAngle])
          complexRoundSquare([insertChopThickness_x+2, insertChopThickness_y/2],
                             [0,0], [0,0], [0,0], [0,0],
                             center = false);
        translate([insertTailWidth - insertChopThickness_x, 0, 0])
          translate([0, insertChopThickness_y,0])
          rotate([0,0,270+rotateAngle])
          complexRoundSquare([insertChopThickness_x/2, insertChopThickness_y+2],
                             [0,0], [0,0], [0,0], [0,0],
                             center = false);
      }
    }
    // leading edges of upper wings of slot
    translate([insertChopThickness_x + 0*e + 0.1,
               insertChopThickness_y - 1*e ,
               start_of_leading_edge - 1*e - 0.0])
      rotate([0, y_rot2_leading_edge, 0])
      cube(10 + 2);
    translate([insertTailWidth - insertChopThickness_x - 0*e - 0.1,
               insertChopThickness_y - 1*e ,
               start_of_leading_edge - 1*e - 0.0])
      rotate([0, 90 - insertSlantAngle2 ,0])
      cube(10 + 2);
    translate([-e, -e, 0])
      mirror([0,0,0])
      rotate([0,0,0])
      cube([insertChopThickness_x + 2*e,insertChopThickness_y+2, z_cover_leading_edge]);
    translate([insertTailWidth + e, -e , 0])
      mirror([1,0,0])
      rotate([0,0,0])
      cube([insertChopThickness_x + 2*e,insertChopThickness_y+2, z_cover_leading_edge]);

    // carve leading edge main slope/angle
    translate([-1*e, -1*e, -1*e])
      rotate([-(90-insertSlantAngle),0,0])
      cube([insertTailWidth+2*e, insertFullHeight/2+2*e, insertFullHeight/2+2*e]);
  }
}


module basketMount(mount_insert_w, mount_insert_thickness, mount_insert_h, fitBetter) {

  // there are four basic design features of the bike basket mount:
  //
  //  1. main "block"
  //
  //  2. hooks for the basket frame cross-bars
  //
  //  3. zip-tie slots to secure to basket verticle bars
  //
  //  4. mount insert for sleeve (that holds a powerbank, etc.)
  //
  block_x = Width_Of_Mount;        // width of mount
  block_y = mount_insert_thickness - 2*e; // insert depth/thickness
  plate_thickness = 3.5;
  block_z = Height_Of_Mount ; // length of mount along frame

  mountInsert_w = mount_insert_w;
  mountInsert_h = mount_insert_thickness;

  enlargePunchScale = 1.00;

  surround_w = mount_insert_w + 16;
  surround_h = mount_insert_h - 0.0;

  remaining_w = block_x - surround_w;
  remaining_h = block_z - surround_h;
  include_bottom_plate = true;

  t_surround_x = (1/2) * (block_x - surround_w);
  t_surround_z = (block_z - surround_h) - mount_insert_shift;

  //  3. mount insert piece for inserting phone carrier
  translate_y = (mountInsert_h - enlargePunchScale*mountInsert_h);
  translate_x = (1/2) * (block_x - (mountInsert_w * enlargePunchScale));
  mountInsert_position = (enlargePunchScale - 1) * (translate_x) * 1/2;
  translate_z = block_z - mount_insert_h - mount_insert_shift ;

  difference() {

    // main "Block" surround insert groove
    union() {
        difference () {
          linear_extrude(height = block_z, center = false, convexity = 10)
            complexRoundSquare([block_x, block_y],
                               [0,0], [0,0], [0,0], [0,0],
                               center = false);
          translate([-e, -e, -e])
             difference () {
            linear_extrude(height = block_z + 2*e, center = false, convexity = 10)
              complexRoundSquare([block_x + 2*e, mountInsert_h +2*e],
                                 [0,0], [0,0], [0,0], [0,0], center = false);

            translate ([t_surround_x, -e, t_surround_z])
              linear_extrude(height = surround_h, center = false, convexity = 10)
              complexRoundSquare([surround_w, mountInsert_h],
                                 [0,0], [0,0], [0,0], [0,0], center = false);
          }
        }
    }

    scale([enlargePunchScale, enlargePunchScale, 1])
      translate([-mountInsert_position +  translate_x,
                 translate_y ,
                 translate_z + e])
      translate([0, -e, 0])
      rotate([0, 0, 0])
      sleeveMountInsert(mount_insert_w, mount_insert_thickness, mount_insert_h, fitBetter);
  }

  // Hooks and plate
  bar_diameter = 10.6;
  hookWidth = 12.7;
  hookThickness = 3.5;
  hookOverhang = 2.5;
  hookExtend = 4;
  innerPadding = 0.6;

  plate_width_half = (1/2) * remaining_w - hookWidth + 2*e;
  plate_start_height = 10;
  bottom_height = t_surround_z - plate_start_height;

  translate([0, block_y - plate_thickness, 0]) {

    // hooks
    translate([0, 0, block_z]) {

      translate([0,0,0])
        barHook ( diameter = bar_diameter, hook_width = hookWidth, hook_thickness = hookThickness, hook_overhang = hookOverhang,
                  hook_extend = hookExtend, inner_padding = innerPadding );

      translate([block_x - hookWidth,0,0])
        barHook ( diameter = bar_diameter, hook_width = hookWidth, hook_thickness = hookThickness, hook_overhang = hookOverhang,
                  hook_extend = hookExtend, inner_padding = innerPadding );
    }

    // extend hooks
    translate([0, 0, 0]) {

      translate([0,0,0])
        linear_extrude(height = block_z, center = false, convexity = 10)
        complexRoundSquare([hookWidth, plate_thickness],
                           [0,0], [0,0], [0,0], [0,0], center = false);

      translate([block_x - hookWidth,0,0])
        linear_extrude(height = block_z, center = false, convexity = 10)
        complexRoundSquare([hookWidth, plate_thickness],
                           [0,0], [0,0], [0,0], [0,0], center = false);

    }

    // build plate
    translate([0, 0, plate_start_height]) {

      // left
      translate([hookWidth-e,0,0])
        linear_extrude(height = block_z - plate_start_height, center = false, convexity = 10)
        complexRoundSquare([plate_width_half, plate_thickness],
                           [0,0], [0,0], [0,0], [0,0], center = false);

      // right
      translate([block_x - hookWidth - plate_width_half-e,0,0])
        linear_extrude(height = block_z - plate_start_height, center = false, convexity = 10)
        complexRoundSquare([plate_width_half, plate_thickness],
                           [0,0], [0,0], [0,0], [0,0], center = false);

      // bottom
      if (include_bottom_plate) {

      // left
        translate([hookWidth + plate_width_half - 1*e,0,0])
          linear_extrude(height = bottom_height + e, center = false, convexity = 10)
          complexRoundSquare([surround_w + 2*e, plate_thickness],
                           [0,0], [0,0], [0,0], [0,0], center = false);

      }

    }



  }

}


module test_basketMount(fit_better) {
  mountInsertWidth = 22;
  mountInsertThickness = 3*2;
  mountInsertHeight = 42;

  fitBetter = fit_better;

  translate([0, 0, 0])
    basketMount(mountInsertWidth, mountInsertThickness, mountInsertHeight, fitBetter);
}


module test_sleeveMountInsert (fit_better = true, translate_x = 0) {
  mountInsertWidth = 22;
  mountInsertThickness = 3*2;
  mountInsertHeight = 42;

  fitBetter = fit_better;

  translate([translate_x, 0, 0])
    sleeveMountInsert(mountInsertWidth, mountInsertThickness, mountInsertHeight, fitBetter);
}

module barHook (diameter = 10.6, hook_width = 12.7, hook_thickness = 3.5, hook_overhang = 4, hook_extend = 0, inner_padding = 0.6) {

  d_inside = diameter;

  thickness = hook_thickness;
  pad_inner = inner_padding;
  catch_overhang = hook_overhang;
  extend = hook_extend;

  r_outer = 3.5;
  r_inner = 2.5;


  // derived
  hook_overlap = d_inside + catch_overhang + thickness;
  hook_length = hook_overlap + extend;

  hook_stop = extend;

  hook_outside = diameter + 2*thickness + 2*pad_inner;
  hook_inside = diameter + 2*pad_inner;

  t_y = hook_outside;

  translate([0, t_y, 0])
  rotate([0,-90,180])
  linear_extrude(height = hook_width)
  difference() {
    complexRoundSquare([hook_length, hook_outside],
                       [0,0], [r_outer,r_outer],  [r_outer,r_outer], [0,0], center = false);
    union() {
      // cut off extend
      translate([-e, -e, 0])
        complexRoundSquare([hook_stop + 2*e, hook_outside - thickness],
                           [0,0], [0,0], [0,0], [0,0], center = false);
      // hook interior
      translate([hook_stop, thickness, 0])
        complexRoundSquare([hook_overlap - thickness, hook_inside],
                           [0,0], [r_inner,r_inner], [r_inner,r_inner], [0,0], center = false);
    }
  }
}


module test_barHook () {
  bar_diameter = 10.6;
  hookWidth = 12.7;
  hookThickness = 3.5;
  hookOverhang = 2.5;
  hookExtend = 4;
  innerPadding = 0.6;

  barHook ( diameter = bar_diameter, hook_width = hookWidth, hook_thickness = hookThickness, hook_overhang = hookOverhang,
            hook_extend = hookExtend, inner_padding = innerPadding );
}

CONTROL_OUTPUT_basketMount = true;

$fn = 100;

tweakMountSurface = true;

if (CONTROL_OUTPUT_basketMount) {
  // translate([-90,0,39])
  test_basketMount(tweakMountSurface);

  *test_barHook();

 }
