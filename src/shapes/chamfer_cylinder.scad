use <torus.scad>;

default_chamfer_radius = 1;

chamfer_cylinder();

module chamfer_cylinder(
    h = 10, 
    r = undef,
    d = 10,
    chamfer_radius = undef)
{
    function _chamfer_radius() = (chamfer_radius != undef) ? chamfer_radius : default_chamfer_radius;
    
    function _r() = 
        (r) ? r : 
        (d) ? d / 2 :
        "error";

    hull()
    {
        r = _r();
        chamfer_radius = _chamfer_radius();

        // top chamfer
        translate([0, 0, h-chamfer_radius])
        cylinder(
            h = chamfer_radius, 
            r1 = r,
            r2 = r - chamfer_radius);
        
        // bottom chamfer
        cylinder(
            h = chamfer_radius, 
            r1 = r - chamfer_radius,
            r2 = r);
    }    
}