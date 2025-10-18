
$fn=50;
e=.001;
pad=5;

rim=22;
rim_h=1.6;
outer=18.6;
inner=17.;
h=7;


module bushing()
{
	difference()
	{
		union()
		{
			cylinder(h=rim_h, d=rim);
			translate([0,0,e])
			cylinder(h=h-e, d=outer);
		}
		translate([0,0,-e])
		cylinder(h=h+2*e, d=inner);
	}
}

module print_grid(n_x, n_y, pitch_x, pitch_y)
{
	for (x=[0:n_x-1])
	for (y=[0:n_y-1])
	translate([x*pitch_x, y*pitch_y,0])
	children();
}

print_grid(2,2,pad+rim, pad+rim) bushing();
