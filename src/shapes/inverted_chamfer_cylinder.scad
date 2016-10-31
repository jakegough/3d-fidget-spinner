use <torus.scad>;

inverted_chamfer_cylinder();

module inverted_chamfer_cylinder(
    h = 7, 
    r = 15, 
    chamfer_radius = 1,
    extra_margin_bottom = 1,
    extra_margin_top = 1)
{    
    chamfer_diameter = chamfer_radius * 2;
    
    union()
    {
        translate([0, 0, h-chamfer_radius])
        hull()
        {            
            inverted_chamfer_rim_top();    
            
            translate([0,0,chamfer_radius])
            cylinder(
                h = extra_margin_top,
                r = r + chamfer_radius);
        }
        
        cylinder(h=h, r=r);
        
        hull()
        {            
            inverted_chamfer_rim_bottom();
            translate([0,0,-extra_margin_bottom])
            cylinder(
                h = extra_margin_bottom,
                r = r + chamfer_radius);
        }
    }
    
    module inverted_chamfer_rim_top()
    {
        difference()
        {
            inverted_chamfer_torus();
            
            translate([0,0,chamfer_radius])
            cylinder(
                h = chamfer_radius,
                r = r + chamfer_radius);
        }
    }
    
    module inverted_chamfer_rim_bottom()
    {
        translate([0,0,-chamfer_radius])
        difference()
        {
            inverted_chamfer_torus();
            
            cylinder(
                h = chamfer_radius,
                r = r + chamfer_radius);
        }
    }
    
    module inverted_chamfer_torus()
    {
        torus(h = chamfer_diameter, r = r + chamfer_radius, sides = 4);
    }
}