$fa=1;
$fs=1;
bone_height = 4;//set this to how thick you want the tag
pet_name="KOKONUT";
phone_number="970 5551212";
font_face="Consolas";
font_thickness=4;


module t(t){
 translate([-1,(-len(t)*3.8),bone_height])
   rotate([0, 0, 90])
    linear_extrude(height = font_thickness)
      text(t, 10, font = str(font_face), $fn = 16);
}
//bone
//left side of bone

scale([1,1,1]*0.75) {
translate([-12,-40,0])
{
    translate([24,0,0]) cylinder(h=bone_height, r=14);
    cylinder(h=bone_height, r=14);
};
//right side of bone
translate([-12,40,0])
{
    translate([24,0,0]) cylinder(h=bone_height, r=14);
    cylinder(h=bone_height, r=14);
};
//center of bone
translate([-15,-49,0]) cube([30,90,bone_height]);
t(pet_name);
translate([12,0,0]) t(phone_number);
//tag attachment
difference(){
    translate([-16,0,0]) cylinder(r=8, h=bone_height*2/3);
    //prevents non-manifold
    translate([-16,0,-1]) cylinder(r=4, h=((bone_height*2/3)+2));
}
}
