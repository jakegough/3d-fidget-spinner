include <spinner.608.settings.scad>;
use <knob.scad>;

$fn = 48;

knob_608();

module knob_608(
    knob_diameter = 19,
    knob_thickness = 1.2,
    chamfer_radius = 0.6,
    bearing_diameter = default_bearing_inner_diameter,
    bearing_clearance = .05,
    stem_depth = 3.4,
    stem_bore = 4,
    spline_qty = 3,
    shoulder_height = 0.2,
    shoulder_diameter = 13)
{
    //difference()
    {
        main_knob();
        //knurling();
    }

    module main_knob()
    {
        knob(
            knob_diameter = knob_diameter,
            knob_thickness = knob_thickness,
            chamfer_radius = chamfer_radius,
            bearing_diameter = bearing_diameter,
            bearing_clearance = bearing_clearance,
            stem_depth = stem_depth,
            stem_bore = stem_bore,
            spline_qty = spline_qty,
            shoulder_height = shoulder_height,
            shoulder_diameter = shoulder_diameter);
    }
    
    module knurling()
    {
        cylinder(r1=4, r2 = 0, h=4);            
    }
}