e=.001;

include <lib/utils.scad>

bin_d = 290;
bin_center=[0,bin_d/2+15,0];

hole_d=4;
leg_margin=.2;
leg_h=4;

pedal_h=15;

dx=60;
dy=23;

r=7;
margin=.8;
border=2.4;

w=90;
d=50;

thickness=8;

module binshape()
{
	translate(bin_center)
	translate([0,0,-100])
	cylinder(200,d=bin_d,$fn=200);
}

module at_holes()
{
	for (x=[-dx/2,dx/2])
	for (y=[-dy/2,dy/2])
	translate([x,y,0])
	children();
}


module pedal_shape()
{
	difference()
	{
		translate([0,0,-1])
		rounded_block_z([w+2*(margin+border),d+2*(margin+border),pedal_h], [0,0,-1], r+margin+border);

		rounded_block_z([w+2*margin,d+2*margin,pedal_h], [0,0,-1], r+margin);
	}
	at_holes()
	{
	cylinder(h=leg_h,r=hole_d/2-leg_margin,$fn=50);
	cylinder(h=1,r1=5,r2=hole_d/2-leg_margin,$fn=50);
	}
}

module pedal()
{
	difference()
	{
		pedal_shape();
		binshape();
		translate([0,0,10])
		rotate([12,0,0])
		block([100,100,20],[0,0,-1]);

		translate([0,22,0])
		rotate([45,0,0,])
		block([100,100,100],[0,-1,0]);
	}
}

pedal();
