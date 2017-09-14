/*

  iPhone X Mechanical Mockups

  Modeled by David Crook
  14-Sep-2017
  https://www.idcrook.com

  Thingiverse:
    http://www.thingiverse.com/thing:458102/

  GitHub:
    https://github.com/idcrook/psychic-winner/tree/master/iphone_x_mockup

  Partly inspired by:
  - http://www.thingiverse.com/thing:458102/


  NOTES:

  - OpenSCAD generation relies on the MCAD library (https://github.com/openscad/MCAD)

  */


// * All measurements in millimeters * //


use <MCAD/2Dshapes.scad>

// very small number
e = 0.02;

/// Left side buttons

volume_up__height   =  5.7;
volume_up__depth    =  3.0;
volume_up__from_top = 42.0;
volume_up__curve_radius = 42.0;

volume_down__height   =  5.7;
volume_down__depth    =  3.0;
volume_down__from_top = 31.0;
volume_down__curve_radius = 31.0;

ringsilent_switch_cutout__height = 5.0;
ringsilent_switch_cutout__depth = 3.0;
ringsilent_switch_cutout__from_top = 3.0;
ringsilent_switch_cutout__curve_radius = 3.0;

// Face and sensors

truedepth_camera_sensor_bar__height   = 5.0;
truedepth_camera_sensor_bar__width    = 3.0;
truedepth_camera_sensor_bar__from_top = 3.0;
truedepth_camera_sensor_bar__curve_radius = 3.0;

speaker_top__height       = 5.0;
speaker_top__width        = 3.0;
speaker_top__from_top     = 3.0;
speaker_top__curve_radius = 3.0;

microphone_top__height       = 5.0;
// microphone_top__width        = 3.0;
microphone_top__from_top     = 3.0;
microphone_top__from_right   = 3.0;
microphone_top__curve_radius = 3.0;

display__width     =  60.0;
display__height    = 135.0;
display__recessed  =   0.0;
display__from_top  =   0.0;
display__from_right  =   0.0;

/// Right side buttons

side_button__height   =  5.7;
side_button__depth    =  3.0;
side_button__from_top = 31.0;
side_button__curve_radius = 31.0;

sim_slot__height   =  5.7;
sim_slot__depth    =  3.0;
sim_slot__from_top = 31.0;
sim_slot__curve_radius = 31.0;

/// Bottom sensors and connectors

speaker_bottom__depth        = 5.0;
speaker_bottom__width        = 3.0;
speaker_bottom__from_right   = 3.0;
speaker_bottom__curve_radius = 3.0;

microphone_bottom__depth        = 5.0;
microphone_bottom__width        = 3.0;
microphone_bottom__from_right   = 3.0;
microphone_bottom__curve_radius = 3.0;

lightning_connector__depth        = 5.0;
lightning_connector__width        = 3.0;
lightning_connector__from_right   = 3.0;
lightning_connector__curve_radius = 3.0;

bottom_right_grill__width        = 3.0;
bottom_right_grill__hole_radius  = 3.0;
bottom_right_grill__hole_count  = 5;
bottom_right_grill__from_right   = 3.0;





model_quality = 25;

//

module iphone_x (width, length, depth, corner_radius, edge_radius)
  {

    shell(width, length, depth, corner_radius, edge_radius);




  }



/// Utility modules


module shell(width, length, depth, corner_radius)
{
  face_corner_radius = corner_radius;

  // Try to parameterize the curves
  corner_r1 = face_corner_radius + 2;
  corner_r2 = face_corner_radius + 2 ;

  edge_curvature_radius = 1/2*depth;
  edge_offset = edge_curvature_radius;


  round_rect_offset_factor = 0.35 * face_corner_radius;
  display_round_rect_offset_factor = 0.35 * face_corner_radius;

  length_edge_extr_height = length - 2*face_corner_radius;
  width_edge_extr_height  = width  - 2*face_corner_radius ;
  corner_sphere_chop_height = 4;


