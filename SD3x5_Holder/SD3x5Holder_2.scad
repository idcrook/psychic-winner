
/* SD Card dim is 32x24x3 */
/* Biz Card dim is 51x89x0.5 */

sim_height = 32;
sim_width = 24;
text = "...";
font = "Arial:style=Bold";


letter_size = 6;
letter_height = 1.5;

module letter(l) {
  // Use linear_extrude() to make the letters 3D objects as they
  // are only 2D shapes when only using text()
  linear_extrude(height = letter_height) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
  }
}

union()
{
difference()
{
    cube([25.4*3, 25.4*5, 5], center=true);
    for(i=[0:sim_width+1:120])
    {    
        translate([19,i-(25.4*5/2)+13, 1]) cube([sim_height + 1, sim_width, 3], center=true);
        translate([-19,i-(25.4*5/2)+13, 1]) cube([sim_height + 1, sim_width, 3], center=true);
        translate([25,i-(25.4*5/2)+13, -1])  cylinder(d=20,h=5, center=true);
        translate([-13,i-(25.4*5/2)+13, -1]) cylinder(d=20,h=5, center=true);

    }
    
    
    //translate([19,4, 0]) cube([sim_height + 3, 24*5, 3], center=true);
    //translate([19,4,2]) cube([sim_height - 2, 24*5, 2], center=true);
    //translate([-19,4, 0]) cube([sim_height + 3, 24*5, 3], center=true);
    //translate([-19,4,2]) cube([sim_height - 2, 24*5, 2], center=true);
    
}
    for(i=[0:sim_width+1:120])
    {    
        translate([5,i-(25.4*5/2)+13, 3]) cube([sim_height/4, sim_width+1, 1], center=true);
        translate([-32,i-(25.4*5/2)+13, 3]) cube([sim_height/4 + 1, sim_width+1, 1], center=true);
    }
    
    rotate([0,0,-90]) translate([0,-32,2.5]) letter(text);
  
}