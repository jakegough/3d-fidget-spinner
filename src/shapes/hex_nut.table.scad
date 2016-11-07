include <units.scad>;

function hex_nut_diameter(index) = hex_nut_data(index)[0];
function hex_nut_height(index) = hex_nut_data(index)[1];

// https://www.boltdepot.com/fastener-information/nuts-washers/us-nut-dimensions.aspx
function hex_nut_data(index) = 
    // diameter, height
    index == "1/4"  ? [inches_to_mm(7/16),  inches_to_mm(7/32)] : 
    index == "5/16" ? [inches_to_mm(1/2),   inches_to_mm(17/64)] :
    index == "3/8"  ? [inches_to_mm(9/16),  inches_to_mm(21/64)] :
    index == "7/16" ? [inches_to_mm(11/16), inches_to_mm(3/8)] :
    index == "1/2"  ? [inches_to_mm(3/4),   inches_to_mm(7/16)] :
    index == "9/16" ? [inches_to_mm(7/8),   inches_to_mm(31/64)] :
    index == "5/8"  ? [inches_to_mm(15/16), inches_to_mm(35/64)] :
    index == "3/4"  ? [inches_to_mm(1+(1/8)),  inches_to_mm(41/64)] :
    index == "7/8"  ? [inches_to_mm(1+(5/16)), inches_to_mm(3/4)] :
    index == "1"    ? [inches_to_mm(1+(1/2)),  inches_to_mm(55/64)] :
    "Error";