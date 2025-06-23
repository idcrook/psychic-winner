/* [Bolt holes in the corners] */

// Pick the size of the long threaded rods that run through
// the corners and hold everything together.
//
// These are the sizes that are commonly available at
// Home Depot or Lowes:
//
// 1/4 inch: 3.175
// #12     : 2.778125
// #10     : 2.38125 (default and recommended)
//
// Note: you should pick the same size and fudge factor
// for the ear parts.
///bolt_size = 2.38125;
bolt_size = 2.4;

// Make the bolt holes this much bigger than the size of the bolt
// to give a more comfortable fit
bolt_hole_fudge = 0.25; // [0:0.25:1]


/* [Hidden] */
// make the screw holes this much bigger than the
// actual screw for a more comfortable fit
// (a bigger number here will make the screws fit looser)
screw_hole_fudge = 0.15;
number_to_fit = 6;

height = 33.1423; // match the size of a 13 Pi rack
inner_width = 58;


/* this width allows for three trays on a10-inch rack using a 250mm (10")
   threaded rod

   (250 - (67.0 * 3)) / 2 = 24.5mm

   or nearly an inch (25.4mm) at each end of 250mm rod

*/

//outer_width = (450.85 - 20) / number_to_fit;
echo("original outer_width: ", 71.8083 );
outer_width = 67.0;
echo("USING outer_width: ", outer_width, );


length = 90;

bolt_column_size = 12;

// epsilon is used to slightly overlap pieces to help the previewer
epsilon = 0.001;

bolt_radius = bolt_size + bolt_hole_fudge;

wall_thickness = (outer_width - inner_width) / 2;
back_wall_thickness = 5;
floor_depth = 3;
tray_depth = 5;
tray_slot_depth = 2.5;
spacer_depth = 3;

sd_window_width = 40;
sd_window_height = height - (tray_depth + floor_depth)*2;
pillar_width = 10;
floor_window_width = sd_window_width;
floor_window_border = (inner_width - floor_window_width) / 2;
floor_window_length = length - back_wall_thickness - floor_window_border - bolt_column_size;
port_window_width = length - 2*pillar_width;
pcb_height = floor_depth + tray_depth + spacer_depth;

difference() {
    union() {
        // the main block
        cube([outer_width, length, height]);

        // the bolt columns
        translate([0, 0, floor_depth - bolt_column_size]) {
            cube([outer_width, bolt_column_size, bolt_column_size]);
        }
        translate([0, length-bolt_column_size, floor_depth - bolt_column_size]) {
            cube([outer_width, bolt_column_size, bolt_column_size]);
        }
    }

    // carve out the interior
    translate([wall_thickness, -epsilon, floor_depth]) {
        cube(  [inner_width,
                length - back_wall_thickness + epsilon,
                height - floor_depth + epsilon]);
    }

    // punch a hole for the sd card
    translate([ (outer_width - sd_window_width) / 2,
                length - back_wall_thickness - epsilon,
                tray_depth + floor_depth]) {
        cube([  sd_window_width,
                back_wall_thickness + 2*epsilon,
                height - 2*tray_depth - 2*floor_depth]);
    }

    // punch a hole for side port access
    translate([ -epsilon,
                pillar_width,
                pcb_height]) {
        cube([  outer_width + 2*epsilon,
                port_window_width,
                height - pcb_height - tray_depth - floor_depth]);
    }

    // punch a hole in the bottom
    translate([ wall_thickness + floor_window_border,
                bolt_column_size,
                -epsilon]) {
        cube([  floor_window_width,
                floor_window_length,
                floor_depth + 2*epsilon]);
    }

    // open a groove that the speaker jack can slide through
    translate([ wall_thickness - 2,
                -epsilon,
                pcb_height]) {
        cube([  2 + epsilon,
                pillar_width + 2*epsilon,
                8]);
    }

    // soften the leading edge a bit
    translate([ wall_thickness,
                0,
                floor_depth-0.5]) {
        rotate([25,0,0]) {
            cube([  inner_width,
                    2,
                    2]);
        }
    }

    // drill the bolt holes
    for (a=[bolt_column_size/2, length-bolt_column_size/2]) {
        translate([-epsilon, a, floor_depth - bolt_column_size/2]) {
            rotate([0, 90, 0]) {
                cylinder(   h=outer_width + 2*epsilon,
                            r=bolt_radius,
                            center=false,
                            $fn=360);
            }
        }
    }

    // trim the bolt hole columns
    for (a=[0, bolt_column_size, length-bolt_column_size, length]) {
        translate([-epsilon, a, floor_depth - bolt_column_size - 4]) {
            rotate([45, 0, 0]) {
                cube([outer_width + 2*epsilon, 5, 5]);
            }
        }
    }

    // cut the tray insert slots
    // note: the tray will be slightly narrower to
    // give a more comfortable fit. If it is too loose or too tight,
    // adjust the tray.
    for (a=[    wall_thickness,
                inner_width + wall_thickness]) {
        translate([ a,
                    -epsilon,
                    floor_depth + tray_depth/2]) {
            intersection() {
                rotate([0, 45, 0]) {
                    translate([-tray_depth/sqrt(2)/2, 0, -tray_depth/sqrt(2)/2]) {
                        cube([  tray_depth/sqrt(2),
                                length - back_wall_thickness + epsilon,
                                tray_depth/sqrt(2)]);
                    }
                }
                translate([-tray_depth/2+0.5, 0, -tray_depth/2]) {
                    cube([  tray_depth-1,
                            length - back_wall_thickness + epsilon,
                            tray_depth]);
                }
            }
        }
    }
}


// X-width 67.0
//translate([-90,0,0]) import("raspberry-pi-rack-1u-frame-10inch.stl");
