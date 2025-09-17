$fn=50;
e=.001;
big=999;
dim = [25,35,6];
border_r = 3;
pitch = 5;
n_cables=4;

cable_d=1.5;
screw_d=3.2;
screw_head=5.9;
screw_head_border = 1.2;
screw_head_depth=1;

n_screws_per_side = ceil(n_cables/2);

module do_center(dim, center)
{
	if (center)
		translate(-dim/2)
			children();
	else
		children();
}

module rounded_box(dim, r, center=false)
{
	dim_inner = dim-[2*r, 2*r, 0];
	do_center(dim_inner, center)
	hull()
	{
		for (x=[0,dim_inner.x])
		for (y=[0,dim_inner.y])
		translate([x,y,0])
        cylinder(h=dim_inner.z,r=r);
	}
}

module cables()
{
for (dx=[-7.5, -2.5, 2.5, 7.5])
translate([dx, 0,0])
rotate([90,0,0])
cylinder(dim.y+2*e, d=cable_d, center=true);
}


module at_screws()
{
for (x=[-5,5])
for (y=[-15,15])
translate([x,y,0])
children();
}

module block()
{
	difference()
	{
		rounded_box(dim, r=3, center=true);

		difference()
{
		union()
		{
for (dx=[-7.5, -2.5, 2.5, 7.5])
translate([dx, 0,0])
			cube([4.2,25,4.8], center=true);
			cables();
		}
at_screws()
translate([0,0,-3-e])
cylinder(h=e+2,d=(screw_head+screw_head_border)*2/sqrt(3),$fn=6);

}
at_screws()
translate([0,0,-5])
cylinder(h=10,d=screw_d);

at_screws()
translate([0,0,-3-e])
cylinder(h=e+screw_head_depth,d=screw_head*2/sqrt(3),$fn=6);
	}
}

module split()
{
	union()
	{
		translate([-big/2, -big/2,0])
		cube([big,big,big]);
		difference()
		{
			cube([21,26,2], center=true);
cube([18,37,3], center=true);
			
		}
	}
}

translate([27,0,0])
rotate([180,0,0])
intersection()
{
	block();
	split();
}


difference()
{
	block();
	split();
}

