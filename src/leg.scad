include <shapes/shapes.lib.scad>;

leg();

module leg(
    h = 10,
    r = 10,
    chamfer_radius = 2, 
    separation = 15)
{        
    hull() 
    {            
        chamfer_cylinder(h, r, chamfer_radius);
    
        translate([separation, 0, 0])            
        chamfer_cylinder(h, r, chamfer_radius);
    }
}