///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2026-Jun-29
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//
//
// Revisions/Notes:
//
//   2023-Oct-14: Initial dimensions
//   2026-Jun-29: Updating for more battery pack styles
//
//
///////////////////////////////////////////////////////////////////////////////

// use_fillets = 1;

use <MCAD/2Dshapes.scad>
include <MCAD/units.scad>
include <../libraries/local-misc/fillet.scad>

e = 1/128; // small number

// determines whether model is instantiated by this file;
// set to false for using as an include file
DEVELOPING_powerbank_dummy = false;

// Originally created for the (now missing ASIN)
// [Amazon.com: LOVELEDI Portable-Charger-Power-Bank - 2 Pack 15000mAh Dual USB Power Bank Output 5V3.1A Fast Charging Portable Charger Compatible with Smartphones and All USB Devices ](https://www.amazon.com/gp/product/B0B45GX5V7?ie=UTF8&th=1)
// - Capacity: 15000mAh
// - Size:  5.5 * 2.5 * 0.5 in

// Monoprice 10 kmAh -> "powerbank__height": "106", "powerbank__thickness": "17", "powerbank__width": "69.0",
// Monoprice 20 kmAh -> "powerbank__height": "109", "powerbank__thickness": "29.5", "powerbank__width": "70.0",


powerbank__thickness = 29.3;
powerbank__width =  67.6;
powerbank__height = 139.70;

button__center_from_top = 15.0;
button__height = 11.0;
button__thickness = 7.0;
button__extension = 0.1;

// Has LED indicators
led__has_leds = true;
led__midline_from_top = 15.0;
led__span = 11.0;
led__number_of = 4;
led__extension = 0.1;
led__radius = 0.5;

// Has an LCD or LCD display
lcd__has_lcd = false;
lcd__midline_from_top = 16.0;
lcd__height = 20.1;
lcd__width = 20.1;


face_corner_radius = 12.5;
side_corner_radius1 = 5.0;

/// creates for() range to give desired no of steps to cover range
function steps( start, no_steps, end) = [start:(end-start)/(no_steps-1):end];


module button (height = button__height,
               width = button__thickness,
               thickness = button__extension) {

    linear_extrude(height = thickness, center = false) {
      square(size = [width, height] , center = true);
    }
}



module powerbank_dummy(width = powerbank__width,
                       height = powerbank__height,
                       thickness = powerbank__thickness) {

  gross_size = [width, thickness, height];

  r = side_corner_radius1;
  face_r = face_corner_radius;

  vertical=[r,r,r,r];
  top=[face_r,face_r,face_r,face_r];
  bottom=[face_r,face_r,face_r,face_r];

  // TODO: Add ports/connectors locations?

  cube_fillet(size = gross_size,
    vertical=vertical, top=top, bottom=bottom,
    center = false, $fn = 30);

  // BUTTON
  btn_x = 0.0;
  btn_y = (1/2) * powerbank__thickness;
  btn_z = powerbank__height - button__center_from_top;

  translate([btn_x, btn_y, btn_z])
    rotate ([0,-90,0])
    color("LimeGreen")
    linear_extrude(height = button__extension, center=true)
    square([button__height, button__thickness], center = true);

  // LEDs
  led_x = (1/2) * powerbank__width - (1/2) * led__span;
  led_y = 0.0;
  led_z = powerbank__height - led__midline_from_top;

  if (led__has_leds) {
    color("Blue")
      translate([led_x, led_y, led_z])
      rotate([90, 0, 0])
      {
        for (i=steps(0.0, led__number_of, led__span)) {
          translate([i, 0, 0])
            linear_extrude(height = led__extension)
            square(led__radius);
        }
      }
  }

  // LED/LCD display
  lcd_x = (1/2) * (powerbank__width - lcd__width);
  lcd_y = 0;
  lcd_z = powerbank__height - 2 * lcd__midline_from_top;

  if (lcd__has_lcd) {
    color("Blue")
      translate([lcd_x, lcd_y, lcd_z])
      rotate([90, 0, 0]) {
      linear_extrude(height = 0.1) {
        square([lcd__width, lcd__height]);
      }
    }
  }

}

// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

if (DEVELOPING_powerbank_dummy && false) {
  // sizing up mount size
}

if (DEVELOPING_powerbank_dummy) {
  powerbank_dummy();
}
