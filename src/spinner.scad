//include <lib/bolts/bolts.scad>;
include <shapes/bearing_race_hole.settings.scad>;
include <shapes/shapes.lib.scad>;
include <filament_colors.scad>;
use <shapes/bearing_race_hole.scad>;
use <shapes/bearing.scad>;
use <leg.scad>;
use <fillet.scad>;

$fn = 96;

build_spinner();

module build_spinner(
    outer_diameter = 30,
    bearing_index = "608",
    height = undef,
    bearing_clearance = undef,
    legs = 3,
    chamfer_radius = undef,
    fillet_radius = 5,
    spline_qty = undef,
    spline_radius = undef,
    bearing_center_distance = undef,
    frame_center_distance = undef,
    color = filament_red,
    show_bearings = true,
    bearing_seal_color = bearing_seal_blue)
{
    outer_radius = outer_diameter / 2;
    bearing_outer_diameter = bearing_outer_diameter(bearing_index); 
    bearing_outer_radius = bearing_outer_diameter / 2;
    bearing_inner_diameter = bearing_inner_diameter(bearing_index);
    bearing_height = bearing_height(bearing_index);
    margin = (outer_diameter - bearing_outer_diameter) / 2;

    function _height() = (height) ? height : bearing_height(bearing_index);
    
    outer_ring_center =  (frame_center_distance != undef) 
        ? frame_center_distance 
        : bearing_outer_diameter + margin;

    bearing_center =  (bearing_center_distance != undef) 
        ? bearing_center_distance 
        : outer_ring_center;

    color(color)
    difference()
    {
        body();
        bearing_races();
    }

    module body()
    {
        union()
        {
            legs();
            fillets();
        }
    }

    if (show_bearings)
    {
        bearings();
    }
    
    module legs()
    {
        for (i = [1:legs])
        {
            angle = i * (360 / legs);
            rotate([0, 0, angle])
            leg(
                h = _height(), 
                r = outer_radius, 
                chamfer_radius = chamfer_radius, 
                separation = outer_ring_center);
        }
    }
    
    module fillets()
    {
        h = _height();
        angle = 360 / legs / 2;
        rotate(angle)
        for (i = [1:legs])
        {
            angle = i * (360 / legs);
            rotate([0, 0, angle])
            fillet(
                leg_diameter = outer_diameter,
                leg_qty = legs,
                leg_height = h,
                chamfer_radius = chamfer_radius,
                fillet_radius = fillet_radius);
        }
    }
    
    module bearing_races()
    {
        _bearing_race();
        
        for (i = [1:legs])
        {
            angle = i * (360 / legs);
            rotate([0, 0, angle])
            translate([bearing_center, 0, 0])
            _bearing_race();
        }
        
        module _bearing_race()
        {
            bearing_race_hole(
                index = bearing_index,
                h = _height(),                 
                spline_qty = spline_qty,
                spline_depth = spline_radius);
        }
    }

    module bearings()
    {
        _bearing(show_seals = false);

        for (i = [1:legs])
        {
            angle = i * (360 / legs);
            rotate([0, 0, angle])
            translate([bearing_center, 0, 0])
            rotate([0,0,-90])
            _bearing();
        }

        module _bearing(show_seals = true)
        {
            %bearing(
                od = bearing_outer_diameter,
                id = bearing_inner_diameter,
                h = bearing_height,
                show_seals = show_seals,
                seal_color = bearing_seal_color,
                show_seal_text = false,
                color_alpha = 0.2);

            //DIN625_1("608");
        }
    }
}
