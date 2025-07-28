include <nutsnbolts/cyl_head_bolt.scad>
include <lib.scad>

$fn=50;

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
        translate([40,0,0])
          // wedge cutout for hull interlock
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
