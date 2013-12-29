// avonpumpclip-new.scad
// Avon Pump Clip - Newer Pump Design
// 
// Copyright (C) 2013 Christopher Roberts
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// Pump clamp parameters
depth               = 15; //mm
jaws_width          = 70; //mm
reach               = 15; //mm
projection          = 5; //mm
projection_angle    = 33.3; //degrees

// Hose clamp parameters
hose_diameter       = 28; //mm

// Other parameters
thickness           = 5; //mm
circular_precision  = 200;
shim                = 0.1; //mm

module avonpumpclip() {

    projection_radius = (projection / cos(projection_angle))/2;

    difference() {

        // Things that exist
        union() {
            // The basic clamp shape
            avonpumpclip_clamp();

            // cylinder around hose hole
            cylinder( r = hose_diameter/2 + thickness, h = depth, $fn = circular_precision );

            // The projection - contains a bodge with the angles being hardcoded - needs fixing
            translate( [ jaws_width/2 +thickness -projection_radius/2, reach, 0 ] ) {
                rotate( [0, 0, -projection_angle] ) {
                    projection(projection_radius, depth);
                }
            }
            translate( [ -jaws_width/2 -thickness +projection_radius/2, reach, 0 ] ) {
                rotate( [0, 0, 180 +projection_angle] ) {
                    projection(projection_radius, depth);
                }
            }
        }

        // Things that don't exist
        union() {
            translate( [ 0, 0, -shim ] ) {
                cylinder( r = hose_diameter/2, h = depth + 2 * shim, $fn = circular_precision );
            }
        }

    }

}

module projection(r,d) {


    // length should be translated to the hypotenuse from thickness and projection angle
    // cos @ = a / h
    // h = a / cos @
    projection_length = (thickness -r/2) / cos(projection_angle);

    // sin @ = o / h
    // o = sin @ * thickness
    projection_thickness = sin(projection_angle) * thickness;

    union() {
        union() {
            scale( [0.5, 0.5, 1] ) {
                cylinder( r = r, h = d, $fn = circular_precision );
            }
            translate([ -projection_length, -r/2, 0] ) {
                cube([projection_length,r,d]);
            }
        }
        translate([ -projection_length, 0, 0] ) {
            difference() {

                // Things that exist
                union() {
                    scale( [2, 0.5, 1] ) {
                        cylinder( r = r, h = d, $fn = circular_precision );
                    }
                }

                // Things that don't exist
                union() {
                    translate([0, -r, -shim]) {
                        cube([2 * r, 2 * r, d + 2 * shim]);
                    }
                }
            
            }
        }
    }

}

module avonpumpclip_clamp() {

    difference() {

        // Things that exist
        union() {
            hull() {
                // cylinder around hose hole
                cylinder( r = hose_diameter/2 + thickness, h = depth, $fn = circular_precision );

                // two small circles around part to create rounded hull
                for ( x = [-jaws_width/2, jaws_width/2] ) {
                    translate( [x, 0, 0] ) {
                        cylinder( r = thickness, h = depth, $fn = circular_precision );
                    }
                }
                // two small cubes around part to create rounded hull
                for ( x = [-jaws_width/2 -thickness, jaws_width/2] ) {
                    translate( [x, reach + shim, 0] ) {
                        cube( [ thickness, shim, depth] );
                    }
                }
           }

        }

        // Things to be cut out
        union() {
            // hose hole
            translate( [-jaws_width/2, thickness, -shim] ) {
                cube( [ jaws_width, 2 * reach, depth + shim *2] );
            }
            // 
        }
    }

}

avonpumpclip();

//translate([jaws_width/2-projection,reach-projection,2]) {
//    cube([projection,projection,depth]);
//}

//projection_radius = projection / cos(projection_angle);
//projection(projection_radius, depth);
