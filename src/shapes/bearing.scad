include <bearing.table.scad>;
use <../lib/write/Write.scad>;

steel_color = [.6, .6, .6];

bearing($fn=48);

module bearing(
    index = "608",
    steel_thickness = 1.5,
    show_seals = true,
    seal_color = [0, 0, 0],
    show_seal_text = true,
    seal_text = "608RS",
    seal_text_color = [1, 1, 1],
    color_alpha = 1.0,
)
{
    od = bearing_outer_diameter(index);
    id = bearing_inner_diameter(index);
    h = bearing_height(index);
    outer_steel_id = od - (steel_thickness * 2);
    inner_steel_od = id +  (steel_thickness * 2);

    union()
    {
        outer_steel();
        inner_steel();

        if (show_seals)
        {
            seals();
        }
        else
        {
            ball_bearings();
            ball_bearing_carriage();
        }
    }

    module inner_steel()
    {
        color(steel_color, color_alpha)
        ring(
            od = inner_steel_od, 
            id = id, 
            h = h);
    }

    module outer_steel()
    {
        color(steel_color, color_alpha)
        ring(
            od = od, 
            id = outer_steel_id, 
            h = h);
    }

    module ball_bearings()
    {
        ball_bearing_qty = bearing_ball_qty(index);

        for (i = [ 1 : ball_bearing_qty ]) 
        {
            angle = i * (360 / ball_bearing_qty);
            bearing_diameter = (outer_steel_id - inner_steel_od) / 2;
            bearing_radius = bearing_diameter / 2;

            rotate(angle)
            translate([(inner_steel_od / 2) + bearing_radius, 0, h / 2])
            color(steel_color, color_alpha)
            sphere(d = bearing_diameter);
        }
    }

    module ball_bearing_carriage()
    {        
        carriage_h = 0.5;
        translate([0,0, (h + carriage_h) / 2])
        color(steel_color, color_alpha)
        ring(
            od = outer_steel_id - 1, 
            id = inner_steel_od + 1, 
            h = 0.5);
    }

    module seals()
    {
        color(seal_color, color_alpha)
        translate([0,0,0.2])
        ring(
            od = outer_steel_id, 
            id = inner_steel_od, 
            h = h - 0.4);

        if (show_seal_text)
        {
            translate([0, 0, h])
            write_seal_text();

            rotate([0,180,180])
            write_seal_text();
        }

    }

    module write_seal_text()
    {
        total_text_area = (outer_steel_id - inner_steel_od) / 2;
        text_margin = 1.5;
        text_h = total_text_area  - text_margin;
        text_r = (inner_steel_od / 2) + (total_text_area / 2);
        text_t = 1;

        color(seal_text_color, color_alpha)
        translate([0,0,-text_t/2])
        writecircle(
            text = seal_text, 
            h = text_h, 
            t = text_t,
            radius = text_r, 
            space = 1.2,
            down = 20);
    }
}

module ring(
    od = 20,
    id = 18,
    h = 5)
{
    difference()
    {
        cylinder(d = od, h = h);

        translate([0, 0, -1])
        cylinder(d = id, h = h + 2);
    }    
}