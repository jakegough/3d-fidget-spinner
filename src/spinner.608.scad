use <spinner.scad>

build_spinner_608();

module build_spinner_608(
    outer_diameter = 28,
    bearing_clearance = 0.4,
    legs = 4,
    chamfer_radius = 2,
    fillet_radius = 5)
{
    build_spinner(
      outer_diameter = outer_diameter,
      bearing_height = 7,
      bearing_diameter = 22,
      bearing_clearance = bearing_clearance,
      legs = legs,
      chamfer_radius = chamfer_radius,
      fillet_radius = fillet_radius);
}