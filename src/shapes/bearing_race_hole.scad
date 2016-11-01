use <bearing_race_spline.scad>;

bearing_race_hole();

module bearing_race_hole(
    h = 10, 
    r = 22,
    spline_qty = 4,
    spline_depth = 1,
    extra_margin_bottom = 1,
    extra_margin_top = 1)
{
    difference()
    {
        translate([0, 0, -extra_margin_bottom])
        cylinder(
            h = h + extra_margin_bottom + extra_margin_top, 
            r = r);
        
        rotate([0, 0, 360 / spline_qty / 2])
        splines();
    }
    
    module splines()
    {        
        for (i = [1:spline_qty])
        {
            angle = i * (360 / spline_qty);
            rotate([0, 0, angle])
            translate([r, 0, 0])
            bearing_race_spline(
                h = h, 
                r = spline_depth, 
                taper = h / 4, 
                $fn = 8);
        }        
    }
}