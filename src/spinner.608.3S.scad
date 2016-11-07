use <spinner.scad>;
include <filament_colors.scad>;
include <spinner.608.settings.scad>;
include <spinner.608.3s.settings.scad>;

build_spinner_608();

module build_spinner_608(
    outer_diameter = default_outer_diameter,
    bearing_height = default_bearing_height,
    bearing_diameter = default_bearing_diameter,
    bearing_clearance = default_bearing_clearance,
    legs = default_legs,
    chamfer_radius = default_chamfer_radius,
    fillet_radius = default_fillet_radius,
    spline_qty = default_spline_qty,
    spline_radius = default_spline_radius)
{
    build_spinner(
      outer_diameter = outer_diameter,
      bearing_height = bearing_height,
      bearing_diameter = bearing_diameter,
      bearing_clearance = bearing_clearance,
      legs = legs,
      chamfer_radius = chamfer_radius,
      fillet_radius = fillet_radius,
      spline_qty = spline_qty,
      spline_radius = spline_radius,
      color = filament_bright_green,
      bearing_seal_color = bearing_seal_red);
}