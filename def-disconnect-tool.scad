// --- Adjustable Parameters ---
opening_width = 34.4;   // 1-3/8" gap
prong_width = 18.0;     // Width of the "legs"
prong_length = 52.0;    // Depth of the prongs
handle_height = 42.0;   // Height of handle area
plate_thickness = 6.0;  // Total thickness
edge_radius = 1.5;      // Horizontal rounding (corners)
throat_radius = 4.0;    // The "slight radius" in the corners of the throat

// Increase this for the final render (F6), keep it low (20-30) for preview
$fn = 60; 

// --- The Tool Logic ---
linear_extrude(height = plate_thickness) {
    offset(r = edge_radius) { // This rounds all horizontal edges instantly
        difference() {
            // 1. MAIN BODY (Shrunk slightly to account for the offset)
            total_w = opening_width + (prong_width * 2);
            total_h = prong_length + handle_height;
            
            translate([-(total_w/2 - edge_radius), edge_radius])
                square([total_w - edge_radius*2, total_h - edge_radius*2]);

            // 2. THE SQUARED THROAT (Matches the product photo)
            // We create the flat-top cutout with small radius corners
            translate([0, prong_length - edge_radius])
                hull() {
                    translate([-(opening_width/2 + edge_radius - throat_radius), 0]) 
                        circle(r = throat_radius);
                    translate([(opening_width/2 + edge_radius - throat_radius), 0]) 
                        circle(r = throat_radius);
                }
            
            // Clean out the rest of the prong gap
            translate([-(opening_width/2 + edge_radius), -5])
                square([opening_width + edge_radius*2, prong_length - edge_radius + 5]);

            // 3. FINGER GRIPS (Side Cutouts)
            translate([-total_w/2 + edge_radius, total_h - 28]) 
                circle(r = 8);
            translate([total_w/2 - edge_radius, total_h - 28]) 
                circle(r = 8);

            // 4. TOP HOLE
            translate([0, total_h - 12]) 
                circle(d = 8);

            // 5. OUTER TIP TAPERS
            // Left Tip
            translate([-total_w/2, 0])
                rotate([0, 0, 15]) translate([-20, 0]) square([20, 30]);
            // Right Tip
            translate([total_w/2, 0])
                rotate([0, 0, -15]) translate([0, 0]) square([20, 30]);
        }
    }
}   
