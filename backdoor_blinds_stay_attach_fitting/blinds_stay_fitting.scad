
// Replace for metal stays that no longer function/are broken

//use <../libraries/MCAD/2Dshapes.scad>
include <../libraries/BOSL2/std.scad>

// small number
e = 1/128;

// felt useful to have this printer property as paramenter
nozzle_dia = 0.4;


orig_attach_plate_thickness = 1.0;
attach_plate_length = 25.0;
attach_plate_width = 12.0;
screw_hole_spacing = 18.0;
screw_hole_diameter = 3.5;
screw_hole_keepout_diameter = 9.0 ;
screw_hole_keepout_diameter_fudge = 1.0;
attach_plate_thickness = 3.6;

distance_from_plate_to_insert_hole = 25.0;
insert_hole_diameter = 4.6;
insert_extant = 5.0;
standout_length = 35.0;
standout_thickness = attach_plate_thickness;


module attach_plate () {
  $fn = 25;

  scr1_x = (1/2) * attach_plate_width;
  scr1_y = (1/2) * (attach_plate_length-screw_hole_spacing);

  scr2_x = scr1_x;
  scr2_y = scr1_y + screw_hole_spacing;

  scr_R = (1/2)*screw_hole_diameter;

  difference() {
    cube(size = [attach_plate_width, attach_plate_length, attach_plate_thickness], center = false);

    translate([scr1_x, scr1_y, -e])
      cylinder(h = attach_plate_thickness + 2*e, r = scr_R, center = false);

    translate([scr2_x, scr2_y, -e])
      cylinder(h = attach_plate_thickness + 2*e, r = scr_R, center = false);

  }
}

module standout () {
  $fn = 25;
  insert_punch_y = (1/2)*attach_plate_length;
  insert_punch_z = distance_from_plate_to_insert_hole;
  insert_punch_R = insert_hole_diameter / 2;

  scr1_x = (1/2) * attach_plate_width;
  scr1_y = (1/2) * (attach_plate_length-screw_hole_spacing);

  scr2_x = scr1_x;
  scr2_y = scr1_y + screw_hole_spacing;

  scr_R = (1/2) * (screw_hole_keepout_diameter + (1/2)*screw_hole_keepout_diameter_fudge);
  scr_Kh = standout_length;

  standout_start_x = (1/2)*(attach_plate_width + screw_hole_keepout_diameter);

  standout_full_width_start_z =  insert_punch_z - (insert_punch_R + 2.4);
  standout_full_width_h = standout_length - standout_full_width_start_z;

  standout_middle_y = scr1_y + scr_R;
  standout_middle_length = screw_hole_spacing - 2*scr_R;


  standout_taper_start_z = attach_plate_thickness + 5.0;
  standout_taper_stop_z = standout_full_width_start_z;
  standout_taper_start_x = standout_start_x;
  standout_taper_stop_x = 0;

  taper_z = standout_taper_stop_z - standout_taper_start_z;
  taper_x = -(standout_taper_stop_x - standout_taper_start_x);




  difference() {
    union() {
      translate([standout_start_x, 0, 0])
        cube(size=[standout_thickness, attach_plate_length, standout_length]);
      translate([0, standout_middle_y, standout_full_width_start_z])
        cube(size=[attach_plate_width, standout_middle_length, standout_full_width_h ]);
      translate([taper_x, attach_plate_length - standout_middle_y, standout_full_width_start_z])
        rotate([270,0,180])
        linear_extrude(h = standout_middle_length)
        right_triangle([ taper_x, taper_z], center=false);

    }

    union() {
      // insert punch
      translate(v = [-e, insert_punch_y, insert_punch_z])
        rotate([0, 90, 0])
        cylinder(h=insert_extant + 1.0, r = insert_punch_R, center=false);

      // screw hole keepouts =
      translate([scr1_x, scr1_y, attach_plate_thickness])
         cylinder(h = scr_Kh, r = scr_R, center = false);

      translate([scr2_x, scr2_y, attach_plate_thickness])
         cylinder(h = scr_Kh, r = scr_R, center = false);
    }
  }


}

attach_plate();

standout();
