///////////////////////////////////////////////////////////////////////////////
// Initial Revision: 2020-May-04
// Author: David Crook <idcrook@users.noreply.github.com>
// Description: Model of 16mm "Telephoto" Lens for Raspberry Pi HQ Camera
//
// Revisions/Notes:
//
//   2020-May-04: Initial dimensions
//
//
//
///////////////////////////////////////////////////////////////////////////////

e = 1/128; // small number

// If true, model is instantiated by this file
DEVELOPING_Lens_16mm_model = false;

body_diameter_16mm = 39.00 - 1.00;
body_length_16mm = 50.00;
center_x_16mm = (1/2)*body_diameter_16mm;
center_y_16mm = (1/2)*body_diameter_16mm;
back_focal_length_16mm = 17.53;

base_ring_to_back_16mm = 4.0;

// other diameters
back_diameter_16mm = 1.0 * 25.4;
between_back_aperture_diameter_16mm = 36.0;
focus_ring_diameter_16mm = body_diameter_16mm;
between_aperture_focus_diameter_16mm = 37.0;
aperture_ring_diameter_16mm = body_diameter_16mm;
between_hood_focus_diameter_16mm = 37.0;
hood_ring_diameter_16mm = 39;// body_diameter_16mm;

// axial lengths
hood_ring_width_16mm = 13.4;
aperture_ring_width_16mm = 13.0;
focus_ring_width_16mm = 12;
space_between_aperture_back_16mm = 3.1;
space_between_aperture_focus_rings_16mm = 6.0;
space_between_hood_focus_rings_16mm = 3.5;

// middle of aperture and focus rings should be this distance
knob_spacing_16mm = 21.5;
knob_aperture_z_height_16mm = 4.5;
knob_aperture_delta_16mm = aperture_ring_width_16mm - knob_aperture_z_height_16mm;
knob_focus_z_height_16mm = 7.0;
knob_focus_delta_16mm = + knob_focus_z_height_16mm;

// front lens
front_outer_diameter_16mm =  hood_ring_diameter_16mm  ;
front_outer_diameter_lower_16mm =  33.5  ;
front_outer_height_16mm = 4;

front_inner_diameter_16mm =  body_diameter_16mm - 2*(7.0) ;
front_inner_diameter_upper_16mm = 37.0;
front_lens_z_height_16mm = hood_ring_width_16mm ;

module hollowCylinder(d=4, h=10, wallWidth=1, $fn=128)
{
	difference()
	{
		cylinder(d=d, h=h);
		translate([0, 0, -e]) { cylinder(d=d-(wallWidth*2), h=h+2*e); }
	}
}

module knob_16mm (d = 4, h = 6.0, h_stem = 2.0, d_stem = 1.5)  {
    main_height = h - h_stem;

    translate([0,0,0])
		cylinder(d=d_stem, h=h_stem);

    translate([0,0,h_stem])
		cylinder(d=d, h=main_height, $fn=24);
}

module front_lens_16mm (od = front_outer_diameter_16mm,
                        od2 = front_outer_diameter_lower_16mm,
                        h_od = front_outer_height_16mm,
                        id = front_inner_diameter_16mm,
                        id2 = front_inner_diameter_upper_16mm,
                        h = front_lens_z_height_16mm) {
    // match id2 -> id
    scale_factor = 1 + (id2-id)/id;
    // match od2 -> od
    outer_scale_factor = 1 + (od-od2)/od2;

    outer_non_taper_height = h - h_od;
    lens_thickness = 0.0;

    difference()
    {
        union () {
            linear_extrude(height = h_od,  scale = outer_scale_factor, center = false)
                circle(d = od2, $fn = 100);

            translate([0,0,h_od])
            linear_extrude(height = outer_non_taper_height, center = false)
                circle(d = od, $fn = 100);
        }

        translate([0,0, h_od-e])
            linear_extrude(height = outer_non_taper_height + 2*e,
                           scale = scale_factor, center = false)
            circle(d = id, $fn = 100);
    }
}

module lens_16mm_model () {

    center_x = center_x_16mm;
    center_y = center_y_16mm;

    body_diameter = body_diameter_16mm;
    body_length = body_length_16mm;

