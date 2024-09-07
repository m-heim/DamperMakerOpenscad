include <BOSL2-master/std.scad>

$fn=91;

// piston
piston_height = 8; // height for piston
piston_diameter = 8.4; // diameter for piston
piston_hole_diameter = 4.3; // diameter for mounting axis
piston_hole_height = 4.5; // height for mounting axis
piston_torus_diameter = 8.4; // torus diameter
piston_torus_thickness = 1.7; // torus thickness
piston_torus_positions = [2, 6]; // set positions
piston_air_hole_diameter = 1.1;
piston_air_hole_offset = 2.45;

// settings for spring indents
spring_outer_diameter = 10;
spring_inner_diameter = 7;
spring_holder_indent = 1.5;

// general settings for tube
tube_inner_diameter = 10;
tube_outer_diameter = 12;


// settings for mount
mount_width=10;
mount_depth=6;
mount_height=7;
// hole for mounting
mount_hole_diameter = 4.7;
// hole for axis
mount_axis_hole_diameter = 4.3;
mount_axis_hole_height = 4;


// settings for both seals
seal_outer_height = 2;
seal_inner_height = 6;
seal_inner_diameter = 9;
seal_torus_diameter = 9;
seal_torus_thickness = 2;


// bottom seal axis diameter and torus
seal_axis_diameter = 4.3;
seal_axis_torus_diameter = 4.3;
seal_axis_torus_thickness = 1;
seal_axis_torus_positions = [2, 6];

module topMount() {
    difference() {
        union() {
            cylinder(h=seal_outer_height, r=tube_outer_diameter/2);
            translate([0, 0, seal_outer_height])
            cylinder(h=seal_inner_height, r=seal_inner_diameter/2);
            translate([-mount_width/2, -mount_depth/2, -mount_height])
            cube([mount_width,mount_depth, mount_height]);
            translate([0, mount_depth/2, -mount_height])
            rotate([90, 0, 0])
            cylinder(h=mount_depth, r=mount_width/2);
        }
        translate([0, mount_depth/2, -mount_height])
        rotate([90, 0, 0])
        cylinder(h=mount_depth, r=mount_hole_diameter/2);
        translate([0, 0, seal_outer_height + seal_inner_height/2])
        torus(r_maj=seal_torus_diameter/2, r_min=seal_torus_thickness/2);
    }
}

module piston() {
    difference() {
        cylinder(h=piston_height, r=piston_diameter/2);
        cylinder(h=piston_hole_height, r=piston_hole_diameter/2);
        for (p = piston_torus_positions) {
            translate([0, 0, p])
            torus(r_maj=piston_torus_diameter/2, r_min=piston_torus_thickness/2);
        }
        difference() {
            pie_slice(h=piston_height, r=piston_air_hole_diameter/2 + piston_air_hole_offset, ang=17);
            cylinder(h=piston_height, r=piston_air_hole_offset);
        }
    }
}

module bottomSeal() {
    difference() {
        union() {
            cylinder(h=seal_outer_height, r=tube_outer_diameter/2);
            translate([0, 0, seal_outer_height])
            cylinder(h=seal_inner_height, r=seal_inner_diameter/2);
        }
        translate([0, mount_depth/2, -mount_height])
        rotate([90, 0, 0])
        cylinder(h=mount_depth, r=mount_hole_diameter/2);
        translate([0, 0, seal_outer_height + seal_inner_height/2])
        torus(r_maj=seal_torus_diameter/2, r_min=seal_torus_thickness/2);
        cylinder(h=seal_outer_height + seal_inner_height, r=seal_axis_diameter/2);
        for (p = seal_axis_torus_positions) {
            translate([0, 0, p])
            torus(r_maj=seal_axis_torus_diameter/2, r_min=seal_axis_torus_thickness/2);
        }
        difference() {
            cylinder(h=spring_holder_indent, r=spring_outer_diameter/2);
            cylinder(h=spring_holder_indent, r=spring_inner_diameter/2);
        }
    }
}

module bottomMount() {
    difference() {
        union() {
            cylinder(h=mount_axis_hole_height, r=tube_outer_diameter/2);
            translate([-mount_width/2, -mount_depth/2, -mount_height])
            cube([mount_width,mount_depth, mount_height]);
            translate([0, mount_depth/2, -mount_height])
            rotate([90, 0, 0])
            cylinder(h=mount_depth, r=mount_width/2);
        }
        translate([0, 0, mount_axis_hole_height - spring_holder_indent])
        difference() {
            cylinder(h=spring_holder_indent, r=spring_outer_diameter/2);
            cylinder(h=spring_holder_indent, r=spring_inner_diameter/2);
        }
        translate([0, mount_depth/2, -mount_height])
        rotate([90, 0, 0])
        cylinder(h=mount_depth, r=mount_hole_diameter/2);
        cylinder(h=mount_axis_hole_height, r=mount_axis_hole_diameter/2);
    }
    
}

piston();
//bottomMount();
//topMount();
//bottomSeal();