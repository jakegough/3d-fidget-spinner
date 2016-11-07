include <bearing.table.scad>;
include <bearing_race_hole.settings.scad>;
use <bearing_race_hole.scad>;

bearing_race();

module bearing_race(
    index = "608",
    h = undef, 
    od = undef,
    clearance = undef,
    spline_qty = undef,
    spline_depth = undef)
{
    function _od() = (od != undef) ? od : bearing_outer_diameter(index) + 2;
    function _h() = (h != undef) ? h : bearing_height(index);

    difference()
    {
        h = _h();
        r = _od() / 2;

        cylinder(
            h = h, 
            r = r);
        
        bearing_race_hole(
            index = index,
            clearance = clearance,
            h = h,
            spline_qty = spline_qty,
            spline_depth = spline_depth
        );
    }    
}