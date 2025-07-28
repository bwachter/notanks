inner_cylinder=6.3;
outer_cylinder=23;
nut_mount_width=14;
width=150;
thickness=5;
nut_offset=12;
// this should be the coordinate of the frame on the other tank parts
frame_pos=outer_cylinder/2-thickness;

module main_rod(){
  nut_clearance=1.2;
  nut_thickness=4.9;

  difference(){
    union(){
        difference(){
          cylinder(h=width, r=outer_cylinder/2);
          // wedge starts at 9, and continues until 35
          translate([10, -5, nut_mount_width])
            cylinder(h=width-nut_mount_width*2, r=outer_cylinder/2);

          translate([0,0,nut_offset+nut_clearance])
            nutcatch_sidecut("M6", clh=nut_clearance);
          translate([0,0,width-nut_offset+nut_clearance+nut_thickness])
            nutcatch_sidecut("M6", clh=nut_clearance);

          // this is a hack to get a somewhat niceish connection between the
          // inside of the cylinder and the first cube, and only works as long
          // as the angle of the first connecting hull piece doesn't change
          translate([0, outer_cylinder/2-thickness*2-4.5, nut_mount_width])
            rotate([0,0,45])
            cube([28, thickness, width-nut_mount_width*2]);
        }
        translate([0,0,nut_mount_width])
        cylinder(h=15, r1=outer_cylinder/2, r2=2);
        translate([0,0,width-nut_mount_width-15])
        cylinder(h=15, r1=2, r2=outer_cylinder/2);
    }
    cylinder(h=width, r=inner_cylinder/2);
    // led cutouts
    translate([-20,0,nut_offset+20])
      rotate([0,90,0])
      cylinder(r=2.5, h=50);

    translate([-20,0,width-nut_offset-20])
      rotate([0,90,0])
      cylinder(r=2.5, h=50);
  }
}

module switch_cutout(width=8, length=10, depth){
  cube([width, length, depth]);
}

module vent(height, width, depth){
  linear_extrude(depth){
    circle(r=width/2);
    translate([0, width/-2])
      square([height-width, width]);
    translate([height-width, 0])
      circle(r=width/2);
  }
}

module frame_support(width){
  linear_extrude(width)
    polygon([[0,0],[0,20-frame_pos],[50,20-frame_pos],[thickness,0]], paths=[[0,1,2,3]]);
}
