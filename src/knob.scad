include <spinner.lib.scad>;

$fn = 96;

knob();

module knob(
    knob_diameter = 28,
    knob_thickness = 1.5, 
    chamfer_radius = 0.5,
    bearing_diameter = 10,
    bearing_clearance = 0.2,
    stem_depth = 5,   
    stem_bore = 8, 
    shoulder_height = 0.2,
    shoulder_diameter = 15,
    spline_qty = 4,
    spline_depth = 0.4)
{
    bearing_radius = bearing_diameter / 2;
    knob_radius = knob_diameter / 2;

    shoulder_radius = shoulder_diameter / 2;
    shoulder_z = knob_thickness; 

    stem_z = knob_thickness + shoulder_height;
    stem_radius = (bearing_diameter - bearing_clearance) /2;

    // knob outside
    chamfer_cylinder(
        h = knob_thickness, 
        r = knob_radius , 
        chamfer_radius = chamfer_radius);

    // knob inside
    translate([0, 0, chamfer_radius])
    cylinder(
        r = knob_radius,
        h = knob_thickness - chamfer_radius);

    // stem
    translate([0, 0, stem_z])
    stem();

    // shoulder
    translate([0, 0, shoulder_z])
    cylinder(
        h = shoulder_height,
        r = shoulder_radius);

    // splines
    splines();

    module stem()
    {
        stem_bore_radius = stem_bore / 2;
        difference()
        {
            cylinder(
                h = stem_depth,
                r = stem_radius);

            translate([0,0,0.1])
            cylinder(
                h = stem_depth + 0.2,
                r = stem_bore_radius);
        }
    }

    module splines()
    {        
        spline_z = knob_thickness + shoulder_height;
        spline_h = stem_depth;
        spline_taper = 0;

        for (i = [1:spline_qty])
        {
            angle = i * (360 / spline_qty);
            rotate([0,0,angle])
            translate([stem_radius, 0, spline_z])
            bearing_race_spline(
                h = spline_h, 
                r = spline_depth, 
                taper = spline_taper, 
                $fn = 8);
        }
    }
}