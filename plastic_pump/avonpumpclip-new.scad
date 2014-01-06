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
depth                = 15; //mm
jaws_width           = 70; //mm
reach                = 15; //mm
projection           = 2; //mm
projection_thickness = 2; //degrees

// Hose clamp parameters
hose_diameter        = 28; //mm

// Other parameters
thickness            = 5; //mm
circular_precision   = 200;
shim                 = 0.1; //mm

module avonpumpclip() {

    difference() {

        // Things that exist
        union() {
            // The basic clamp shape
            avonpumpclip_clamp();

            // cylinder around hose hole
            cylinder( r = hose_diameter/2 + thickness, h = depth, $fn = circular_precision );

            // Projections
            translate( [ jaws_width/2+thickness-shim, reach -1.2, 0 ] ) {
                projection();
            }
            translate( [ -jaws_width/2-thickness+shim, reach -1.2, 0 ] ) {
                mirror(){
                    projection();
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

    hull() {
        cube([shim, projection_thickness, depth]);
        translate([-thickness+shim-projection,projection,0]) {
            cube([shim,projection_thickness,depth]);
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
            translate( [-jaws_width/2 + thickness/2, thickness/2, -shim] ) {
                minkowski() {
                    cube( [ jaws_width - thickness, 2 * reach + thickness/2, depth + shim *2] );
                    cylinder( r = thickness/2, h = shim, $fn = circular_precision );
                }
            }
        }
    }

}

module measurements() {
    
    difference() {

        // Things that exist
        union() {

        }

        // Things that don't exist
        union() {
            translate( [-jaws_width/2, reach + projection_thickness *3, depth/2] ) {
                # cube( [ jaws_width, shim, 1 ] );
            }
            translate( [jaws_width*.35, projection_thickness, 0] ) {
                # cube( [ 1, shim, depth ] );
            }
            translate( [-hose_diameter/2, 0, depth + projection_thickness] ) {
                # cube( [hose_diameter, 1, shim] ); 
            }
        }
    
    }

}

difference() {
    avonpumpclip();
    measurements();
}

//translate([jaws_width/2-projection,reach-projection,2]) {
//    cube([projection,projection,depth]);
//}

//projection_radius = projection / cos(projection_angle);
//projection(projection_radius, depth);
