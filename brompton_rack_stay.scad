e=.001;

d = 225;

hole_d=4;

r=9;
border=2;

thickness=8;

module at_holes()
{
	children();
	translate([d,0,0])
	children();
}


module stay()
{
	difference()
	{
		hull()
		at_holes()
		cylinder(h=thickness, r=r);

		at_holes()
		translate([0,0,border])
		cylinder(h=thickness, r=r-border);

		hull()
		at_holes()
		translate([0,0,r])
		sphere(r=thickness-border);

		at_holes()
		translate([0,0,-e])
		cylinder(h=thickness+e*2, d=hole_d, $fn=20);
}
}

stay();

