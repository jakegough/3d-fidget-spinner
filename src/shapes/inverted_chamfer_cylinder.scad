use <torus.scad>;

default_chamfer_radius = 1;
default_extra_margin_bottom = 10;
default_extra_margin_top = 10;

inverted_chamfer_cylinder();

module inverted_chamfer_cylinder(
    h = 10, 
    r = undef, 
    d = 10,
    chamfer_radius = undef,
    extra_margin_bottom = undef,
    extra_margin_top = undef)
{    

    function _chamfer_radius() = (chamfer_radius != undef) ? chamfer_radius : default_chamfer_radius;
    function _extra_margin_bottom() = (extra_margin_bottom != undef) ? extra_margin_bottom : default_extra_margin_bottom;
    function _extra_margin_top() = (extra_margin_top != undef) ? extra_margin_top : default_extra_margin_top;
    
    function _r() = 
        (r) ? r : 
        (d) ? d / 2 :
        "error";

    function _d() = 
        (r) ? r * 2 : 
        (d) ? d :
        "error";
    
    union()
    {
        r = _r();
        inverted_chamfer_rim_top();        
        cylinder(h=h, r=r);
        inverted_chamfer_rim_bottom();
    }
    
    module inverted_chamfer_rim_top()
    {
        extra = _extra_margin_top();
        chamfer_radius = _chamfer_radius();
        r = _r();
        r1 = r;
        r2 = r + chamfer_radius;

        hull()
        {
            translate([0, 0, h - chamfer_radius])
            cylinder(h = chamfer_radius, r1 = r1, r2 = r2);

            translate([0, 0, h])
            cylinder(h=extra, r=r + chamfer_radius);
        }
    }
    
    module inverted_chamfer_rim_bottom()
    {
        extra = _extra_margin_bottom();
        chamfer_radius = _chamfer_radius();
        r = _r();
        r1 = r + chamfer_radius;
        r2 = r;
        
        hull()
        {
            cylinder(h = chamfer_radius, r1 = r1, r2 = r2);

            translate([0, 0, -extra])
            cylinder(h=extra, r=r + chamfer_radius);
        }
    }
}