////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2019-Mar-15
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
//
// Description:
//
//   This project is intended as a enhanced webcam attach for the overhaed
//   webcam/stand that came with RoboGrok kit.
//
// Revisions/Notes:
//
//  2019-Mar-15 : Initial revision
//
//  2019-Mar-17 : Lengthened wings; added optional "plug cap"
//
////////////////////////////////////////////////////////////////////////

// Dimension units in millimeters

mm_per_inch = 25.4;
outer_radius = 12.0 / 2;
inner_radius = 6.0 / 2;

slot_width = 4.2;
slot_width_div2 = slot_width / 2;

slot_height = 4.2;
slot_inner_radius_chord = 5.0;
slot_chord_div2 = slot_inner_radius_chord / 2;

plug_screw_head_diameter = 3.21 + 0.3; // measured + margin
plug_screw_head_radius = plug_screw_head_diameter/2;
plug_screw_head_countersink_radius = 0.4;
plug_screw_head_height = 1.3;
plug_cap_height = plug_screw_head_height + 0.1;

epsilon = 1/128; 

module slot_solid ( slot_width = slot_width, solid_x = slot_chord_div2, solid_y = slot_inner_radius_chord, z_height = slot_height)  {
   echo(slot_width, solid_x, solid_y, z_height);

    color("red")
    linear_extrude(height = z_height)
        translate([slot_width / 2 + 0, -solid_y/2])
            square(size = [solid_x, solid_y]);
}

brace_start_offset_from_center = outer_radius - 1;
brace_width = 5.3;
brace_length = ((3/4)*mm_per_inch) + 5;
brace_height = 1.8;

module brace_solid ( brace_start_x = brace_start_offset_from_center, solid_x = brace_length , solid_y = brace_width, 
                     z_height = brace_height, my_color = "green")  {
    echo(slot_width, solid_x, solid_y, z_height);

    color(my_color)
    linear_extrude(height = z_height)
        translate([brace_start_x + (solid_x/2), 0])
            square(size = [solid_x, solid_y], center = true);
}


module main_plug () {
    // rotate_extrude() rotates a 2D shape around the Z axis.
    color("blue")
        translate([0, 0, 0])
            rotate_extrude($fn = 80)
                polygon( points=[
                    [1,0],
                    [outer_radius, 0],
                    [outer_radius, 4.2],
                    [inner_radius, 6],
                    [inner_radius, 1],
                    [1,1]] );
}

module plug_cap () {
    // 
    color("yellow")
        translate([0, 0, 0])
            rotate_extrude($fn = 80)
                polygon( points=[
                    [plug_screw_head_radius + plug_screw_head_countersink_radius, 0],
                    [outer_radius, 0],
                    [outer_radius, plug_cap_height],
                    [plug_screw_head_radius, plug_cap_height],
                    ] );
}

// set to true so that screw for plug can be countersunk and doesn't protrude, enabling a flush mount on webcam stand
PLUG_CAP = true;
//PLUG_CAP = false;

main_plug ();
slot_solid();

rotate (a = 180)
  slot_solid();

if (PLUG_CAP) {
    translate([0,0, -(plug_cap_height) + epsilon]) 
        plug_cap();
}


rotate (a = 90) {
    brace_solid();
    if (PLUG_CAP) {
        translate([0,0, -(plug_cap_height) + epsilon])
            brace_solid(z_height = plug_cap_height, my_color = "yellow");
    }
}


rotate (a = 270) {
    brace_solid();
    if (PLUG_CAP) {
        translate([0,0, -(plug_cap_height) + epsilon])
            brace_solid(z_height = plug_cap_height, my_color = "yellow");
    }
}
