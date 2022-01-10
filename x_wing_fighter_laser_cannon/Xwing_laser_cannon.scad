////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   23-Mar-2016 
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
//  http://www.thingiverse.com/thing:909499
//
// Description:
//
//  I enjoyed the design of the xwing fighter model mentioned above, but found
//  a part of the print would be fragile or outright fail: the four laser
//  cannons (http://starwars.wikia.com/wiki/KX9_laser_cannon). This design is
//  a print-friendly version of a cannon which resembles the original.
//
// Revisions/Notes:
//
//   v1:
//   - used .STL imported into OpenSCAD to base dimensions on
//
////////////////////////////////////////////////////////////////////////



h_c = 5;
y_c = 10;

difference () {
    rotate([0,90,0])
    xwing_shooter () ;
    
    // cut to make flat for simpler print
    translate([0,-y_c/2, -(h_c+ 1.1)])
    cube([70, y_c, h_c]);
}


module xwing_shooter () {

    zstart1 = 11;
    h1 = 22;
    h1t = 0.5;
    rad1 = 1.4;
    rad2 = 1.1;
    h2 = 18.5;
    
    // small number
    e=1/128;
    
    // import("files/xwing_sliced.stl");
    
    // main shaft
    translate([0, 0, zstart1]) {
        cylinder($fn = 40, $fa = 12, $fs = 2, h = h1, r1 = rad1, r2 = rad1, center = false);
        translate([0, 0, h1])
            cylinder($fn = 40, $fa = 12, $fs = 2, h = h1t, r1 = rad1, r2 = rad2, center = false);
         translate([0, 0, h1 + h1t])
            cylinder($fn = 40, $fa = 12, $fs = 2, h = h2, r1 = rad2, r2 = rad2, center = false); 
    }
    
    
    // gun port
    zstart2 = zstart1 + h1 + h1t + h2;  
    
    gun_bat_r = 2.5;
    gun_bat_r_addz = 0.5;
    cup_outer_r = 3.3; 
    cup_inner_r = cup_outer_r - 1; 
    cup_width = 3;
    
    // start with batt and cup
    translate([0, 0, zstart2]) {
        difference() {
            translate([0, 0, gun_bat_r_addz])
              sphere($fn = 30, r = gun_bat_r);
            
            translate([-3, -3, -3])
              cube([10,10,3]);
        }
        
        translate([-(cup_width / 2), 0, 2* gun_bat_r])
        rotate([0, 90, 0])
        difference() {
            cylinder($fn = 40, $fa = 12, $fs = 2, h = cup_width, r1 = cup_outer_r, r2 = cup_outer_r, center = false);
            
            translate ([0, 0, -e])
            cylinder($fn = 40, $fa = 12, $fs = 2, h = cup_width + 2*e, r1 = cup_inner_r, r2 = cup_inner_r, center = false);
            translate ([-2*cup_outer_r, -cup_outer_r, -e ])
            cube([2*cup_outer_r,2*cup_outer_r, cup_width + 2*e]);
        }
     }
     
    zstart3 = zstart2 + gun_bat_r + gun_bat_r_addz;
     
    shooty_r = 0.8;
    shooty_h = 9; 
    shooty_tangent_offset = -0.5;
    inward_offset = 0.5;
     
    // shooty part
    translate([inward_offset, 0, zstart3]) {
        translate([0,0, shooty_tangent_offset])
        cylinder($fn = 40, $fa = 12, $fs = 2, h = shooty_h, r1 = shooty_r, r2 = shooty_r, center = false);
    }
    
    zstart4 = zstart3 + shooty_h + shooty_tangent_offset;
    translate([inward_offset, 0, zstart4]) {
        translate([0, 0, 0])
              sphere($fn = 18, r = shooty_r);
    }
    
}



 
 
 
