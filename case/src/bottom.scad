$fa = 10;
$fs = 0.5;

module rounded_cube(size, radius) {
    width = size[0];
    height = size[1];
    depth = size[2];

    minkowski() {
        cube([width - 2 * radius, height - 2 * radius, depth - 2 * radius], center=true);
        sphere(radius);
    }
}

module case_top(size, radius, thickness) {
    width = size[0];
    height = size[1];
    depth = size[2];
    
    difference() {
        translate([0, 0, radius / 2]) {
            // make depth bigger ...
            rounded_cube([width, height, depth + radius], radius);
        }
        // ...and cut rounded parts at bottom
        translate([0, 0, depth / 2 + radius / 2]) {
            cube([width, height, radius], center=true);
        }
        translate([0, 0, depth / 2 - 1]) {
            // create notch at the bottom
            cube([width - thickness, height - thickness, 2], center=true);
        }
        translate([0, 0, thickness]) {
            // make case hollow
            cube([width - thickness * 2, height - thickness * 2, depth], center=true);
        }
    }
}

module pcb_column(height, innerHeight, outer, inner) {
    union() {
        translate([0, 0, 0]) {
            cylinder(h=height, r=outer, center=true);
            translate([0, 0, (innerHeight - height) / 2]) cylinder(h=innerHeight, r=inner, center=true);
        }
    }
}

module pcb_column(height, innerHeight, outer, inner) {
    union() {
        translate([0, 0, 0]) {
            cylinder(h=height, r=outer);
            translate([0, 0, height]) cylinder(h=innerHeight - height, r=inner);
        }
    }
}

module pcb_columns() {
    translate([-28.6, 25.4, 0]) pcb_column(5, 10, 2.5, 1.25);
    translate([28.6, 25.4, 0]) pcb_column(5, 10, 2.5, 1.25);
    translate([-28.6, -25.4, 0]) pcb_column(5, 10, 2.5, 1.25);
    translate([28.6, -25.4, 0]) pcb_column(5, 10, 2.5, 1.25);
}

module case_column(height, outer, inner) {
    difference() {
        cylinder(h=height, r=outer);
        cylinder(h=height, r=inner);
    }
}

module case_columns() {
    translate([-36, 27, 0]) case_column(23, 3, 1.5);
    translate([36, -27, 0]) case_column(23, 3, 1.5);
}

module screw_holes() {
    translate([35, 0, 0]) cylinder(h=2, r=1.6, center=true);
    translate([-35, 0, 0]) cylinder(h=2, r=1.6, center=true);
}
module main() {
    union() {
        difference() {
            translate([0, 0, 0]) cube([80, 62, 2], center=true);
            screw_holes();
        }
        translate([0, 0, 1]) pcb_columns();
        translate([0, 0, 1]) case_columns();        
    }
}

main();