    back_focus_z_height = -base_ring_to_back_16mm;
    back_aperature_gap_z_height = +0;
    aperture_ring_z_height = back_aperature_gap_z_height + space_between_aperture_back_16mm;
    focus_aperture_gap_z_height = aperture_ring_z_height + focus_ring_width_16mm;
    focus_ring_z_height = focus_aperture_gap_z_height + space_between_aperture_focus_rings_16mm;
    focus_hood_gap_z_height = focus_ring_z_height + focus_ring_width_16mm;
    hood_ring_z_height = focus_hood_gap_z_height + space_between_hood_focus_rings_16mm;

    back_focus_shave_width = (1/2)*(body_diameter - back_diameter_16mm);
    focus_ring_shave_width = (1/2)*(body_diameter - focus_ring_diameter_16mm);
    aperture_ring_shave_width = (1/2)*(body_diameter - aperture_ring_diameter_16mm);
    hood_ring_shave_width = (1/2)*(body_diameter - hood_ring_diameter_16mm);
    between_aperture_back_shave_width = (1/2)*(body_diameter - between_back_aperture_diameter_16mm);
    between_aperture_focus_shave_width = (1/2)*(body_diameter - between_aperture_focus_diameter_16mm);
    between_hood_focus_shave_width = (1/2)*(body_diameter - between_hood_focus_diameter_16mm);

    calculated_knob_spacing = knob_aperture_delta_16mm + knob_focus_delta_16mm + space_between_aperture_focus_rings_16mm;

    calculated_total_height = hood_ring_z_height + hood_ring_width_16mm;

    // checks
    echo ("knob spacing from (aperture to focus) ", calculated_knob_spacing, " should be ", knob_spacing_16mm);
    echo ("total height ", calculated_total_height, " should be ", body_length_16mm);

    front_lens_overlap_z_height = hood_ring_z_height + (hood_ring_width_16mm - front_lens_z_height_16mm);

    translate([center_x, center_y, 0])
    difference()
    {
        union()
        {
            // bulk tube
            translate([0, 0, 0])
                cylinder(d = body_diameter, h = body_length - front_lens_z_height_16mm, center=false, $fn=100);

            // back focus (mount ring)
            translate([0, 0, back_focus_z_height-e])
                hollowCylinder(d=back_diameter_16mm, h=base_ring_to_back_16mm,
                               wallWidth=1.0);

            // "front lens" with hood shape
            translate([0, 0, front_lens_overlap_z_height-e])
                front_lens_16mm();
        }
        // SUBTRACTIVE - shave off outside diameters
        // aperture ring <-> back gap
        translate([0, 0, back_aperature_gap_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=space_between_aperture_back_16mm+2*e,
                       wallWidth=between_aperture_focus_shave_width);
        // aperture ring
        translate([0, 0, aperture_ring_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=aperture_ring_width_16mm+2*e,
                       wallWidth=aperture_ring_shave_width);
        // aperture <-> focus ring gap
        translate([0, 0, focus_aperture_gap_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=space_between_aperture_focus_rings_16mm+2*e,
                       wallWidth=between_aperture_focus_shave_width);
        // focus ring
        translate([0, 0, focus_ring_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=focus_ring_width_16mm+2*e,
                       wallWidth=focus_ring_shave_width);
        // hood <-> focus ring gap
        translate([0, 0, focus_hood_gap_z_height-e])
        hollowCylinder(d=body_diameter+2*e, h=space_between_hood_focus_rings_16mm+2*e,
                       wallWidth=between_hood_focus_shave_width);
    }

    // focus ring knob
    translate( [(1/2)*body_diameter_16mm,
               0 + focus_ring_shave_width - e,
               focus_ring_z_height + knob_focus_z_height_16mm])
        rotate([90,90,0])
        knob_16mm();

    // aperture ring knob
    translate([ (1/2)*body_diameter_16mm,
                0 - aperture_ring_shave_width - e,
               aperture_ring_z_height + knob_aperture_z_height_16mm])
        rotate([90,90,0])
        knob_16mm();
}

// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

if (DEVELOPING_Lens_16mm_model)  {
    lens_16mm_model();
}
