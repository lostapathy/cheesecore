// vim: set nospell:
include <nopscadlib/core.scad>
use <nopscadlib/utils/layout.scad>
include <nopscadlib/printed/fan_guard.scad>
include <nopscadlib/vitamins/fans.scad>
difference(){
rounded_rectangle([40,40,7],5);
#translate ([0,0,-3.5]) fan_guard(fan40x11, name = false, thickness = 5, spokes = 4, finger_width = 2, grill = false);
}




