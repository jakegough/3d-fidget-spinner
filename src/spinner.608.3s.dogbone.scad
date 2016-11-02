include <shapes/shapes.lib.scad>;
use <spinner.scad>;
include <spinner.608.settings.scad>;
include <spinner.608.3s.settings.scad>;

default_bite_inset = 5;
default_outer_diameter = (28 + (5 * 2));
default_bite_radius = 100; 

build_spinner_608();

module build_spinner_608(
    outer_diameter = default_outer_diameter,
    bearing_height = default_bearing_height,
    bearing_diameter = default_bearing_diameter,
    bearing_clearance = default_bearing_clearance,
    chamfer_radius = default_chamfer_radius,
    fillet_radius = default_fillet_radius,
    spline_qty = default_spline_qty,
    spline_radius = default_spline_radius,
    bite_inset = default_bite_inset,
    bite_radius = default_bite_radius)
{
        
    difference()
    {
        build_spinner(
            outer_diameter = outer_diameter,
            bearing_height = bearing_height,
            bearing_diameter = bearing_diameter,
            bearing_clearance = bearing_clearance,
            legs = 2,
            chamfer_radius = chamfer_radius,
            fillet_radius = fillet_radius,
            spline_qty = spline_qty,
            spline_radius = spline_radius);

        side_bites($fn = 256);
    }
    
    module side_bites() {
        side_bite();

        rotate([0, 0, 180])
        side_bite();
    }

    module side_bite() {
        outer_radius = outer_diameter / 2;
        bite_shift = bite_radius + outer_radius - bite_inset;
        
        translate([0, bite_shift, 0])
        inverted_chamfer_cylinder(
            r = bite_radius, 
            h = bearing_height,
            chamfer_radius = chamfer_radius);
    }
}