function bearing_outer_diameter(index) = bearing_data(index)[0];
function bearing_inner_diameter(index) = bearing_data(index)[1];
function bearing_height(index) = bearing_data(index)[2];
function bearing_ball_qty(index) = bearing_data(index)[3];

function bearing_data(index) = 
    // od, id, h, ball_qty
    index == "608"  ? [22, 8, 7, 7] :
    "Error";