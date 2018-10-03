generate_box = true;//true to generate box, false for lid

//breadboard size
length = 165.1; //longer side of the breadboard
width = 54.5; //shorter side of the breadboard. Include dovetails if it exists.
height = 10; //height of the breadboard

dovetail_width = 1.5; //width of the dovetailes sticking out on the longer side
front_dovetail = true; //true if you want the dovetail sticking out on the long side to be facing you. 

//jumper wires. Makes 7 compartments based on these numberes
long_wire = 128; //longest jumper wire in the set plus. Must be decently shorter than length of the breadboard.
wire_height = 8; //length of the bent part of the wire

wire_clearance = 5; //minimum extra width for jumper wires

//batteries. 2 x 9V, 1 x AA
AA_diameter = 16;
9V_Width = 27;
battery_length = 60; //length of battery including clearence for fingers for both battery types

//misc
clearence = 0.2; //general clearence for misc components
wall_width = 1.2; //width of walls
max_height = 20; //max height of the contents of the box

//constants with clearence
Clength = length + clearence*2;
Cwidth = width + clearence*2;
Cheight = height + clearence;
Cdovetail_width = dovetail_width + clearence;

Clong_wire = long_wire + wire_clearance;
Cwire_height = wire_height*2;

CAA_diameter = AA_diameter + clearence*2;
C9V_Width = 9V_Width + clearence*2;
Cbattery_length = battery_length + clearence*2;

Cmax_height = max_height + clearence*2;

//Other calculated
TLength = Clength + Cbattery_length + wall_width*3; //total length
TWidth = Cwidth + Cdovetail_width + Cwire_height*3 + wire_height + wall_width*6; //total width
THeight = Cmax_height + wall_width*2; //total height

