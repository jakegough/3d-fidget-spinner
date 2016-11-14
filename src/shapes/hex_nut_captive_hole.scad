use <polygon_captive_hole.scad>;
include <hex_nut.table.scad>;
include <hex_nut_captive_hole.settings.scad>;

hex_nut_captive_hole();

module hex_nut_captive_hole(
    index = "3/8",
    h = undef,
    clearance = undef,
    spline_qty = undef,
    spline_depth = undef,
    extra_margin_bottom = undef,
    extra_margin_top = undef)
{

    function _h() = (h != undef) ? h : hex_nut_height(index);
    function _clearance() = (clearance != undef) ? clearance : default_clearance;
    function _spline_qty() = (spline_qty != undef) ? spline_qty : default_spline_qty;
    function _spline_depth() = (spline_depth != undef) ? spline_depth : default_spline_depth;
    function _extra_margin_bottom() = (extra_margin_bottom != undef) ? extra_margin_bottom : default_extra_margin_bottom;
    function _extra_margin_top() = (extra_margin_top != undef) ? extra_margin_top : default_extra_margin_top;
    
    flat_d = hex_nut_diameter(index) + _clearance();

    polygon_captive_hole(
        sides = 6, 
        flat_d = flat_d,
        h = _h(),
        spline_qty = _spline_qty(),
        spline_depth = _spline_depth(),
        extra_margin_bottom = _extra_margin_bottom(),
        extra_margin_top = _extra_margin_top()
    );
}