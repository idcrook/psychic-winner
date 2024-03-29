
//set this to how thick you want the tag
bone_height = 3.4;

pet_name="FIDO";
phone_number="123-555-1212";
font_face="San Franscisco:style=Bold";
font_size_name = 14;
font_size_number = 8.5;
font_thickness=3.15;

// place name 
name_h_offset = 4;
name_v_offset = 1.5;

// place number
number_h_offset = -2;
number_v_offset = 13.0;

delta = 1/128;

tag_attachment_outer_diameter = 9;
tag_attachment_inner_diameter = 3.4;
tag_attachment_width = (tag_attachment_outer_diameter - tag_attachment_inner_diameter);
tag_attachment_height = bone_height*95/100;
tag_attachment_flare_width = 8;

module __Customizer_Limit__ () {}

$fa=1;
$fs=1;

module t(t, font_size, align_scale, character_spacing){
 translate([-1,(-len(t)*align_scale),bone_height - delta])
   rotate([0, 0, 90])
    linear_extrude(height = font_thickness)
      text(t, font_size, font = str(font_face), spacing = character_spacing, $fn = 20);
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

// TEXT
translate([name_v_offset,   name_h_offset,  0])      t(pet_name,     font_size_name,   9.0, 1.3);
translate([number_v_offset, number_h_offset, -0.2]) t(phone_number, font_size_number, 3.9, 1.1);

//tag attachment
difference(){
    union() {
        translate([-16,0,0]) {

            cylinder(r=tag_attachment_outer_diameter, h=tag_attachment_height);

            // add flares at attachment point for more area
            translate([-3,tag_attachment_outer_diameter/2 + tag_attachment_width/2 ,0])
            {
                rotate([0,0,-45]) {
                    cube([tag_attachment_flare_width , tag_attachment_flare_width ,tag_attachment_height]);
                }
                rotate([0,0, -30 ]) {
                    cube([tag_attachment_flare_width , tag_attachment_flare_width + 1.5 ,tag_attachment_height * 4/3]);
                }

            };
           translate([-3,-(tag_attachment_outer_diameter/2 + tag_attachment_width/2) ,0])
            {
                rotate([0,0,-45]) {
                    cube([tag_attachment_flare_width , tag_attachment_flare_width ,tag_attachment_height]);
                }
                rotate([0,0,-60]) {
                    cube([tag_attachment_flare_width + 1.5 , tag_attachment_flare_width ,tag_attachment_height * 4/3]);
                }

            };
        }
    }
    //prevents non-manifold
    translate([-16,0,-1]) cylinder(r=tag_attachment_inner_diameter, h=((bone_height*2/3)+2));
}


translate([-16,0,0]) {

  // add flares at attachment point for more area
  translate([-3,tag_attachment_outer_diameter/2 + tag_attachment_width/2 ,0])
  {
    rotate([0,0,-45]) {
      cube([tag_attachment_flare_width , tag_attachment_flare_width ,tag_attachment_height]);
    }
  };
  translate([-3,-(tag_attachment_outer_diameter/2 + tag_attachment_width/2) ,0])
  {
    rotate([0,0,-45]) {
      cube([tag_attachment_flare_width , tag_attachment_flare_width ,tag_attachment_height]);
    }
  };
}


}
