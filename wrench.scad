e=.001;
m=.2; /* extra margin for the fdm squish factor */
$fn=50;

include <lib/utils.scad>;

size_a = 14;
size_b = 15;

length = 190;

width=24;

border=2;

thickness=8;
carveout_r = 4;

text_size = 8;
text_height=1.2;
text_font="Atkinson Hyperlegible";

test_thickness=2;


hole_to_hole = length-width;

carveout_r_min = 0;
carveout_z = thickness-border;
carveout_y = width-border*2;

carveout_r_calc = min(carveout_r, carveout_z/2, carveout_y/2);

assert(carveout_r_calc >= carveout_r_min);

module at_holes()
{
	translate([-hole_to_hole/2,0,0])
	{
		$nut = size_a;
		children();
	}

	rotate([0,0,180])
	translate([-hole_to_hole/2,0,0])
	{
		$nut = size_b;
		children();
	}
}

module ring_cutout(nut_size)
{
	translate([0,0,-e])
	rotate([0,0,360/6/2])
	ngon_inner(6, thickness+e*2, r=nut_size/2+m/2);
}

module wrench()
{
	at_holes()
	translate([width/2+carveout_y/2,0,border-e])
	linear_extrude(text_height+e)
	text(str($nut), font=text_font, size=text_size, halign="center", valign="center");

	difference()
	{
		hull()
		at_holes()
		cylinder(h=thickness, d=width);

		at_holes()
		hull()
		{
			y_off = carveout_y/2-carveout_r_calc;


			for (x = [width/2+carveout_r_calc,hole_to_hole/2-carveout_r_calc-border/2 ])
			for (y = [-y_off, y_off ])
			for (z = [border+carveout_r_calc, thickness+carveout_r_calc])
			translate([x,y,z])
			sphere(r=carveout_r_calc, $fn=30);
		}

		at_holes()
		ring_cutout($nut);
	}
}

module hole_test()
{
	difference()
	{
		cylinder(h=test_thickness, d=width);
		ring_cutout(size_a);
	}
}

wrench();

