/*

  iPhone 11 Pro Mechanical Mockups dummy model

  Modeled by David Crook - https://github.com/idcrook

  2019-Sep-16

  Thingiverse:
    http://www.thingiverse.com/thing:

  GitHub:
    https://github.com/idcrook/psychic-winner/tree/master/iphone_11_pro_mockup


  NOTES:

  - OpenSCAD generation relies on the MCAD library (https://github.com/openscad/MCAD)

  */


// * All measurements in millimeters * //


use <MCAD/2Dshapes.scad>

// very small number
e = 0.02;

/// Gross iPhone 11 Pro dimensions
iphone_11_pro__height = 144.0;
iphone_11_pro__width  =  71.4;
iphone_11_pro__depth  =   8.1;
iphone_11_pro__z_mid  =   iphone_11_pro__depth / 2;

// estimate
iphone_11_pro__face_corner_radius = 7.0;
iphone_11_pro__edge_radius = (iphone_11_pro__depth - 0.25) / 2 ;


// "from_top" measurements are to center/midpoint of object

/// Left side buttons
volume_up__height   =  5.88 * 2;
volume_up__depth    =  2.88;
volume_up__from_top = 37.84;
volume_up__bump = 0.38;

volume_down__height   =  5.88 * 2;
volume_down__depth    =  2.88;
volume_down__from_top = 51.37;
volume_down__bump = 0.38;

ringsilent_switch_cutout__height = 5.71;
ringsilent_switch_cutout__depth = 2.08;
ringsilent_switch_cutout__from_top = 24.72;
ringsilent_switch_cutout__bump = 0.43;

/// Right side buttons

side_button__height   =  8.77 * 2;
side_button__depth    =  2.88;
side_button__from_top = 44.61;
side_button__bump     =  0.38;

sim_slot__height   =  16.03;
sim_slot__depth    =  2.66;
sim_slot__from_top = 71.67 + (1/2)*(sim_slot__height);
sim_slot__bump     =  0.03;  // flush actually


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

display__width     =  62.33;
display__height    = 134.95;
display__recessed  =   0.0;
display__from_top  =   0.0;
display__from_right  =   0.0;

display_glass__width     =  67.37;
display_glass__height    = 139.99;
display_glass_over__width = (1/2)*(display_glass__width - display__width);    // ~2.5 mm
display_glass_over__height = (1/2)*(display_glass__height - display__height); // ~2.5 mm

/// Bottom sensors and connectors
// from_left -> hole centers

grill_hole__diameter = 1.45;
screw_bottom__diameter = 1.60;

// other side of lightning port from speaker
mic1_bottom__hole_1__from_left = 19.07;
//mic1_bottom__hole_2__from_left = ;
mic1_bottom__hole_3__from_left = 25.03;

// next to speaker grill
mic2_bottom__hole_1__from_left = 46.33;
// (port of speaker ports)
mic2_bottom__hole_6__from_left = 59.06;



//
lightning_connector__width        = 11.0; // est. (observe keepout)
lightning_connector__height       = 3.01;
lightning_connector__from_right   = 35.68; // center

lightning_connector_keepout__radius  = 3.4;
lightning_connector_keepout__width   = 13.65;
lightning_connector_keepout__height  = 6.85;
lightning_connector_keepout__outward = 14.0;


model_quality = 25;

function translate_y_from_top (from_top)  = iphone_11_pro__height - from_top;


module iphone_11_pro (width, length, depth, corner_radius = 7, edge_radius = 3.925)
  {
    // fixme: add an inset translate so that, including buttons, is bound {x,y} >= {0,0}
    shell(width, length, depth, corner_radius, edge_radius);

    // ring/silent switch
    translate([-ringsilent_switch_cutout__bump,
               translate_y_from_top(ringsilent_switch_cutout__from_top),
               iphone_11_pro__z_mid]) {
      rotate([90,0,90])
        linear_extrude(ringsilent_switch_cutout__bump+e)
        square([ringsilent_switch_cutout__height, ringsilent_switch_cutout__depth],center=true);
      }

    // volume up button
    translate([-volume_up__bump,
               translate_y_from_top(volume_up__from_top),
               iphone_11_pro__z_mid]) {
      rotate([90,0,90])
        linear_extrude(volume_up__bump+e)
        square([volume_up__height, volume_up__depth],center=true);
      }

    // volume down button
    translate([-volume_down__bump,
               translate_y_from_top(volume_down__from_top),
               iphone_11_pro__z_mid]) {
      rotate([90,0,90])
        linear_extrude(volume_down__bump+e)
        square([volume_down__height, volume_down__depth],center=true);
      }

    // side button
    translate([iphone_11_pro__width-e,
               translate_y_from_top(side_button__from_top),
               iphone_11_pro__z_mid]) {
      rotate([90,0,90])
        linear_extrude(side_button__bump+e)
        square([side_button__height, side_button__depth],center=true);
      }

    // sim slot
    translate([iphone_11_pro__width-e,
               translate_y_from_top(sim_slot__from_top),
               iphone_11_pro__z_mid]) {
      rotate([90,0,90])
        linear_extrude(sim_slot__bump+e)
        square([sim_slot__height, sim_slot__depth],center=true);
      }



  }



/// Utility modules


module shell(width, length, depth, corner_radius, edge_radius)
{
  face_corner_radius = corner_radius;

  // Try to parameterize the curves
  corner_r1 = face_corner_radius - 2;
  corner_r2 = face_corner_radius - 2 ;

  edge_curvature_radius = edge_radius;
  edge_offset = edge_curvature_radius;

  corner_sphere_r = face_corner_radius - (corner_radius - edge_radius)/8;


  round_rect_offset_factor = 0.40 * face_corner_radius;
  display_round_rect_offset_factor = 0.45 * face_corner_radius;
  display_inset_depth = 0.8;

  length_edge_extr_height = length - 2*face_corner_radius;
  width_edge_extr_height  = width  - 2*face_corner_radius ;
  corner_sphere_chop_height = 5;


  // generate the basic solid outline
  {
    difference() {

      // most of body
      hull($fn = 25)
      // DEBUG
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
	    sphere(r = corner_sphere_r, $fn = 50);
	    cube(size = [20, 20, corner_sphere_chop_height], center = true);
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
	    sphere(r = corner_sphere_r, $fn = 50);
	    cube(size = [20, 20, corner_sphere_chop_height], center = true);
	  }
	}

	// upper right corner
	translate([width - face_corner_radius, length - face_corner_radius, depth/2])
	{
	  intersection() {
	    sphere(r = corner_sphere_r, $fn = 50);
	    cube(size = [20, 20, corner_sphere_chop_height], center = true);
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
	    sphere(r = corner_sphere_r, $fn = 50);
	    cube(size = [20, 20, corner_sphere_chop_height], center = true);
	  }
	}


      }

    }
    // display main rectangular region
    translate([display_round_rect_offset_factor,
	       display_round_rect_offset_factor,
	       depth - display_inset_depth])
    {
      color ("Black", alpha = 0.92)
	linear_extrude(height = display_inset_depth + e, center = false, convexity = 10)
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



echo ("corner_radius: ", iphone_11_pro__face_corner_radius);
echo ("edge_radius: ", iphone_11_pro__edge_radius);


iphone_11_pro(iphone_11_pro__width, iphone_11_pro__height, iphone_11_pro__depth, iphone_11_pro__face_corner_radius, iphone_11_pro__edge_radius);
