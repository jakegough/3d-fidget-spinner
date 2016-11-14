use <spinner.scad>;
include <spinner.608.settings.scad>;

build_spinner_608();

module build_spinner_608(
    outer_diameter = undef,
    height = undef,
    bearing_clearance = undef,
    legs = undef,
    chamfer_radius = undef,
    fillet_radius = undef,
    spline_qty = undef,
    spline_radius = undef)
{
    function _outer_diameter() = (outer_diameter != undef) ? outer_diameter : default_outer_diameter;
    function _legs() = (legs != undef) ? legs : default_legs;
    function _chamfer_radius() = (chamfer_radius != undef) ? chamfer_radius : default_chamfer_radius;
    function _fillet_radius() = (fillet_radius != undef) ? fillet_radius : default_fillet_radius;

    build_spinner(
      outer_diameter = _outer_diameter(),
      bearing_index = "608",
      height = height,
      bearing_clearance = bearing_clearance,
      legs = _legs(),
      chamfer_radius = _chamfer_radius(),
      fillet_radius = _fillet_radius(),
      spline_qty = spline_qty,
      spline_radius = spline_radius);
}