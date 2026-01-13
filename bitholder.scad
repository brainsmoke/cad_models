
e=.001;
d = 3.8+0.4;
b = 1.2;
l= 30;
base_height = .8;
base_edge=2.4;

n_bits = 4;
pitch = 10;
corner = 3;
base_w = pitch*n_bits;
base_d = l;

module hexbar(d, l)
{
	rotate([-90,30,0])
	cylinder(h=l, r=d/sqrt(3), $fn=6);
}


module clamp(d, l)
{
	intersection()
	{
		union()
		{
			translate([0,-e,(d+2*b)/sqrt(3)])
			hexbar(d+b*2, l+2*e);
			translate([-(d+b*2)/2,-e,-e])
			cube([d+b*2, l+2*e, (d+b*2)/2+e]);
		}
		translate([-(d+b*2)/2-e-sqrt(2)*b/2,0,0])
		{
			cube([d+b*2+2*e+sqrt(2)*b, l, (d+b*2)]);
		}
	}

for (x=[1, -1])
translate([x*(d+b*2)/2,l/2, base_edge])
rotate([0, 45,0])
cube([sqrt(2)*b,l, sqrt(2)*b], center=true); 
}

module clamp_keepout(d, l)
{
	translate([0,-e,(d+2*b)/sqrt(3)])
	{
		hexbar(d, l+2*e);

		translate([0,0,(d+b/2)*.6])
		rotate([0,30,0])
		hexbar(d, l+2*e);
	}
}

difference()
{
	union()
	{
		for (i=[0:n_bits-1])
		translate([pitch*(i+.5), corner, 0])
		clamp(d, l-2*e-2*corner);
		linear_extrude(base_edge)
		hull()
		for (p = [ [corner,corner], [base_w-corner, corner],
		           [corner, base_d-corner], [base_w-corner, base_d-corner] ])
		translate(p)
		circle(corner, $fn=12);
	}
	union()
	{
		for (i=[0:n_bits-1])
		translate([pitch*(i+.5), corner, 0])
		clamp_keepout(d, l);

		for (yw=[ [.12, .07], [.425,.2], [.9+e,.4]])
		{
			y=l*yw[0]; w=l*yw[1];
			translate([0-e,y-w/2,1])
			cube([base_w+2*e, w, d+2*b]);
		}
		for (p = [ [pitch, l*.85,-e], [base_w-pitch, l*.85, -e] ])
		translate(p)
		cylinder(h=2+2*e, r2=6/2, r1=3.2/2);
	}
}