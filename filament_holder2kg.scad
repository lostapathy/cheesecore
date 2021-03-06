//
//Yet Another Filament Spool Holder
//
//Designed for the Lasercut Mende90 but can be fitted on most printers with
//a flat surface to bolt it onto.
//
//tony@think3dprint3d.com
//
// GPL v3.0
//
//

//use <nopscadlib/utils/core/teardrops.scad> //nopscadlib library
use <nopscadlib/utils/core/global.scad> //nopscadlib library
use <demo.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
include <lib/layout.scad>
//variable defines, all in mm
//##overall spool dimensions##

max_spool_width=90;
min_spool_id=22; //624ZZ
spool_id_clearance=1; //minimum clearance between the spool holder and the inside of a spool

//##bearing variables##
bearing_od=0; //624ZZ bearing
bearing_id=8; //624ZZ bearing
bearing_thickness=7;
bearing_washer_thickness=0.5; //M4 washer
bearing_washer_radius=9/2; //M4 washer
bearing_clearance=0; //clearance between the bearings and the spool holder
//a set of two bearings with a washer at each end as a spacer
bearing_stack_thickness=(2*bearing_thickness)+(2*bearing_washer_thickness);
bearing_stack_wall_thickness=2;
//the bolt to hold the stack and plastic walls together
bearing_stack_bolt_length=bearing_stack_thickness+bearing_stack_wall_thickness*2+10;
echo("bearing_stack_bolt_length: ", bearing_stack_bolt_length);

//##filament holder variables##
min_filament_holder_id = bearing_od+bearing_clearance;
max_filament_holder_od = min_spool_id-spool_id_clearance;
filament_holder_wall_thickness= max_filament_holder_od-min_filament_holder_id;
echo("filament_holder_wall_thickness: ", filament_holder_wall_thickness);
filament_holder_length=max_spool_width+bearing_stack_bolt_length;
echo("filament_holder_length: ", filament_holder_length);

//##mounting plate##
fastener_clearance_radius=3.3/2;
fastener_washer_clearance_radius=8/2;
mounting_plate_thickness=8;
mounting_plate_width=min_spool_id+fastener_washer_clearance_radius;
mounting_plate_height=min_spool_id+fastener_washer_clearance_radius*3;


//##miscellaneous##
fn_resolution=100; //quality vs render time
print_clearance=0.1; //additional clearance between two printed objects

//The "peg" like tube the filament reel will sit on
module main_tube(max_spool_width){

    difference(){
      rotate([0,180,180])//truncated part facing down
        //use a teardrop to make it printable without support.
        teardrop(filament_holder_length, max_filament_holder_od/2,true,true);

      //cut out for bearings
      translate([0,(max_filament_holder_od-min_filament_holder_id),0])
        cube([min_spool_id+5,
              min_filament_holder_id/2,
              filament_holder_length-bearing_stack_wall_thickness*2],center=true);
      translate([0,(max_filament_holder_od-min_filament_holder_id)/2,0])
        cylinder(h=filament_holder_length-bearing_stack_wall_thickness*2,
                 r=min_filament_holder_id/2, $fn=fn_resolution,center=true);
      translate([0,(max_filament_holder_od-min_filament_holder_id/2)/2,0])
        cube([min_filament_holder_id, min_filament_holder_id/2,filament_holder_length-bearing_stack_wall_thickness*2],center=true);

  }
   rotate([0,180,180]) translate ([0,-2,filament_holder_length/2]) teardrop(5, max_filament_holder_od/2+2,true,true);
}

//The plate that holds the main tube to the side of the printer
module mounting_plate(max_spool_width){
     $fn=fn_resolution;//smooth rounded rectangle
		rotate([90,180,180]) rotate ([270,180,0]) difference(){
				hull(){
					translate([0,(mounting_plate_width-max_filament_holder_od)/2,-(filament_holder_length+mounting_plate_thickness)/2 ])
						rotate([1,0,0])//1 degree to compensate for the distortion due to heavy reels
						rounded_rectangle([mounting_plate_height,mounting_plate_width,mounting_plate_thickness-3],2,true);
					translate([0,0,-(filament_holder_length)/2 +bearing_stack_wall_thickness/2+0.5])
						cylinder(h=1, r=max_filament_holder_od/2, $fn=fn_resolution,center=true);
					}

				//bolt holes
				for(i=[-1,1])
					for(j=[-1,1])
						translate([j*mounting_plate_height/2 - j*fastener_washer_clearance_radius,
										i*mounting_plate_width/2 -i*fastener_washer_clearance_radius
														+ (mounting_plate_width-max_filament_holder_od)/2,
										-(filament_holder_length+mounting_plate_thickness)/2])
						{
							teardrop(100, fastener_clearance_radius,true,true);
							translate([0,0,(mounting_plate_thickness-2)/2+20])
								teardrop(40, fastener_washer_clearance_radius,true,true);
						}
		}
}
/*
module bolt_holes(){
  rotate([180,0,180]) translate ([0,0,(filament_holder_length+mounting_plate_thickness)/2])
  for(i=[-1,1])
    for(j=[-1,1])
      translate([j*mounting_plate_height/2 - j*fastener_washer_clearance_radius,
              i*mounting_plate_width/2 -i*fastener_washer_clearance_radius
                      + (mounting_plate_width-max_filament_holder_od)/2,
              -(filament_holder_length+mounting_plate_thickness)/2])
      {
        cylinder(h = 100, r = fastener_clearance_radius, center = true);
        *translate([0,0,(mounting_plate_thickness-2)/2+20])
          cylinder(40, fastener_washer_clearance_radius,true,true);
      }
}
*/

