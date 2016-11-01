include <shapes/shapes.lib.scad>;
use <leg.scad>;
use <fillet.scad>;

$fn = 96;

build_spinner();

module build_spinner(
    outer_diameter = 30,
    bearing_height = 7,
    bearing_diameter = 22,
    bearing_clearance = 0.4,
    legs = 3,
    chamfer_radius = 2,
    fillet_radius = 5,
    spline_qty = 8,
    spline_radius = 0.4)
{
    outer_radius = outer_diameter / 2;
    bearing_radius = bearing_diameter / 2;
    margin = (outer_diameter - bearing_diameter) / 2;
    outer_ring_center =  (bearing_diameter + margin);
    
    module legs()
    {
        for (i = [1:legs])
        {
            angle = i * (360 / legs);
            rotate([0, 0, angle])
            leg(
                h = bearing_height, 
                r = outer_radius, 
                chamfer_radius = chamfer_radius, 
                separation = outer_ring_center);
        }
    }
    
    module fillets()
    {
        angle = 360 / legs / 2;
        rotate(angle)
        for (i = [1:legs])
        {
            angle = i * (360 / legs);
            rotate([0, 0, angle])
            fillet(
                leg_diameter = outer_diameter,
                leg_qty = legs,
                leg_height = bearing_height,
                chamfer_radius = chamfer_radius,
                fillet_radius = fillet_radius);
        }
    }
    
    module body()
    {
        union()
        {
            legs();
            fillets();
        }
    }
    
    module bearing_races()
    {
        _bearing_race();
        
        for (i = [1:legs])
        {
            angle = i * (360 / legs);
            rotate([0, 0, angle])
            translate([outer_ring_center ,0 ,0])
            _bearing_race();
        }
        
        module _bearing_race()
        {
            bearing_race_hole(
                h = bearing_height, 
                r = (bearing_diameter + bearing_clearance) / 2,
                spline_qty = spline_qty,
                spline_depth = spline_radius);
        }
    }
    
    difference()
    {
        body();
        bearing_races();
    }    
}
