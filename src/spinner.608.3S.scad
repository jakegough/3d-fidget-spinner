use <spinner.608.scad>;
include <spinner.608.3s.settings.scad>;

build_spinner_608_3s();

module build_spinner_608_3s(
    outer_diameter = undef,
    chamfer_radius = undef)
{
    build_spinner_608(
      outer_diameter = outer_diameter,
      legs = default_legs,
      chamfer_radius = chamfer_radius);
}