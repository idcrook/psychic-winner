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

use <../libraries/MCAD/2Dshapes.scad>

// small number
e = 1/128;

// felt useful to have this printer property as paramenter
nozzle_dia = 0.4;

// bird house pole segment outer diameter
pole_OD = 25.4;
// bird house pole segment tapered, threaded portion outer diameter
pole_stem_OD = 23.6;
// length along pole of threaded area from end of segment
pole_stem_threaded_h = 18.0;
// spacing between thread ridges
thread_pitch = 4.0;
// the height of each thread ridge (spit-balled original value)
thread_depth = 0.8;

// 
thread_major_D = pole_stem_OD;
thread_minor_D = thread_major_D - 2* (thread_depth);

// bird house pole segment tapered portion total length to non-tapered portion
pole_stem_h = 35.0;
// pick a value of overlap in pole segment (non-tapered portion)
pole_cup_h = 25.0;

// bird house pole segment inner diameter (at  tapered, threaded portion end)
pole_ID = 20.2;

// pole_cup_h should have been called this cup_past_stem = 25.0;
// "cap" is cup + stem

// the print thickness (11 * 0.4 mm = 4.4 mm)
cap_thickness = 11.0 * nozzle_dia;

cup_inner_R = (1/2) * pole_OD;
cup_outer_R = cup_inner_R + cap_thickness;
stem_inner_R = (1/2) * pole_stem_OD;
stem_outer_R = stem_inner_R + cap_thickness;

// transition length between tapered, threaded portion and non-tapered portion
cup2stem_h = 3.0; // measured approximately

// the part of print that WS90 couples to with friction joint
insert_OD = 25.6; // actual spec is 1" or 25.4mm

// print radial thickness
insert_thickness = 11.0 * nozzle_dia;
insert_ID = insert_OD - (2 * insert_thickness); 
insert_inner_R = insert_ID / 2;
insert_outer_R = insert_OD / 2;

// transition from pole part of print to insert part
stem2insert_h = 6.0; // initial choice

// length inside WS90 along friction-hold coupling 
insert_inner_height = 49.5;  

// extend the length of insert beyond the overlapping portion
insert_outer_height = 12.7;  // this plus inner height is the height beyond pole

// 2D profile
module sideView () {
    start_cup_h = 0;
    start_stem_h = pole_cup_h + cup2stem_h;
    start_insert_h = start_stem_h + pole_stem_h + stem2insert_h;
    stop_insert_h = start_insert_h + insert_outer_height + insert_inner_height;
    profile_points = [
        // inside of cup
        [ cup_inner_R, start_cup_h], [ cup_inner_R, pole_cup_h], 
        // inside of stem
        [ stem_inner_R, start_stem_h], [ stem_inner_R, start_stem_h + pole_stem_h ], 
        // inside of insert
        [ insert_inner_R, start_insert_h], [insert_inner_R, stop_insert_h],

        // going down
        // outside of insert
         [insert_outer_R, stop_insert_h], [insert_outer_R, start_insert_h], 
         // outside of stem
         [stem_outer_R, start_stem_h + pole_stem_h], [stem_outer_R, start_stem_h],         
         // outside of cup
         [cup_outer_R, start_cup_h + pole_cup_h], [cup_outer_R, start_cup_h],   
    ];

    polygon(profile_points);
}


module revolve () {
    $fn=50;
    rotate_extrude(angle = 360, convexity = 10) {
        sideView();
    }
}

module tooth() {
    h = (1/4) * thread_pitch;
    depth = thread_depth;
    linear_extrude(height = h) {
        square(size = [depth,depth], center = false);
    }

}

module thread_teeth (n=4) {

    translate([0,0,0]) {
        for (i = [0 : n-1]) {
            translate([0, 0, i * thread_pitch]) tooth();
        }
    }
}

module full () {

    // TODO: set screw hole(s)
    use_set_screws = false;
    // plastic "teeth"
    use_thread_teeth = true;
    teeth_count = 2; // started at 4 but that instance was difficult to thread more than 2 
    upto_count = 4; // max number of teeth
    delta = upto_count - teeth_count;
    thread_teeth_start_h = pole_cup_h + cup2stem_h + pole_stem_h - pole_stem_threaded_h + thread_pitch*(1 + delta);

    thread_teeth_start_x = stem_inner_R - thread_depth ;
    thread_teeth_start_minus_x = - (stem_inner_R);

    //intersection() {
    revolve();
    if (use_thread_teeth) {
        translate([thread_teeth_start_x + e, 0, thread_teeth_start_h]) {
            thread_teeth(n=teeth_count);
        }
        translate([thread_teeth_start_minus_x - e, 0, thread_teeth_start_h - (1/2)*thread_pitch]) {
            thread_teeth(n=teeth_count);
        }


    }
    //}
}

//%thread_teeth();
//%sideView();
full();
