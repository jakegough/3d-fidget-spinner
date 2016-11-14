use <spinner.608.scad>;
include <spinner.608.settings.scad>;
include <spinner.608.fatty.settings.scad>;

build_spinner_608_fatty();

module build_spinner_608_fatty(
    outer_diameter = undef,
    legs = undef,
    chamfer_radius = undef,
    fillet_radius = undef)
{
    build_spinner_608(
        outer_diameter = outer_diameter,
        height = default_height,
        legs = legs,
        chamfer_radius = chamfer_radius,
        fillet_radius = fillet_radius);
}