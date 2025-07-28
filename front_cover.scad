include <nutsnbolts/cyl_head_bolt.scad>
include <lib.scad>

$fn=50;

esc_switch_cutouts = true;
ventilation = true;

module latch_point(inner_diameter){
  difference(){
    union(){
        cylinder(h=12, r=outer_cylinder/2);
        translate([outer_cylinder/-2,0,0])
        cube([outer_cylinder, 20, 12]);
    }
    cylinder(h=width, r=inner_diameter/2);
  }
}

difference(){
  union(){
      main_rod();

      translate([68,0,12])
      latch_point(12);

      translate([68,0,width-24])
      latch_point(12);

/*
// baseline for getting the cutout right
translate([0, outer_cylinder/2-thickness, 0])
cube([70, thickness, 15]);
*/

      // first hull segment (angled)
      translate([0, outer_cylinder/2-thickness, 0])
      rotate([0,0,30])
        cube([28, thickness, width]);

      // second hull segment
      translate([22, 20, 0])
      cube([50, thickness, width]);

      // third hull segment, angled downwards
      translate([72, 20, 0]){
        translate([1,2,0])
          cylinder(r=3, h=width);
        rotate([0,0,315])
          difference(){
          cube([50, thickness, width]);
          if (esc_switch_cutouts == true){
            // cutouts for the switches
            translate([15,40,40])
              rotate([90,0,0])
              switch_cutout(depth=140);
            translate([15,40,width-40-10])
              rotate([90,0,0])
              switch_cutout(depth=140);
          }
            // wedge cutout for hull interlock
          translate([40,0,0])
            linear_extrude(width)
            polygon([[0,0], [10,0], [10, thickness]], paths=[[0,1,2]]);
        }
      }

      // supports at the front, reaching to the inner frame
      translate([79.5,frame_pos,0])
      rotate([0,270,0])
      frame_support(outer_cylinder);

      translate([79.5-outer_cylinder,frame_pos,width])
      rotate([0,90,0])
      frame_support(outer_cylinder);
  }
  if (ventilation == true){
    for (i=[0:5]){
      translate([26+i*5.5, 40, 8]){
        rotate([90,270,0])
          vent(40, 4, 100);
        translate([0,0,width-8*2]){
          rotate([90,90,0])
            vent(40, 4, 100);
        }
      }
    }
  }
}
