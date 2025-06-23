

show_assembly = true;

e = 1/64;

module single_look() {
  difference () {
    //translate([0,0,0]) import("my-raspberry-pi-rack-1u-frame-w67p0-bolt2p4-f0p25.stl");
    translate([0,0,0]) import("raspberry-pi-rack-1u-frame-10inch.stl");
    //translate([0,0,0]) import("raspberry-pi-rack-1u-frame.stl");
    //translate([0,0,0]) import("my-raspberry-pi-rack-1u-frame-bolt2p4-f0p25.stl");
  }
}



frame_stl = "my-raspberry-pi-rack-1u-frame-w67p0-bolt2p4-f0p25.stl";
tray_stl = "raspberry-pi-rack-tray.stl";
ears_stl = "raspberry-pi-rack-1u-ears.stl";

frame_width = 67.0;
fudge = 0.2;

tray_length = 85.0;
tray_lip_overhang = 10;

tray_x_inset = 4.5;
tray_z_inset = 3.0;

module single_frame_with_tray() {
  union () {
    translate([0, 0, 0])
      import(frame_stl);
    // position rotated tray
    translate([1*frame_width, tray_length, 0]) rotate ([0, 0, 180])
      // inset tray
      translate([tray_x_inset, 0, tray_z_inset]) color("red") import(tray_stl);
  }
}

module left_ear () {

  translate([0, 0, -10]) rotate([0, -90, 0])
  intersection () {
    // bounding box for left ear
    translate([-e, -5-e, -e]) cube([10 + 45, 5 + 90 + 16, 5 + 16 + 5 + e]);
    import(ears_stl);
  }

}

module right_ear () {

  translate([0, 0, -10]) rotate([0, 90, 0])
  difference () {
    import(ears_stl);
    // bounding box for left ear
    translate([-e, -5-e, -e]) cube([10 + 45, 5 + 90 + 16, 5 + 16 + 5 + e]);
  }

}


module assembly() {

  translate([-1*fudge, -6, -9]) color("grey") left_ear();
  translate([0*frame_width, 0, 0]) single_frame_with_tray();
  translate([1*frame_width + 1*fudge, 0, 0]) single_frame_with_tray();
  translate([2*frame_width + 3*fudge, 0, 0]) single_frame_with_tray();
  translate([3*frame_width + 5*fudge, -6, -9]) color("grey") right_ear();

}

if (show_assembly) {
  assembly();
} else {
  //single_look();
  //single_frame_with_tray();
  //left_ear();
  right_ear();
}
