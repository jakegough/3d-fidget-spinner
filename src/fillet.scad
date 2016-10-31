use <shapes/inverted_chamfer_cylinder.scad>;

fillet();

module fillet(
    leg_diameter = 20,
    leg_qty = 3,
    leg_height = 10,
    chamfer_radius = 2,
    fillet_radius = 5)
{
    outer_radius = leg_diameter / 2;
    // the cube needs to extend to where the arc of the circle intersects the leg_qty
    
    body_radius = outer_radius;
    body_minor_arc = 360 / leg_qty;
    body_minor_arc_half = body_minor_arc / 2;
    
    a = fillet_radius * cos(body_minor_arc_half);
    b = fillet_radius * sin(body_minor_arc_half);
    c = a * tan(90 - body_minor_arc_half);
    
    d = body_radius / (cos(90-body_minor_arc_half));
    
    cumulative_error_mesh_adjust = 0.01;
    leg_intersection = d;
    fillet_width = (a * 2);
    fillet_intersecting_radius = c + d;
    fillet_center = b + c + d;
    fillet_distance = fillet_intersecting_radius;
    fillet_arc = body_minor_arc_half;
    
    translate([-cumulative_error_mesh_adjust,0,0])
    difference()
    {
        fillet_polygon();
        
        translate([fillet_center, 0, 0])
        inverted_chamfer_cylinder(
            h = leg_height,
            r = fillet_radius,
            chamfer_radius = chamfer_radius);
    }
    
    module fillet_polygon()
    {
        erase_cube_margin = 1;
        erase_cube_x = (body_radius / 2) + erase_cube_margin;
        erase_cube_y = leg_diameter + erase_cube_margin;
        erase_cube_z = leg_height + erase_cube_margin;

        difference()
        {
            fillet_polygon_full();
            
            translate([-erase_cube_margin, -erase_cube_y/2, -erase_cube_margin/2])
            cube([erase_cube_x, erase_cube_y, erase_cube_z]);
        }
    }
    
    module fillet_polygon_full()
    {
        hull()
        {
            translate([0, -fillet_width/2, 0])
            cube([fillet_distance, fillet_width, leg_height]);
            
            translate([-0.1, -(leg_diameter/2), 0])
            cube([0.1, leg_diameter, leg_height]);
        }
    }
}

