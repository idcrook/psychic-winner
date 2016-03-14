
//
// inspired by 
//   http://www.thingiverse.com/thing:1353400  - Lulzbot Mini filament spool bushing
//   by ggrieves is licensed under the Creative Commons - Attribution license.

// Email: dpcrook@users.noreply.github.com


// resized dimensions to fit spools with a inner diameter of ~38mm

spool_inner_r=37.5/2;
length=90;

holder_w = 10;
holder_h = holder_w;

cut_offset = (1/8)*spool_inner_r;

// small number
e=.02;


rotate(a=[0,90,0]) 
difference(){
    cylinder(length, spool_inner_r, spool_inner_r, $fn=360);
    // chop off over half of circle, making semi-circle cylinder
    translate ([-cut_offset, -(spool_inner_r+e),-e]) cube([2*(spool_inner_r+e), 2*(spool_inner_r+e), length+2*e]);
    // cut out notch to sit on spool holder arm
    translate ([-(cut_offset + holder_h), -holder_w/2, -e]) cube([holder_w+e, holder_h, length+2*e]);
};


