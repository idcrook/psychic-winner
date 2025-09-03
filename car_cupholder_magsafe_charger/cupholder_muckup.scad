




use <../libraries/MCAD/2Dshapes.scad>
use <../libraries/local-misc/wedge.scad>

e = 1/128; // small number

show_assembly = true;


magsafe_desk_mount_stl = "Iphone 12 MagSafe Desk Dock - 4635725/files/magsafe_mount.stl";


cup_height = 87.0;

module single_look() {

  intersection() {
    modified_import();
    //cup_base();
  }
}

module modified_import () {

  outer_shroud_height = 10;
  difference () {
    union() {
      translate([-1,0,77-5*e])
        rotate([0,-60,0])
        import(magsafe_desk_mount_stl);

      // add tapered flange around inside and outside on interface so that less
      // support is needed.
      translate([0, 0, -outer_shroud_height+2*e]) {
        cup_outer_shround(height = outer_shroud_height);
      }
    }

    // cut hole to fill with coins (for weighting down)
    translate([-10, 0,-7])
      rotate([0,-30,0])
      coin_slot();
  }

}


module cup_outer_shround(d1 = 72.0, d2 = 76.2, height = 10, inner_open_diameter = 66.3) {
  $fn = 200;

  difference () {
    cylinder(h = height,
             r1 = d1/2, r2 = d2/2, center = false);
    translate([0,0,-e])
    cylinder(h = height + 2*e,
             r1 = inner_open_diameter/2, r2 = (inner_open_diameter-10)/2,

             center = false);

  }

}

module coin_slot () {

  coin_x = 20.5;
  coin_y = 38.5;

  linear_extrude(height = 40, center = false, convexity = 10)
        resize([coin_x, coin_y]) circle(d=coin_y);
}

module generateCupLid2 (d) {
  cupLidThickness = 4.5 - 1.0;

  coin_x = 38.5;
  coin_y = 20.5;

  difference () {
    translate([0,0,0])
      linear_extrude(height = cupLidThickness, center = false, convexity = 10)
      circle(d=d);

    translate([0,0,-e])
      linear_extrude(height = cupLidThickness + 2*e, center = false, convexity = 10)
        translate([0, d/2 - (1.5)*cupLidThickness - coin_y/2, 0])
        resize([coin_x, coin_y]) circle(d=coin_y);

    // translate([0,-d/4,-e])
    //   lidBracketHoles((3/4) * d/4, 3.0, cupLidThickness+e);
  }
}

module cup_base() {
  $fn = 60;
  translate([0,0,2.0]) generateCup2();
}

module generateCup2 () {

  cupRegionHeightAboveHolderBottom = 28.333 * 2;
  cupRegionHeightBelowHolderBottom = 28.334;
  // cupRegionHeightAboveHolderBottom = 27.667 * 2;
  // cupRegionHeightBelowHolderBottom = 27.667;

  holderBottomSectionSplitDiameter = 68.667;

  cupBaseThickness = 4.0;
  cupSideThickness = 3.0;
  cupSideSlope = 30/1;

  // two parts of side of cup (cones sections)

  // top section
  sideIncreaseTop = cupRegionHeightAboveHolderBottom * (1/cupSideSlope);
  top_t = cupRegionHeightBelowHolderBottom + (1/2)*cupRegionHeightAboveHolderBottom;
  top_h = cupRegionHeightAboveHolderBottom;
  top_r1 = holderBottomSectionSplitDiameter/2;
  top_r2 = holderBottomSectionSplitDiameter/2 + sideIncreaseTop;
  top_thickness = cupSideThickness;
  translate([0,0,top_t])
    difference () {
    cylinder(h = top_h,
             r1 = top_r1, r2 = top_r2, center=true);

    translate([0,0,e/2])
      cylinder(h = top_h + 2*e,
             r1 = top_r1 - top_thickness, r2 = top_r2 - top_thickness, center=true);
    }

  // bottom section
  sideDecreaseBottom = cupRegionHeightBelowHolderBottom * (1/cupSideSlope);
  bottom_t = cupRegionHeightBelowHolderBottom/2;
  bottom_h = cupRegionHeightBelowHolderBottom;
  bottom_r1 = holderBottomSectionSplitDiameter/2 - sideDecreaseBottom;
  bottom_r2 = top_r1;
  bottom_thickness = cupSideThickness;

  translate([0,0,bottom_t])
    difference () {
    cylinder(h = bottom_h, r1 = bottom_r1, r2 = bottom_r2, center=true);

    translate([0,0,e])
      cylinder(h = bottom_h + 2*e,
               r1 = bottom_r1 - bottom_thickness, r2 = bottom_r2 - top_thickness, center=true);
    }

  // base
  base_thickness = cupBaseThickness;
  base_t = base_thickness/2;

  translate([0,0,-base_t])
    linear_extrude(height = base_thickness, center = false, convexity = 10)
    circle(r = bottom_r1);

  echo("Top of cup Diameter:", 2*top_r2);
  echo("Base Diameter:", 2*bottom_r1);
  echo("sideIncreaseTop half:", sideIncreaseTop);
  echo("sideDecreaseBottom half:", sideDecreaseBottom);
  delta_diameter = 2*sideIncreaseTop + 2*sideDecreaseBottom;
  echo("delta diameter:", delta_diameter);
  echo("top", 2*top_r2, " should be approx ",  2*bottom_r1, "+",  delta_diameter, "=", 2*bottom_r1 + delta_diameter);

  totalCupHeight = base_t + bottom_h + top_h;
  echo("totalCupHeight:", totalCupHeight);
}


module assembly() {

  //intersection() {
  translate([0,0,0]) {
    cup_base();
  }

  translate([0,0,cup_height-e]) {
    modified_import();
  }
  //}
}

if (show_assembly) {
  assembly();
} else {
  single_look();

}
