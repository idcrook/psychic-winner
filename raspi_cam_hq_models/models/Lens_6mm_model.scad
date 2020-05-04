///////////////////////////////////////////////////////////////////////////////
// Initial Revision: 2020-May-04
// Author: David Crook <idcrook@users.noreply.github.com>
// Description: Model of 6mm "Wide Angle" Lens for Raspberry Pi HQ Camera
//
// Revisions/Notes:
//
//   2020-May-04: Initial dimensions
//
// TODO:
//
//
///////////////////////////////////////////////////////////////////////////////

e = 1/128; // small number

// If true, model is instantiated by this file
DEVELOPING_Lens_6mm_model = false;

body_diameter_6mm = 30.00;
body_length_6mm = 34.00;
center_x_6mm = (1/2)*body_diameter_6mm;
center_y_6mm = (1/2)*body_diameter_6mm;
back_focal_length_6mm = 7.53;

focus_ring_to_back = 5.0;

// other diameters
back_diameter = 1.0 * 25.4;
focus_ring_diameter = body_diameter_6mm;
between_aperture_focus_diameter = body_diameter_6mm - 2*(1.5);
aperture_ring_diameter = body_diameter_6mm;
between_hood_aperture_diameter = body_diameter_6mm - 2*(1.5);
hood_ring_diameter = body_diameter_6mm;

// axial lengths
hood_ring_width = 7;
aperture_ring_width = 10;
focus_ring_width = 8;
space_between_aperture_focus_rings = 2;
space_between_hood_aperture_rings = 2;

// middle of aperture and focus rings should be this distance
knob_spacing = 11.10;

// front lens
front_outer_diameter_6mm =  body_diameter_6mm  ;
front_inner_diameter_6mm =  body_diameter_6mm - 2*(7.0) ;
front_inner_diameter_upper_6mm = body_diameter_6mm - 2*(4.0);
front_lens_z_height_6mm = (2/3)*hood_ring_width ;

module hollowCylinder(d=4, h=10, wallWidth=1, $fn=128)
{
	difference()
	{
		cylinder(d=d, h=h);
		translate([0, 0, -e]) { cylinder(d=d-(wallWidth*2), h=h+2*e); }
	}
}

module knob (d = 3, h = 5, h_stem = 0.5, d_stem = 1.5)  {
    main_height = h - h_stem;

    translate([0,0,0])
		cylinder(d=d_stem, h=h_stem);

    translate([0,0,h_stem])
		cylinder(d=d, h=main_height);
}

module front_lens (od = front_outer_diameter_6mm,
                   id = front_inner_diameter_6mm,
                   id2 = front_inner_diameter_upper_6mm,
                   h = front_lens_z_height_6mm) {
    scale_factor = 1 + (id2-id)/id;
    lens_thickness = 0.0;

    difference() {
        linear_extrude(height = h, center = false)
            circle(d = od, $fn = 100);
        translate([0,0,lens_thickness-e])
            linear_extrude(height = h - lens_thickness + 2*e,
                           scale = scale_factor, center = false)
            circle(d = id, $fn = 100);
    }
}

module lens_6mm_model () {

    center_x = center_x_6mm;
    center_y = center_y_6mm;

    body_diameter = body_diameter_6mm;
    body_length = body_length_6mm;

    back_focus_z_height = 0;
    focus_ring_z_height = focus_ring_to_back;
    focus_aperture_gap_z_height = focus_ring_z_height + focus_ring_width;
    aperture_ring_z_height = focus_aperture_gap_z_height + space_between_aperture_focus_rings;
    aperture_hood_gap_z_height = aperture_ring_z_height + aperture_ring_width;
    hood_ring_z_height = aperture_hood_gap_z_height + space_between_hood_aperture_rings;

    back_focus_shave_width = (1/2)*(body_diameter - back_diameter);
    focus_ring_shave_width = (1/2)*(body_diameter - focus_ring_diameter);
    aperture_ring_shave_width = (1/2)*(body_diameter - aperture_ring_diameter);
    hood_ring_shave_width = (1/2)*(body_diameter - hood_ring_diameter);
    between_aperture_focus_shave_width = (1/2)*(body_diameter - between_aperture_focus_diameter);
    between_hood_aperture_shave_width = (1/2)*(body_diameter - between_hood_aperture_diameter);

    calculated_knob_spacing = (1/2)*(aperture_ring_width + focus_ring_width)
        + space_between_aperture_focus_rings;

    calculated_total_height = hood_ring_z_height + hood_ring_width;

    // checks
    echo ("knob spacing from (aperture to focus) ", calculated_knob_spacing, " should be ", knob_spacing);
    echo ("total height ", calculated_total_height, " should be ", body_length_6mm);

    front_lens_overlap_z_height = hood_ring_z_height + (hood_ring_width - front_lens_z_height_6mm);

    translate([center_x, center_y, 0])
    difference()
    {
        // TODO: back focus "keepout"
        union()
        {
            // bulk tube
            translate([0, 0, 0])
                cylinder(d = body_diameter, h = body_length - front_lens_z_height_6mm, center=false, $fn=100);

            // front lens
            intersection ()
            {
                // hood ring
                translate([0, 0, front_lens_overlap_z_height-e])
                    cylinder(d = body_diameter, h = front_lens_z_height_6mm, center = false, $fn=100);
                // "front lens" shape
                translate([0, 0, front_lens_overlap_z_height-e])
                    front_lens();
            }
        }
        // SUBTRACTIVE - shave off outside diameters
        // back focus
        translate([0, 0, back_focus_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=focus_ring_to_back+2*e,
                       wallWidth=back_focus_shave_width);
        // focus ring
        translate([0, 0, focus_ring_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=focus_ring_width+2*e,
                       wallWidth=focus_ring_shave_width);
        // aperture <-> focus ring gap
        translate([0, 0, focus_aperture_gap_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=space_between_aperture_focus_rings+2*e,
                       wallWidth=between_aperture_focus_shave_width);
        // aperture ring
        translate([0, 0, aperture_ring_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=aperture_ring_width+2*e,
                       wallWidth=aperture_ring_shave_width);
        // hood <-> aperture ring gap
        translate([0, 0, aperture_hood_gap_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=space_between_hood_aperture_rings+2*e,
                       wallWidth=between_hood_aperture_shave_width);
        // hood ring
        translate([0, 0, hood_ring_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=hood_ring_width+2*e,
                       wallWidth=hood_ring_shave_width);
    }

    // focus ring knob
    translate([body_diameter_6mm - focus_ring_shave_width - e,
               (1/2)*body_diameter_6mm,
               focus_ring_z_height+(1/2)*focus_ring_width])
        rotate([0,90,0])
        knob();

    // aperture ring knob
    translate([body_diameter_6mm - aperture_ring_shave_width - e,
               (1/2)*body_diameter_6mm,
               aperture_ring_z_height+(1/2)*aperture_ring_width])
        rotate([0,90,0])
        knob();
}

// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

if (DEVELOPING_Lens_6mm_model)  {
    lens_6mm_model();
}
