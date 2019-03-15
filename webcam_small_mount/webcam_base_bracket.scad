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
////////////////////////////////////////////////////////////////////////


outer_radius = 12.0 / 2;
inner_radius = 6.0 / 2;

slot_width = 4.2;
slot_width_div2 = slot_width / 2;

slot_height = 4.2;
slot_inner_radius_chord = 5.0;
slot_chord_div2 = slot_inner_radius_chord / 2;


module slot_solid ( slot_width = slot_width, solid_x = slot_chord_div2, solid_y = slot_inner_radius_chord, z_height = slot_height)  {
   echo(slot_width, solid_x, solid_y, z_height);

    color("red")
    linear_extrude(height = z_height)
        translate([slot_width / 2 + 0, -solid_y/2])
            square(size = [solid_x, solid_y]);
}

brace_start_offset_from_center = outer_radius - 1;
brace_width = 5.3;
brace_length = (25.4/2) + 5;
brace_height = 1.8;

module brace_solid ( brace_start_x = brace_start_offset_from_center, solid_x = brace_length , solid_y = brace_width, z_height = brace_height)  {
   echo(slot_width, solid_x, solid_y, z_height);

    color("green")
    linear_extrude(height = z_height)
        translate([brace_start_x + (solid_x/2), 0])
            square(size = [solid_x, solid_y], center = true);
}

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




slot_solid();

rotate (a = 180)
  slot_solid();



rotate (a = 90)
  brace_solid();

rotate (a = 270)
  brace_solid();
