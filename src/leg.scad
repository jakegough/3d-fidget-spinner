include <shapes/shapes.lib.scad>;

leg();

module leg(
    h = 10,
    r = undef,
    d = 20,
    chamfer_radius = undef, 
    separation = 20)
{        
    hull() 
    {            
        chamfer_cylinder(
            h = h, 
            r = r, 
            d = d,
            chamfer_radius = chamfer_radius);
    
        translate([separation, 0, 0])            
        chamfer_cylinder(
            h = h, 
            r = r,
            d = d, 
            chamfer_radius = chamfer_radius);
    }
}