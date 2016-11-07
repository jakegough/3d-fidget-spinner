use <hex_nut_captive_hole.scad>;
include <hex_nut_captive_hole.settings.scad>;

hex_nut_captive_hole_test();

module hex_nut_captive_hole_test()    
{
    hex_nut_captive_hole("1/4");

    translate([0, hex_nut_diameter("5/16"), 0])
    hex_nut_captive_hole("5/16");

    translate([0, hex_nut_diameter("5/16"), 0])
    translate([0, hex_nut_diameter("3/8"), 0])
    hex_nut_captive_hole("3/8");

    translate([0, hex_nut_diameter("5/16"), 0])
    translate([0, hex_nut_diameter("3/8"), 0])
    translate([0, hex_nut_diameter("7/16"), 0])
    hex_nut_captive_hole("7/16");

    translate([0, hex_nut_diameter("5/16"), 0])
    translate([0, hex_nut_diameter("3/8"), 0])
    translate([0, hex_nut_diameter("7/16"), 0])
    translate([0, hex_nut_diameter("1/2"), 0])
    hex_nut_captive_hole("1/2");

    translate([0, hex_nut_diameter("5/16"), 0])
    translate([0, hex_nut_diameter("3/8"), 0])
    translate([0, hex_nut_diameter("7/16"), 0])
    translate([0, hex_nut_diameter("1/2"), 0])
    translate([0, hex_nut_diameter("9/16"), 0])
    hex_nut_captive_hole("9/16");

    translate([0, hex_nut_diameter("5/16"), 0])
    translate([0, hex_nut_diameter("3/8"), 0])
    translate([0, hex_nut_diameter("7/16"), 0])
    translate([0, hex_nut_diameter("1/2"), 0])
    translate([0, hex_nut_diameter("9/16"), 0])
    translate([0, hex_nut_diameter("5/8"), 0])
    hex_nut_captive_hole("5/8");

    translate([0, hex_nut_diameter("5/16"), 0])
    translate([0, hex_nut_diameter("3/8"), 0])
    translate([0, hex_nut_diameter("7/16"), 0])
    translate([0, hex_nut_diameter("1/2"), 0])
    translate([0, hex_nut_diameter("9/16"), 0])
    translate([0, hex_nut_diameter("5/8"), 0])
    translate([0, hex_nut_diameter("3/4"), 0])
    hex_nut_captive_hole("3/4");

    translate([0, hex_nut_diameter("5/16"), 0])
    translate([0, hex_nut_diameter("3/8"), 0])
    translate([0, hex_nut_diameter("7/16"), 0])
    translate([0, hex_nut_diameter("1/2"), 0])
    translate([0, hex_nut_diameter("9/16"), 0])
    translate([0, hex_nut_diameter("5/8"), 0])
    translate([0, hex_nut_diameter("3/4"), 0])
    translate([0, hex_nut_diameter("7/8"), 0])
    hex_nut_captive_hole("7/8");
}