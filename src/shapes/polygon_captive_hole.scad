use <bearing_race_spline.scad>;

polygon_captive_hole(d = 30);

module polygon_captive_hole(
    sides = 6,
    h = 10, 
    r = undef,
    d = undef,    
    flat_r = undef,  
    flat_d = undef,
    spline_qty = 12,
    spline_depth = 0.5,
    extra_margin_bottom = 1,
    extra_margin_top = 1)
{
    sides_arc = (360 / sides);
    sides_half_arc = sides_arc / 2;
    splines_arc = (360 / spline_qty);
    splines_half_arc = splines_arc / 2;

    function r() = radius(r, d, flat_r, flat_d, sides);
    function d() = diameter(r, d, flat_r, flat_d, sides);
    function flat_r() = flat_radius(r, d, flat_r, flat_d, sides);
    function flat_d() = flat_diameter(r, d, flat_r, flat_d, sides);
    
    difference()
    {
        translate([0, 0, -extra_margin_bottom])
        cylinder(
            r = r(), 
            h = h + extra_margin_bottom + extra_margin_top, 
            $fn = sides);
            
        splines();
    }
    
    module splines()
    {        
        for (i = [1 : spline_qty])
        {
            angle = (i * splines_arc) + splines_half_arc;
            _spline(angle);
        }

        module _spline(angle)
        {
            half_arc_intersecting_radius = flat_r();
            right_triangle_angle = abs(sides_half_arc - (angle % sides_arc));
            
            distance_from_center = (right_triangle_angle)
                ? half_arc_intersecting_radius / cos(right_triangle_angle)
                : half_arc_intersecting_radius;

            rotate([0, 0, angle])
            translate([distance_from_center, 0, 0])
            bearing_race_spline(
                h = h, 
                r = spline_depth, 
                taper = h / 4, 
                $fn = 8);
        }
    }
}

function radius(r, d, fr, fd, sides) = 
    (r)  ? r : 
    (d)  ? radius_from_diameter(d) : 
    (fr) ? radius_from_flat_radius(fr, sides) : 
    (fd) ? radius_from_flat_diameter(fd, sides) : 
    undef;

function diameter(r, d, fr, fd, sides) = 
    (r)  ? diameter_from_radius(r) :
    (d)  ? d :
    (fr) ? diameter_from_flat_radius(fr, sides) :
    (fd) ? diameter_from_flat_diameter(fd, sides) :
    undef;

function flat_radius(r, d, fr, fd, sides) = 
    (r)  ? flat_radius_from_radius(r, sides) :
    (d)  ? flat_radius_from_diameter(d, sides) :
    (fr) ? fr :
    (fd) ? flat_radius_from_flat_diameter(fd) :
    undef;

function flat_diameter(r, d, fr, fd, sides) = 
    (r)  ? flat_diameter_from_radius(r, sides) :
    (d)  ? flat_diameter_from_diameter(d, sides) :
    (fr) ? flat_diameter_from_flat_radius(fr) :
    (fd) ? fd :     
    undef;

function radius_from_diameter(d) = d / 2;
function radius_from_flat_radius(fr, sides) = fr / cos(360 / sides / 2);
function radius_from_flat_diameter(fd, sides) = radius_from_flat_radius(fd / 2, sides);

function diameter_from_radius(r) = r * 2;
function diameter_from_flat_radius(fr, sides) = radius_from_flat_radius(fr, sides) * 2;
function diameter_from_flat_diameter(fd, sides) = radius_from_flat_radius(fd / 2, sides) * 2; 

function flat_radius_from_flat_diameter(fd) = fd / 2;
function flat_radius_from_radius(r, sides) = cos(360 / sides / 2) * r;
function flat_radius_from_diameter(d, sides) = flat_radius_from_radius(d / 2, sides);

function flat_diameter_from_flat_radius(fr) = fr * 2;
function flat_diameter_from_radius(r, sides) = flat_radius_from_radius(r, sides) * 2;
function flat_diameter_from_diameter(d, sides) = flat_radius_from_radius(d / 2, sides) * 2;