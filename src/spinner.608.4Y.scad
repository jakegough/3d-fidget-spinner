use <spinner.608.scad>;
include <spinner.608.4y.settings.scad>;

build_spinner_608_4y();

module build_spinner_608_4y(
    outer_diameter = undef,
    chamfer_radius = undef,
    fillet_radius = undef)
{
    function _fillet_radius() = (fillet_radius != undef) ? fillet_radius : default_fillet_radius;

    build_spinner_608(
      outer_diameter = outer_diameter,
      legs = default_legs,
      fillet_radius = _fillet_radius(),
      chamfer_radius = chamfer_radius);
}