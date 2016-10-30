$fn = 96;

build_spinner();

module build_spinner(
    outer_diameter = 30,
    bearing_height = 7,
    bearing_diameter = 22,
    bearing_clearance = 0.4,
    legs = 3,
    chamfer_radius = 2,
    fillet_radius = 5)
{
    outer_radius = outer_diameter / 2;
    bearing_radius = bearing_diameter / 2;
    margin = (outer_diameter - bearing_diameter) / 2;
    outer_ring_center =  (bearing_diameter + margin);
    
    module single_leg()
    {        
        hull() 
        {            
            chamfer_cylinder(bearing_height, outer_radius, chamfer_radius);
        
            translate([outer_ring_center, 0, 0])            
            chamfer_cylinder(bearing_height, outer_radius, chamfer_radius);
        }
    }
    
    module legs()
    {
        for (i = [1:legs])
        {
            angle = i * (360 / legs);
            rotate([0, 0, angle])
            single_leg();
        }
    }
    
    module single_fillet()
    {
        // the cube needs to extend to where the arc of the circle intersects the legs
        
        body_radius = outer_radius;
        body_minor_arc = 360 / legs;
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
                h = bearing_height,
                r = fillet_radius,
                chamfer_radius = chamfer_radius);
        }
        
        module fillet_polygon()
        {
            difference()
            {
                fillet_polygon_full();
                
                translate([-3, -outer_diameter/2, -2])
                cube([body_radius + 2, outer_diameter, bearing_height + 3]);
            }
        }
        
        module fillet_polygon_full()
        {
            hull()
            {
                translate([0, -fillet_width/2, 0])
                cube([fillet_distance, fillet_width, bearing_height]);
                
                translate([-1, -(outer_diameter/2), 0])
                cube([1, outer_diameter, bearing_height]);
            }
        }
    }
    
    module fillets()
    {
        angle = 360 / legs / 2;
        rotate(angle)
        _fillets();
        
        module _fillets()
        {
            for (i = [1:legs])
            {
                angle = i * (360 / legs);
                rotate([0, 0, angle])
                single_fillet();
            }
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
            bearing_race(
                h = bearing_height, 
                r = bearing_diameter / 2,
                spline_qty = 8,
                spline_depth = bearing_clearance);
        }
    }
    
    difference()
    {
        body();
        bearing_races();
    }    
}

module bearing_race(
    h = 10, 
    r = 22,
    spline_qty = 4,
    spline_depth = 1,
    extra_margin_bottom = 1,
    extra_margin_top = 1)
{
    difference()
    {
        translate([0,0,-extra_margin_bottom])
        cylinder(
            h = h + extra_margin_bottom + extra_margin_top, 
            r = r);
        
        rotate([0,0,360 / spline_qty / 2])
        splines();
    }
    
    module splines()
    {        
        for (i = [1:spline_qty])
        {
            angle = i * (360 / spline_qty);
            rotate([0,0,angle])
            translate([r,0,0])
            bearing_race_spline(h = h, r = spline_depth, taper = h / 4, $fn = 8);
        }        
    }
}

module bearing_race_spline(
    h = 10, 
    r = 1,
    taper = 2.5)
{
    cylinder_height = h - (taper * 2);
    
    translate([0,0,taper + cylinder_height])
    cylinder(h = taper, r1 = r, r2 = 0);
    
    translate([0,0,taper])
    cylinder(h = cylinder_height, r = r);
    
    cylinder(h = taper, r1 = 0, r2 = r);
}

module chamfer_cylinder(
    h = 1, 
    r = 1, 
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
        
        chamfer_torus();
    }
    
    module chamfer_torus()
    {
        torus(h = chamfer_diameter, r = r, sides = 4);
    }
}

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

module torus(
    h = 2,     
    r = 10,   
    sides = $fn)
{
    tube_radius = h / 2;
    inside_radius = r - tube_radius;
    //translate([r,r,thickness_radius])
    translate([0,0,tube_radius])
    rotate_extrude()
    translate([inside_radius, 0, 0])
    circle(r = tube_radius, $fn = sides);
}
