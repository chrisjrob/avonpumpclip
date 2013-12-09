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
jaws_width          = 65; //mm
reach               = 15; //mm
projection          = 2.5; //mm

// Hose clamp parameters
hose_diameter       = 28; //mm

// Other parameters
thickness           = 5; //mm
circular_precision  = 100;
shim                = 0.1; //mm

module avonpumpclip() {

    difference() {

        // Things that exist
        union() {
            // The basic clamp shape
            avonpumpclip_clamp();

            // cylinder around hose hole
            cylinder( r = hose_diameter/2 + thickness, h = depth, $fn = circular_precision );

            // The projection
            for ( x = [ -jaws_width/2, jaws_width/2 ] ) {
                translate( [ x, reach + thickness - projection/2, 0 ] ) {
                    cylinder( r = projection/2, h = depth, $fn = circular_precision );
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

module avonpumpclip_clamp() {

    difference() {

        // Things that exist
        union() {
            hull() {
                // cylinder around hose hole
                cylinder( r = hose_diameter/2 + thickness, h = depth, $fn = circular_precision );

                // four small circles around part to create rounded hull
                for ( y = [0, reach + shim] ) {
                    for ( x = [-jaws_width/2, jaws_width/2] ) {
                        translate( [x, y, 0] ) {
                            cylinder( r = thickness, h = depth, $fn = circular_precision );
                        }
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
        }
    }

}

avonpumpclip();

