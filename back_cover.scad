include <nutsnbolts/cyl_head_bolt.scad>
include <lib.scad>
$fn=50;

difference(){
  union(){
      main_rod();

/*
// baseline for getting the cutout right
translate([0, frame_pos, 0])
cube([145, thickness, 2]);
*/

      // angled section; changing that currently is not really supported, due to
      // assumptions in main_rod. Eventually the height should be also calculated
      // for easy adjustments
      translate([0, frame_pos, 0])
      rotate([0,0,30])
      cube([28, thickness, width]);

      // long section
      translate([22, 20, 0])
      cube([120, thickness, width]);

      // supports at the front, reaching the inner rim
      translate([135,frame_pos,0])
      rotate([0,270,0])
      frame_support(10);

      translate([125,frame_pos,width])
      rotate([0,90,0])
      frame_support(10);
  }

  // wedge cutout for the hull interlock
  translate([132,25,0])
    linear_extrude(width)
    polygon([[0,0], [10,thickness*-1], [10, 0]], paths=[[0,1,2]]);
}
