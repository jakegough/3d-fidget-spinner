use <shapes/bearing.table.scad>;
use <shapes/inverted_chamfer_cylinder.scad>;
use <shapes/chamfer_cylinder.scad>;
use <spinner.scad>;

include <filament_colors.scad>;
include <spinner.608.3s.settings.scad>;
include <spinner.608.3s.dogbone.settings.scad>;

build_spinner_608_dogbone();

module build_spinner_608_dogbone(
    outer_diameter = default_outer_diameter,
    height = undef,
    chamfer_radius = undef,
    fillet_radius = undef,
    bite_inset = default_bite_inset,
    bite_radius = default_bite_radius,
    bearing_center_distance = default_bearing_center_distance,
    frame_center_distance = default_frame_center_distance,
    color = filament_white)
{
    function _height() = (height != undef) ? height : bearing_height("608");

    difference()
    {
        build_spinner(
            outer_diameter = outer_diameter,
            height = _height(),
            legs = 2,
            chamfer_radius = chamfer_radius,
            fillet_radius = fillet_radius,
            bearing_center_distance = bearing_center_distance,
            frame_center_distance = frame_center_distance,
            color = color);

        color(color)
        side_bites($fn = 128);
    }
    
    module side_bites() {
        side_bite();

        rotate([0, 0, 180])
        side_bite();
    }

    module side_bite() {
        height = _height();
        outer_radius = outer_diameter / 2;
        bite_shift = bite_radius + outer_radius - bite_inset;
        
        translate([0, bite_shift, 0])

        inverted_chamfer_cylinder(
            r = bite_radius, 
            h = height,
            chamfer_radius = chamfer_radius);
    }
}