//each bearing stack has two printed ends
module bearing_end(edge=true){
	difference(){
		if(edge) //the bearing end sticks up to prevent the filament roll from coming off
			hull(){
			cylinder(h=bearing_stack_wall_thickness, r=min_filament_holder_id/2-print_clearance/2, $fn=fn_resolution,center=true);
			translate([6,0,0])
				cube([6,6,bearing_stack_wall_thickness],center=true);
			}
		else
			cylinder(h=bearing_stack_wall_thickness, r=min_filament_holder_id/2-print_clearance/2, $fn=fn_resolution,center=true);
			translate([bearing_clearance,0,0])
				cylinder(h=bearing_stack_bolt_length+10,r=bearing_id/2+0.15,$fn=fn_resolution,center=true);
	}
}


module spool_holder_stl(){

	translate([0,0,max_filament_holder_od/2]){
		main_tube();
		rotate([90,0,0])
			translate([0,0,-0.01]) //prevent intersecting faces
			mounting_plate();
	}

	for(i=[-1,1])
		translate([i*(max_filament_holder_od+min_filament_holder_id)/2,0,bearing_stack_wall_thickness/2]){
			bearing_end(false);
			translate([0,min_filament_holder_id+2,0])
				rotate([0,0,90])
					bearing_end(true);
		}
}


module bearing_stack_assembly();
//the printed bearing ends, washers and two bearings
module bearing_stack_assembly(){
  bearing_end(false);
    translate([0,0,bearing_stack_wall_thickness+
              bearing_washer_thickness*2+bearing_thickness*2])
  bearing_end(true);
  //Bearings and washers
  %translate([bearing_clearance,0,bearing_stack_wall_thickness/2+
             bearing_washer_thickness+bearing_thickness])
    difference(){
        union(){
          for(i=[-1,1])
            translate([0,0,i*bearing_thickness+i*bearing_washer_thickness/2])
              cylinder(h=bearing_washer_thickness,
                       r=bearing_washer_radius,
                       $fn=fn_resolution,center=true);
              cylinder(h=bearing_thickness*2,
                       r=bearing_od/2,
                       $fn=fn_resolution,center=true);
         }
         cylinder(h=bearing_stack_thickness+5,
                  r=bearing_id/2,
                  $fn=fn_resolution,center=true);
  }
}

module spool_holder_assembly2kg(max_spool_width){
    translate ([0,0,-(filament_holder_length+mounting_plate_thickness)/2]) color("DarkRed") {
  main_tube(max_spool_width);
	mounting_plate(max_spool_width);
	}
}

demo(){
//bolt_holes();
  spool_holder_assembly();
  //rotate ([90,0,0]) translate ([0,00,0]) spool2kg();
  //translate ([300,0,0]) spool1kg();
	//spool_holder_assembly();
	//spool_holder_stl();

}

module cheese_spool_assembly(){
  //spool();
  //mirror_y()


  *mirror_y() translate([-frame_size().x / 2 - side_panel_thickness() - 80, 110, 110])
      {
        spool_holder_assembly();
        *rotate ([90,0,0]) translate ([0,-10,0]) spool1kg();
      }

  *translate([-frame_size().x / 2 - side_panel_thickness() - 80, 0, -30])
      rotate ([0,0,270]) {
        spool_holder_assembly();
        rotate ([90,0,0]) translate ([0,-10,15]) spool2kg();
}
}

//
// Mendel90
//
// GNU GPL v2
// nop.head@gmail.com
// hydraraptor.blogspot.com
//
// For making horizontal holes that don't need support material
// Small holes can get away without it but they print better with truncated teardrops
//
module teardrop_2D(r, truncate = true) {
    difference() {
        union() {
            circle(r = r, $fn=100);
            translate([0,r / sqrt(2),0])
                rotate([0,0,45])
                    square([r, r], center = true);
        }
        if(truncate)
            translate([0, r * 2, 0])
                square([2 * r, 2 * r], center = true);
    }
}

module teardrop(h, r, center, truncate = true)
    linear_extrude(height = h, convexity = 2, center = center)
        teardrop_2D(r, truncate);

module teardrop_plus(h, r, center, truncate = true)
    teardrop(h, r + layer_height / 4, center, truncate);


module tearslot(h, r, w, center)
    linear_extrude(height = h, convexity = 6, center = center)
        hull() {
            translate([-w/2,0,0]) teardrop_2D(r, true);
            translate([ w/2,0,0]) teardrop_2D(r, true);
        }

module vertical_tearslot(h, r, l, center = true)
    linear_extrude(height = h, convexity = 6, center = center)
        hull() {
            translate([0, l / 2]) teardrop_2D(r, true);
            translate([0, -l / 2, 0])
                circle(r = r, center = true);
        }
