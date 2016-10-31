use <bearing_race_hole.scad>;

bearing_race();

module bearing_race(
    h = 10, 
    id = 28,
    od = 30,
    spline_qty = 8,
    spline_depth = 1)
{
    difference()
    {
        cylinder(
            h = h, 
            r = od / 2);
        
        bearing_race_hole(
            h = h,
            r = id / 2,
            spline_qty = spline_qty,
            spline_depth = spline_depth
        );
    }    
}