$fn=100;
e=.001;
e2=e*2;

scope_d = 50.4;
scope_ring_h=7;
scope_ring_w=1.2;
scope_distance = 15;

scope_outer_ring_d=8;

vesa_dist = 75;
vesa_margin = 8;
vesa_d = 2.;
vesa_plate_w = vesa_dist+vesa_margin*2;

vesa_hole_d=5.1;
vesa_hole_cutout=10;


brace_w=0.8;

base_h=1;

module at_scope()
{
	translate([0, scope_distance+scope_ring_w+scope_d/2, 0])
	children();
}

module at_vesa_holes()
{
	for (x=[-vesa_dist/2, vesa_dist/2])
	for (z=[vesa_margin, vesa_margin+vesa_dist])
	translate([x,0,z])
	rotate([-90,0,0])
	children();
}


module base_plate(h=10, d=0)
{
	hull()
	{
		at_scope() cylinder(h, r=scope_d/2+scope_outer_ring_d+d);

		translate([-vesa_plate_w/2-d,0,0])
			cube([vesa_plate_w+d*2, vesa_d, h]);
	}
}

module vesa_plate(d=0)
{
	translate([-vesa_plate_w/2,0,0])
		cube([vesa_plate_w, vesa_d, vesa_plate_w]);

}

module vesa_adapter()
{

difference()
{
	union()
	{
		at_scope() cylinder(scope_ring_h, r=scope_d/2+scope_ring_w);
		vesa_plate();
		base_plate(base_h);
		at_vesa_holes()
		hull(){
			cylinder(h=6, r1=vesa_hole_d/2+4, r2=vesa_hole_d/2+1);
			translate([0,5.5,vesa_d-e])
			cylinder(h=e, r1=2, r2=1);
		}

		intersection()
		{
			difference()
			{
				base_plate(vesa_plate_w);
difference()
{
				translate([0,0,-e])
				base_plate(vesa_plate_w+e2, d=-brace_w);
				union()
				{
					rotate([45,0,0])
					{
						for (x=[-25,0,25])
						translate([x,0,0])
						cube([.8,14,14], center=true);
						cube([100,7,7], center=true);
					}

					for (x=[-vesa_plate_w/2,vesa_plate_w/2])
					translate([x,0,0])
					rotate([0,0,45])
					cube([7,7,200], center=true);
				}
}
			}

				hull()
				{
					vesa_plate();
					at_scope()
					translate([0, scope_outer_ring_d+scope_d/2, 0])
					translate([-vesa_plate_w/2,0,0])
					cube([vesa_plate_w, vesa_d, e]);
				}
		}

	}

	at_scope()
	translate([0,0,-e])
		cylinder(scope_ring_h+e2, r=scope_d/2);

	at_vesa_holes()
	translate([0,0,-e])
	cylinder(h=vesa_hole_cutout+e2, r=vesa_hole_d/2);
}

}

vesa_adapter();

