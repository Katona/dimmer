$fa = 10;
$fs = 0.5;

module case_top(size, radius, thickness) {
    width = size[0];
    height = size[1];
    depth = size[2];
    
    difference() {
        cube([width, height, depth], center=true);

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

module pcb_column(height, outer, inner) {
    difference() {
        cylinder(h=height, r=outer);
        cylinder(h=height, r=inner);
    }
}

module pcb_columns() {
    translate([-28.6, 25.4, 0]) pcb_column(19, 2.5, 1.3);
    translate([28.6, 25.4, 0]) pcb_column(19, 2.5, 1.3);
    translate([-28.6, -25.4, 0]) pcb_column(19, 2.5, 1.3);
    translate([28.6, -25.4, 0]) pcb_column(19, 2.5, 1.3);
}

module case_pin(height, r) {
    difference() {
        cylinder(h=height, r=r);
        translate([0, 0, height - 5 / 2]) cube([10, 0.5, 5], center=true);
    }
}

module case_pins() {
    translate([-36, 27, 0]) case_pin(10, 1.5);
    translate([36, -27, 0]) case_pin(10, 1.5);
}

module main() {
    union() {
        case_top([84, 66, 30], 3, 2);
        translate([0, 0, -13]) {
            case_pins();
            pcb_columns();
        }
        
    }
}

main();