  // generate the basic solid outline
  {
    difference() {

      // most of body
      hull($fn = 25)
      //% union($fn = 25)
      {

	// main rectangular region
	translate([round_rect_offset_factor,
		   round_rect_offset_factor,
		   0])
	{
	  linear_extrude(height = depth, center = false, convexity = 10)
	    complexRoundSquare([ width - 2*round_rect_offset_factor,
				 length - 2*round_rect_offset_factor ],
			       [corner_r1, corner_r2],
			       [corner_r1, corner_r2],
			       [corner_r1, corner_r2],
			       [corner_r1, corner_r2],
			       center=false);
	}


	// lower left corner
	translate([face_corner_radius, face_corner_radius, depth/2])
	{
	  intersection() {
	    sphere(r = face_corner_radius, $fn = 50);
	    cube(size = [10, 10, corner_sphere_chop_height], center = true);
	  }
	}

	// left length side
	translate([edge_curvature_radius, face_corner_radius, depth/2]) {

	  rotate([-90,0,0])
	    linear_extrude(height = length_edge_extr_height, center = false)
	    projection(cut = true)
	    sphere(r = edge_curvature_radius, $fn = 50) ;
	}

	// bottom width side
	translate([face_corner_radius, edge_curvature_radius, depth/2]) {
	  rotate([0,90,0])
	    linear_extrude(height = width_edge_extr_height, center = false)
	    projection(cut = true)
	    sphere(r = edge_curvature_radius, $fn = 50) ;
	}

	// upper left corner
	translate([face_corner_radius, length - face_corner_radius, depth/2])
	{
	  intersection() {
	    sphere(r = face_corner_radius, $fn = 50);
	    cube(size = [10, 10, corner_sphere_chop_height], center = true);
	  }
	}

	// upper right corner
	translate([width - face_corner_radius, length - face_corner_radius, depth/2])
	{
	  intersection() {
	    sphere(r = face_corner_radius, $fn = 50);
	    cube(size = [10, 10, corner_sphere_chop_height], center = true);
	  }
	}

	// right length side
	translate([width - edge_curvature_radius, length- face_corner_radius, depth/2]) {
	  rotate([90,0,0])
	    linear_extrude(height = length_edge_extr_height, center = false)
	    projection(cut = true)
	    sphere(r = edge_curvature_radius, $fn = 50) ;
	}

	// top width side
	translate([width - face_corner_radius, length- edge_curvature_radius, depth/2]) {
	  rotate([0,-90,0])
	    linear_extrude(height = width_edge_extr_height, center = false)
	    projection(cut = true)
	    sphere(r = edge_curvature_radius, $fn = 50) ;
	}

	// lower right corner
	translate([width - face_corner_radius, face_corner_radius, depth/2])
	{
	  intersection() {
	    sphere(r = face_corner_radius, $fn = 50);
	    cube(size = [10, 10, corner_sphere_chop_height], center = true);
	  }
	}


      }

    }
    // display main rectangular region
    translate([display_round_rect_offset_factor,
	       display_round_rect_offset_factor,
	       depth - 1])
    {
      color ("Black", alpha = 0.85)
	linear_extrude(height = 1 + e, center = false, convexity = 10)
	complexRoundSquare([ width - 2*display_round_rect_offset_factor,
			     length - 2*display_round_rect_offset_factor ],
			   [corner_r1, corner_r2],
			   [corner_r1, corner_r2],
			   [corner_r1, corner_r2],
			   [corner_r1, corner_r2],
			   center=false);
    }


  }
}


      /* * translate([edge_curvature_radius, edge_curvature_radius, depth/2]) */
      /* { */
      /* 	translate([0,                                   0,  0])  sphere(r = edge_curvature_radius, $fn = 50); */
      /* 	translate([width - 2*edge_curvature_radius,       0,  0])  sphere(r = edge_curvature_radius, $fn = 50); */
      /* 	translate([0,      length - 2*edge_curvature_radius,  0])  sphere(r = edge_curvature_radius, $fn = 50); */
      /* 	translate([width - (2.0*edge_curvature_radius), length - (2.0*edge_curvature_radius), 0]) sphere(r = edge_curvature_radius, $fn = 50); */
      /* } */





// Create it!
/// Gross iphone dimensions
iphone_x__height = 143.6;
iphone_x__width  =  70.9;
iphone_x__depth  =   7.7;
iphone_x__face_corner_radius = 5.5;
// iphone_x__edge_radius = iphone_x__depth / 2;


iphone_x(iphone_x__width, iphone_x__height, iphone_x__depth, iphone_x__face_corner_radius);
