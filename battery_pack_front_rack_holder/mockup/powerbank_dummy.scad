///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2023-Oct-14
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
//
//
///////////////////////////////////////////////////////////////////////////////

// use_fillets = 1;

use <MCAD/2Dshapes.scad>
include <MCAD/units.scad>
include <../libraries/local-misc/fillet.scad>

e = 1/128; // small number

// determines whether model is instantiated by this file; set to false for
// using as an include file
DEVELOPING_powerbank_dummy = true;

// [Amazon.com: LOVELEDI Portable-Charger-Power-Bank - 2 Pack 15000mAh Dual USB Power Bank Output 5V3.1A Fast Charging Portable Charger Compatible with Smartphones and All USB Devices ](https://www.amazon.com/gp/product/B0B45GX5V7?ie=UTF8&th=1)

// - Capacity: 15000mAh
// - Input(Type-C): 5V/3A(max)
// - Input(Micro):  5V/2A
// - Output(USB-A1): 5V/3.1A
// - Output(USB-A2): 5V/3.1A
// - Size:  5.5 \* 2.5 \* 0.5 in
// - Weight: 203g / 7.1oz
// - Recharge Cycle: >800+times


powerbank__thickness = 17.0 * mm;
powerbank__length = 67.6 * mm;
powerbank__width = powerbank__length;
powerbank__height = 5.50 * inch;

// all measurements in millimeters
button__center_from_top = 15.0;
button__height = 11.0;
button__thickness = 7.0;
button__extension = 0.1;

usba_l__center_from_left = 10.0;

band_thickness = 8.0;
face_corner_radius = 12.5;
side_corner_radius1 = 5.0;


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

  // TODO: Add button, LEDs and ports/connectors locations

  cube_fillet(size = gross_size,
    vertical=vertical, top=top, bottom=bottom,
    center = false, $fn = 30);


}





// $preview requires version 2019.05
$fn = $preview ? 30 : 100;

if (DEVELOPING_powerbank_dummy && false) {
  // sizing up mount size
}

if (DEVELOPING_powerbank_dummy) {
  powerbank_dummy();
}
