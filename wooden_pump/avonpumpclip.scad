// avonpumpclip.scad
// Avon Pump Clip
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

