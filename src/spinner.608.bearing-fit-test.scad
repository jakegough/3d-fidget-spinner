use <shapes/bearing_race_hole.scad>;
use <shapes/chamfer_cylinder.scad>;

build_bearing_fit_test();

module build_bearing_fit_test(
    index = "608"
)
{
    difference()
    {
        d = bearing_outer_diameter(index) + 10;
        h = bearing_height(index);

        chamfer_cylinder(d = d, h = h);
        bearing_race_hole(index, h = h);
    }
}
