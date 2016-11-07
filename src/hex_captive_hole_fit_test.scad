use <shapes/hex_nut_captive_hole.scad>;
use <shapes/chamfer_cylinder.scad>;

hex_captive_hole_fit_test();

module hex_captive_hole_fit_test(index = "5/16")
{
    difference()
    {
        d = hex_nut_diameter(index) + 8;
        h = hex_nut_height(index);

        chamfer_cylinder(d = d, h = h);
        hex_nut_captive_hole(index);
    }
}