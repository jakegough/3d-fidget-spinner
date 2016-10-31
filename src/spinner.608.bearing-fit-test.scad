include <spinner.608.lib.scad>;

build_bearing_fit_test();

module build_bearing_fit_test(
    spline_qty = 8
)
{
    difference()
    {
        chamfer_cylinder(
            r = default_outer_diameter / 2, 
            h = default_bearing_height,
            chamfer_radius = default_chamfer_radius);

        bearing_race_hole(
            h = default_bearing_height, 
            r = (default_bearing_diameter + default_bearing_clearance) / 2,
            spline_qty = default_spline_qty,
            spline_depth = default_spline_radius);
    }
    
}
