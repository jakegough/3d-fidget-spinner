torus();

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