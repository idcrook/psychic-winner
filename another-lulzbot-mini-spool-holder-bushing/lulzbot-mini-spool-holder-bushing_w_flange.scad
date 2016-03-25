
//
// inspired by 
//   http://www.thingiverse.com/thing:1353400  - Lulzbot Mini filament spool bushing
//   by ggrieves is licensed under the Creative Commons - Attribution license.

// Email: dpcrook@users.noreply.github.com

// resized dimensions to fit spools with a inner diameter of ~38mm

spool_inner_r=37.5/2;
length=90+5;

holder_w = 10;
holder_h = holder_w;

cut_offset = (1/8)*spool_inner_r;

flange_largest_r = spool_inner_r + 7.5;
flange_width = 5;

// small number
e=.02;

cut_plane_r = spool_inner_r + flange_largest_r + (flange_largest_r - spool_inner_r);

//rotate(a=[0,90,0]) 
difference(){
    union() {
        cylinder(length, r1 = spool_inner_r, r2 = spool_inner_r, $fn=360);
        // add a flange
        cylinder(flange_width, r1 = flange_largest_r, r2 = spool_inner_r, $fn=360);
    }
    // chop off over half of circle, making semi-circle cylinder
    translate ([-cut_offset, -(cut_plane_r)/2 - e, -e]) cube([cut_plane_r+2*e,  cut_plane_r+2*e, length+2*e]);

    // cut out notch to sit on spool holder arm
    translate ([-(cut_offset + holder_h), -holder_w/2, -e]) cube([holder_h+e, holder_w, length+2*e]);
};


