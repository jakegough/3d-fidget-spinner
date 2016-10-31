include <spinner.608.lib.scad>;
use <knob.scad>;

knob_608();

module knob_608(
    knob_diameter = default_bearing_diameter - 4,
    knob_thickness = 1.2,
    shoulder_height = 0.2)
{
    knob(
      knob_diameter = knob_diameter,
      knob_thickness = knob_thickness,
      bearing_diameter = default_bearing_inner_diameter,
      bearing_clearance = -0.1,
      stem_depth = 3.4,
      stem_bore = 6,
      spline_qty = 4,
      shoulder_height = shoulder_height,
      shoulder_diameter = default_bearing_inner_diameter + 2);
}