use <bearing_race_spline.scad>;
include <bearing_race_hole.settings.scad>;
include <bearing.table.scad>;

bearing_race_hole();

module bearing_race_hole(
    index = "608",
    clearance = undef,
    h = undef,
    spline_qty = undef,
    spline_depth = undef,
    extra_margin_bottom = undef,
    extra_margin_top = undef)
{
    function _clearance() = (clearance != undef) ? clearance : default_clearance;
    function _h() = (h != undef) ? h : bearing_height(index);
    function _spline_qty() = (spline_qty != undef) ? spline_qty : default_spline_qty;
    function _spline_depth() = (spline_depth != undef) ? spline_depth : default_spline_depth;
    function _extra_margin_bottom() = (extra_margin_bottom != undef) ? extra_margin_bottom : default_extra_margin_bottom;
    function _extra_margin_top() = (extra_margin_top != undef) ? extra_margin_top : default_extra_margin_top;
    
    r = (bearing_outer_diameter(index) + _clearance()) / 2;

    difference()
    {
        extra_margin_bottom = _extra_margin_bottom();
        extra_margin_top = _extra_margin_top();
        spline_qty = _spline_qty();
        h = _h() + extra_margin_bottom + extra_margin_top;

        translate([0, 0, -extra_margin_bottom])
        cylinder(h = h, r = r);
        
        rotate([0, 0, 360 / spline_qty / 2])
        splines();
    }
    
    module splines()
    {
        h = _h();
        spline_qty = _spline_qty();
        spline_depth = _spline_depth();

        for (i = [1:spline_qty])
        {
            angle = i * (360 / spline_qty);
            rotate([0, 0, angle])
            translate([r, 0, 0])
            bearing_race_spline(
                h = h, 
                r = spline_depth, 
                taper = h / 4, 
                $fn = 8);
        }        
    }
}