
use <vesascope.scad>

difference()
{
union()
{
	translate([-50,0,88])
	cube([100,25, 15]);
}
union()
{
hull()vesa_adapter();


translate([0,15,80])
hull()
{
translate([-56.5/2,(56.5-47)/2,0])
cube([56.5,47,30]);
translate([-47/2, 0,0])
cube([47,56.5,30]);
}
}
}
