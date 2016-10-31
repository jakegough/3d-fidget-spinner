bearing_race_spline();

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