use <torus.scad>;

chamfer_cylinder();

module chamfer_cylinder(
    h = 10, 
    r = 5, 
    chamfer_radius = 1)
{
    chamfer_diameter = chamfer_radius * 2;
    union()
    {
        translate([0, 0, h-chamfer_diameter])
        chamfer_torus();    
        
        cylinder(
            h = h, 
            r = r - chamfer_radius);
        
        translate([0, 0, chamfer_radius])
        cylinder(
            h = h - (chamfer_radius * 2), 
            r = r);
        
        chamfer_torus();
    }
    
    module chamfer_torus()
    {
        torus(h = chamfer_diameter, r = r, sides = 4);
    }
}