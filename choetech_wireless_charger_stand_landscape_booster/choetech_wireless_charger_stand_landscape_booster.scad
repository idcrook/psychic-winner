////////////////////////////////////////////////////////////////////////
// Initial Revision:
//  2020-Nov-11
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
//   - Using iPhone in landscape while on a wireless charger stand
//
// Description:
//
//   A simple block sized to allow an Iphone 11 Pro (in case) to activate
//   wireless charging in landscape orientation in Choetech Fast Charge
//   Wireless Charger Stand.
//
//
// Revisions/Notes:
//
//  - Developed on OpenSCAD 2019.05, First Draft 2020-Nov-11
//
////////////////////////////////////////////////////////////////////////


include <../libraries/local-misc/fillet.scad>


e = 1/128; // small number


// Measurements
//

stand_width_at_base = 73.5;
stand_lip_depth_at_base = 13.0;
support_block_height = 34.0;


module charger_support_block() {

  bulk_block() ;
}

module bulk_block () {

    extra_depth = 5.0;  // stick out this much over lip
    width_reduction = 12.0; // inset this much from each side
    block_width  =  stand_width_at_base - (2*width_reduction);
    block_depth  =  stand_lip_depth_at_base + (extra_depth);
    block_height =  support_block_height;

    r = extra_depth / 2;

    //cube([block_width, block_depth, block_height]);

    // using fillets rounds corners and edges
    cube_fillet([block_width, block_depth, block_height],
                vertical = [1,1,1,1],
                top = [r, 0, r, 0],  bottom = [r, 0, r, 0], $fn = 24);

}


$fn = $preview ? 30 : 100;
charger_support_block();