if (generate_box == true) { //generate box
    difference () { //cut away sections from main body
        cube([TLength, TWidth, THeight]); //main body
        
        if(front_dovetail == true) {
            translate([wall_width, wall_width + Cdovetail_width, wall_width]) { //breadboard
                cube([Clength, Cwidth, THeight]); 
                translate([Cdovetail_width*3, -Cdovetail_width, 0]) { //dovetail cutoff
                    cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                }
                translate([Clength/2-Cdovetail_width*5, -Cdovetail_width, 0]) {
                    cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                }
                translate([Clength-Cdovetail_width*3-Cdovetail_width*10, -Cdovetail_width, 0]) {
                    cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                }
            }
        } else {
            translate([wall_width, wall_width, wall_width]) { //breadboard
                cube([Clength, Cwidth, THeight]); 
                translate([Cdovetail_width*3, Cwidth, 0]) { //dovetail cutoff
                    cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                }
                translate([Clength/2-Cdovetail_width*5, Cwidth, 0]) {
                    cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                }
                translate([Clength-Cdovetail_width*3-Cdovetail_width*10, Cwidth, 0]) {
                    cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                }
            }
        }
        translate([wall_width, wall_width, wall_width + Cheight]) { //top of breadboard
            cube([Clength, Cwidth + Cdovetail_width, THeight]);
        }
        
        translate([wall_width, wall_width + Cdovetail_width + Cwidth + wall_width, wall_width]) { //jumper wire and other long compartments
            cube([Clong_wire, Cwire_height, THeight]);
            translate([0, wall_width + Cwire_height, 0]) {
                cube([Clong_wire*2/3 - wall_width, Cwire_height, THeight]);
            }
            translate([Clong_wire + wall_width, 0, 0]) {
                cube([Clength - Clong_wire - wall_width, Cwire_height * 2 + wall_width, THeight]);
            }
            translate([Clong_wire*2/3, wall_width + Cwire_height, 0]) {
                cube([Clong_wire*1/3, Cwire_height, THeight]);
            }
            translate([0, wall_width + Cwire_height*2 + wall_width, 0]) {
                cube([Clength/2 - wall_width/2, Cwire_height, THeight]);
            }
            translate([Clength/2 + wall_width/2, wall_width + Cwire_height*2 + wall_width, 0]) {
                cube([Clength/2 - wall_width/2, Cwire_height, THeight]);
            }
            translate([0, wall_width + Cwire_height*3 + wall_width*2, 0]) {
                cube([Clength, wire_height, THeight]);
            }
        }
        translate([wall_width, wall_width + Cdovetail_width + Cwidth, wall_width + Cheight]) { //top of jumperes
            cube([Clength, Cwidth + Cdovetail_width + wall_width, THeight]);
        }
        
        translate([Clength + wall_width*2, wall_width, wall_width]) { //batteries
            cube([Cbattery_length, C9V_Width, THeight]);
            translate([0, C9V_Width + wall_width, 0]) {
            cube([Cbattery_length, C9V_Width, THeight]);
            }
            translate([0, C9V_Width*2 + wall_width*2, 0]) {
            cube([Cbattery_length, CAA_diameter, THeight]);
            }
        }
        translate([Clength + wall_width, wall_width, wall_width + Cheight]) { //top of batteries
            cube([Cbattery_length + wall_width, C9V_Width*2 + wall_width*2 + CAA_diameter, THeight]);
        }
        
        translate([Clength + wall_width*2, C9V_Width*2 + wall_width*4 + CAA_diameter, wall_width]) { //misc parts
            cube([Cbattery_length, TWidth - (C9V_Width*2 + wall_width*5 + CAA_diameter), THeight]);
        }
    }
} else { //generate lid
    translate([-wall_width - clearence, -wall_width - clearence, THeight]) { //lid
                cube([TLength + wall_width*2 + clearence*2, TWidth + wall_width*2 + clearence*2, wall_width]);
    }
    translate([-wall_width - clearence, -wall_width - clearence, THeight - wall_width]) { //ledge
                cube([TLength + wall_width*2 + clearence*2, wall_width, wall_width]);
    }
    translate([-wall_width - clearence, -wall_width - clearence, THeight - wall_width]) { 
                cube([wall_width, TWidth + wall_width*2 + clearence*2, wall_width]);
    }
    translate([-wall_width - clearence, TWidth + clearence, THeight - wall_width]) { //ledge
                cube([TLength + wall_width*2 + clearence*2, wall_width, wall_width]);
    }
    translate([TLength + clearence, -wall_width - clearence, THeight - wall_width]) { 
                cube([wall_width, TWidth + wall_width*2 + clearence*2, wall_width]);
    }
    intersection() {
        union() {
            translate([wall_width + clearence, wall_width + clearence, wall_width + Cheight]) { //top of breadboard
                cube([Clength - clearence, Cwidth + Cdovetail_width - clearence, THeight]);
            }
            translate([wall_width + clearence, wall_width + Cdovetail_width + Cwidth, wall_width + Cheight]) { //top of jumperes
                cube([Clength - clearence, Cwidth + Cdovetail_width + wall_width, THeight]);
            }
            translate([Clength + wall_width, wall_width + clearence, wall_width + Cheight]) { //top of batteries
                cube([Cbattery_length + wall_width, C9V_Width*2 + wall_width*2 + CAA_diameter - clearence, THeight]);
            }
        }
        
        difference () { //cut away sections from main body
            cube([TLength, TWidth, THeight]); //main body
            
            if(front_dovetail == true) {
                translate([wall_width, wall_width + Cdovetail_width, wall_width]) { //breadboard
                    cube([Clength, Cwidth, THeight]); 
                    translate([Cdovetail_width*3, -Cdovetail_width, 0]) { //dovetail cutoff
                        cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                    }
                    translate([Clength/2-Cdovetail_width*5, -Cdovetail_width, 0]) {
                        cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                    }
                    translate([Clength-Cdovetail_width*3-Cdovetail_width*10, -Cdovetail_width, 0]) {
                        cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                    }
                }
            } else {
                translate([wall_width, wall_width, wall_width]) { //breadboard
                    cube([Clength, Cwidth, THeight]); 
                    translate([Cdovetail_width*3, Cwidth, 0]) { //dovetail cutoff
                        cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                    }
                    translate([Clength/2-Cdovetail_width*5, Cwidth, 0]) {
                        cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                    }
                    translate([Clength-Cdovetail_width*3-Cdovetail_width*10, Cwidth, 0]) {
                        cube([Cdovetail_width*10, Cdovetail_width, THeight]);
                    }
                }
            }
            
            translate([wall_width, wall_width + Cdovetail_width + Cwidth + wall_width, wall_width]) { //jumper wire and other long compartments
                cube([Clong_wire, Cwire_height, THeight]);
                translate([0, wall_width + Cwire_height, 0]) {
                    cube([Clong_wire*2/3 - wall_width, Cwire_height, THeight]);
                }
                translate([Clong_wire + wall_width, 0, 0]) {
                    cube([Clength - Clong_wire - wall_width, Cwire_height * 2 + wall_width, THeight]);
                }
                translate([Clong_wire*2/3, wall_width + Cwire_height, 0]) {
                    cube([Clong_wire*1/3, Cwire_height, THeight]);
                }
                translate([0, wall_width + Cwire_height*2 + wall_width, 0]) {
                    cube([Clength/2 - wall_width/2, Cwire_height, THeight]);
                }
                translate([Clength/2 + wall_width/2, wall_width + Cwire_height*2 + wall_width, 0]) {
                    cube([Clength/2 - wall_width/2, Cwire_height, THeight]);
                }
                translate([0, wall_width + Cwire_height*3 + wall_width*2, 0]) {
                    cube([Clength, wire_height, THeight]);
                }
            }
            
            translate([Clength + wall_width*2, wall_width, wall_width]) { //batteries
                cube([Cbattery_length, C9V_Width, THeight]);
                translate([0, C9V_Width + wall_width, 0]) {
                cube([Cbattery_length, C9V_Width, THeight]);
                }
                translate([0, C9V_Width*2 + wall_width*2, 0]) {
                cube([Cbattery_length, CAA_diameter, THeight]);
                }
            }
            
            translate([Clength + wall_width*2, C9V_Width*2 + wall_width*4 + CAA_diameter, wall_width]) { //misc parts
                cube([Cbattery_length, TWidth - (C9V_Width*2 + wall_width*5 + CAA_diameter), THeight]);
            }
        }
    }
}