e=.001;
m=.3;
$fn=20;

include <lib/utils.scad>;

pitch = .95;

pogo_h_normal = 16;
pogo_h_min = pogo_h_normal - 2;
pogo_d = .65;

pogo_dy = 1.5;

package_dim = [ 2.9+m, 1.6+m, 1.25 ] ;

module package()
{
//	color("#202020")
	block(package_dim, [0,0,-1]);
}

module at_pins(ax=0,ay=0)
{
	for (x=[-1,0,1])
	for (y=[-pogo_dy,pogo_dy])
	translate([x*pitch,y,0])
	rotate([-y*ax,0,0])
	rotate([0,x*ay,0])
	children();
}

module pogopin(m=0)
{
	color("#ffff70")
	translate([0,0,pogo_h_min-pogo_h_normal])
	cylinder(h=pogo_h_normal, d=pogo_d+2*m);
}

module cutouts()
{
	package();

	at_pins(-.5,6)
	pogopin(m=m);
}


module shape()
{
	difference()
	{
		union()
		{
			translate([0,0,.8])
			chamfer_block_z([8,6,12.2],[0,0,-1],1);
			translate([-package_dim.x/2,0,0])
			chamfer_block_z([1.2,3,1],[1,0,-1],.3);
			translate([package_dim.x/2,0,0])
			chamfer_block_z([1.2,3,1],[-1,0,-1],.3);
		}

		cutouts();
	}
}

translate([0,0,13])
rotate([180,0,0])
shape();

preview()
{
	translate([0,10,0])
	{
		#shape();

		at_pins(-.5,6)
		pogopin();
	}


translate([0,10,13])
color("green")
difference()
{
block([10,10,1],[0,0,-1]);
for (x=[-2.54,0,2.54])
for (y=[-1.27,1.27])
translate([x,y,-e])
cylinder(h=1+2*e,d=1);
}
}


