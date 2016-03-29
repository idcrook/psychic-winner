
// based on http://www.thingiverse.com/thing:1194084

module TigerOrnament (cut_height, skyward) {

  gridSize = 150;

  if (skyward) {

    intersection() {
      translate([0,0,0])
        rotate([90, 0, 0])
        import ("files/LSU_Tiger_ornament___Magnet/FullTigerOrnament.STL");
      translate([0, -gridSize, cut_height])
        cube(gridSize);
    }
  } else {
    difference() {
      translate([0,0,0])
        rotate([90, 0, 0])
        import ("files/LSU_Tiger_ornament___Magnet/FullTigerOrnament.STL");
      translate([0, -gridSize, cut_height])
        cube(gridSize);
    }
  }    
    
}


translate([-50, 50, 0]) {
  // top layer
  //TigerOrnament(2.545, true);
  
  // bottom layer
  TigerOrnament(2.54, false);
}
