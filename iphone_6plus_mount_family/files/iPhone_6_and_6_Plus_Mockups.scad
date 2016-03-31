/*

iPhone 6 and 6 Plus Mockups

modeled by Mark Boszko
stationinthemetro.com
twitter.com/bobtiki

Built with variables, so dimensions can be easily adjusted.

http://www.thingiverse.com/thing:458102/
*/

/*
// iPhone 6
// working version from Mac Fan (Japanese Magazine) May 2014 leaked schematics
// iphone(66,137,7,9);
// adjusted to Apple specs: http://www.apple.com/iphone-6/specs/
iphone(67,138.1,6.9,9);

ear_speaker_width = 9.5;
ear_speaker_center_from_top = 9;
button_width = 2.3;
ringer_switch_height = 5.7;
ringer_switch_from_top = 17;
volume_height = 8.7;
volume_plus_from_top = 31;
volume_minus_from_top = 42;
sleep_wake_height = 10;
sleep_wake_from_top = 31;
home_button_diameter = 10.6;
home_button_center_from_bottom = 9;
home_button_depth = 0.5;
lightning_width = 8.3;
*/

// iPhone 6 Plus
// working version from Mac Fan (Japanese Magazine) May 2014 leaked schematics
//iphone(77,157,6.7,9.5);
// adjusted to Apple specs: http://www.apple.com/iphone-6/specs/
iphone(77.8, 158.1, 7.1, 9.5);

ear_speaker_width = 9.5;
ear_speaker_center_from_top = 9.5;
button_width = 2.3;
ringer_switch_height = 5.7;
ringer_switch_from_top = 18.4;
volume_height = 10;
volume_plus_from_top = 31;
volume_minus_from_top = 43.8;
sleep_wake_height = 10;
sleep_wake_from_top = 31;
home_button_diameter = 10.6;
home_button_center_from_bottom = 9.4;
home_button_depth = 0.5;
lightning_width = 8.3;




/*

iPhone module

all measurements in mm

width = width of the face of the phone
length = length of the face of the phone
height = thickness of the phone
radius = the radius of the four major corners

We are assuming, on an iPhone 6, that the curved edge of the phone is a
full semicircle with a diameter equal to the thickness of the phone.

*/

// 10 - very rough
// 25 - pretty good and still fast
// 100 - final output 
curve_quality = 25;
//curve_quality = 100;

module iphone(width,length,height,radius)
{
	difference()
	{
		union()
		{
			shell(width,length,height,radius);
			// Ringer Switch
			translate([-0.25, length - ringer_switch_from_top - ringer_switch_height, (height / 2 - button_width / 4 - button_width / 8)]) rotate([90, 0, 90]) capsule(ringer_switch_height, button_width / 2, 1);
			// Volume +
			translate([-0.25, length - volume_plus_from_top - volume_height, (height / 2 - button_width / 2)]) rotate([90, 0, 90]) capsule(volume_height, button_width, 1);
			// Volume -
			translate([-0.25, length - volume_minus_from_top - volume_height, (height / 2 - button_width / 2)]) rotate([90, 0, 90]) capsule(volume_height, button_width, 1);
			// Sleep/Wake
			translate([width - 0.75, length - sleep_wake_from_top - sleep_wake_height, (height / 2 - button_width / 2)]) rotate([90, 0, 90]) capsule(sleep_wake_height, button_width, 1);
		}
		union()
		{
			// Ear Speaker
			translate([width / 2 - ear_speaker_width / 2, length - ear_speaker_center_from_top + 0.5, height - 2]) capsule(ear_speaker_width, 1, 2);
			// Ringer Switch divot
			translate([0, length - ringer_switch_from_top - ringer_switch_height, (height / 2 + button_width / 4 - button_width / 8)]) rotate([90, 0, 90]) capsule(ringer_switch_height, button_width / 2, 1);
			translate([0, length - ringer_switch_from_top - ringer_switch_height, height / 2]) rotate([90, 0, 90]) cube([ringer_switch_height, button_width / 2, 1]);
			// Home Button
			translate([width / 2, home_button_center_from_bottom, height - home_button_depth]) cylinder(h = home_button_depth, d1 = home_button_diameter * 0.9, d2 = home_button_diameter);
			// Screen
			// Bottom Edge
			translate([height / 2, home_button_diameter * 1.5, height - 0.25]) cube([width - height, 0.25, 0.25]);
			// Top Edge
			translate([height / 2, length - 0.25 - home_button_diameter * 1.5, height - 0.25]) cube([width - height, 0.25, 0.25]);
			// Lightning Jack
			translate([width / 2 - lightning_width / 2, 5, height / 2 - button_width / 2]) rotate([90, 0, 0]) capsule(lightning_width, button_width, 5);
			// Headphone Jack
			translate([width / 5, 0, height / 2]) rotate([270, 0, 0]) cylinder(h = 17, d = 4);
		}
	}
}

module corner_disc(height, radius)
{
	union()
	{
		rotate_extrude(convexity = 10, $fn = curve_quality)
		translate([(radius - height / 2), height / 2, 0])
		circle(r = height/2, $fn = curve_quality);
		cylinder(h = height, r = radius - height / 2);
	}
}

module short_edge(width, height, radius)
{
	translate([0, height / 2, height / 2]) rotate([0,90,0]) cylinder(h = (width - radius * 2), r = height / 2, $fn = curve_quality);
}

module long_edge(length, height, radius)
{
	translate([height/2, 0, height / 2]) rotate([270,0,0]) cylinder(h = (length - radius * 2), r = height / 2, $fn = curve_quality);
}

module shell(width,length,height,radius)
{
	union()
	{
		// The four corner radii
		translate([radius, radius,0]) corner_disc(height, radius);
		translate([width - radius, radius,0]) corner_disc(height, radius);
		translate([radius, length - radius,0]) corner_disc(height, radius);
		translate([width - radius, length - radius,0]) corner_disc(height, radius);
		// body center
		translate([radius, height / 2, 0]) cube([width - radius * 2, length - height, height]);
		translate([radius, 0, 0]) short_edge(width, height, radius);
		translate([radius, length - height, 0]) short_edge(width, height, radius);
		// body sides
		// left
		translate([height / 2, radius, 0]) cube([radius * 2 - height, length - radius * 2, height]);
		translate([0, radius, 0]) long_edge(length, height, radius);
		// right
		translate([width - radius - height, radius, 0]) cube([radius * 2 - height, length - radius * 2, height]);
		translate([width - height, radius, 0]) long_edge(length, height, radius);
	}
}

module capsule(width, height, depth)
{
	union()
	{
		// hole
		translate([height / 2, 0, 0]) cube([width - height, height, depth]);
		translate([height / 2, height / 2, 0]) cylinder(h = depth, r = height/2, $fn = curve_quality);
		translate([width - height / 2, height / 2, 0]) cylinder(h = depth, r = height/2, $fn = curve_quality);
	}
}
