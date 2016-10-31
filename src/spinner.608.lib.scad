include <spinner.lib.scad>;

default_outer_diameter = 28;
default_legs = 4;
default_chamfer_radius = 2;
default_fillet_radius = 5;

// 608 bearing dimensions
default_bearing_height = 7 + (2 * 1.2); // "fatty"
//default_bearing_height = 7; // "slim"
default_bearing_diameter = 22;
default_bearing_clearance = 0.5;
default_spline_qty = 10;
default_spline_radius = default_bearing_clearance;
default_bearing_inner_diameter = 8;

module build_spinner_608(
    outer_diameter = default_outer_diameter,
    bearing_clearance = default_bearing_clearance,
    legs = default_legs,
    chamfer_radius = default_chamfer_radius,
    fillet_radius = default_fillet_radius)
{
    build_spinner(
      outer_diameter = outer_diameter,
      bearing_height = default_bearing_height,
      bearing_diameter = default_bearing_diameter,
      bearing_clearance = bearing_clearance,
      legs = legs,
      chamfer_radius = chamfer_radius,
      fillet_radius = fillet_radius,
      spline_qty = default_spline_qty,
      spline_radius = default_spline_radius);
}