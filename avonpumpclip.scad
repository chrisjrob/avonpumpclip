// avonpumpclip/avonpumpclip.scad
// Copyright 2013 Christopher Roberts

// Pump clamp parameters
length         = 110;
width          = 35;
depth          = 30;
thickness      = 5;
grip_width     = 8;
grip_thickness = 3;

// Hose clamp parameters
diameter       = 26;
precision      = 100;

module avonpumpclip() {

    difference() {

        // Things that exist
        union() {
            // Body of pump clamp
            cube( size = [ length, width, depth ] );

            // Body of hose clamp
            translate( v = [ length/2 - diameter/2 - thickness, -diameter, 0] ) {
                cube( size = [ diameter + (thickness * 2), diameter, depth ] );
            }
        }

        // Things to be cut out
        union() {
            // Cutaway inside of pump clamp
            translate( v = [thickness, thickness, -0.1] ) { 
                cube( size = [ length - (thickness * 2), width - thickness - grip_width, depth +0.2 ] );
            }

            // Cutaway between pump grips
            translate( v = [thickness + grip_thickness, width - grip_width - 0.1, -0.1] ) { 
                cube( size = [ length - (thickness * 2) - (grip_thickness * 2), grip_width + 0.2, depth +0.2 ] );
            }

            // Cutaway hose
            translate( v = [ length/2, -diameter/2, -0.1] ) {
                cylinder( r = diameter/2, h = depth +0.2, $fn = precision );
            }

            // Cutaway entrance for hose
            translate( v = [ length/2 - diameter/4, -diameter -0.1, -0.1] ) {
                cube( size = [ diameter/2, diameter/2, depth +0.2 ] );
            }

        }
    }

}

avonpumpclip();

