$fn=48;
e=.001;
b=1000;

w=12.5;
d=20;
h=10;
h_ring=12;
r=32.5/2;
slit=4.5;
width=1.5;
bolt=3;
inner_ring=r-29/2;
h_inner_ring=2.5;
nut=5.7;
nut_height=1.5;

module ring()
{
difference()
{
cylinder(h_ring,r+width,r+width);
translate([0,0,-e])cylinder(h_ring+e*2,r,r);
}

translate([0,0,(h_ring-h_inner_ring)/2])
difference()
{
cylinder(h_inner_ring,r,r+width);
translate([0,0,-e])cylinder(h_inner_ring+e*2,r-inner_ring,r-inner_ring);
}

}

module snap_ring()
{
    difference()
    {ring();

translate([0,0,-e/2])
rotate([0,0,180])
linear_extrude(h_ring+e)
{
    polygon([ [0,0],
    
    [ (r+width+e)/tan(180/10), (r+width+e)],
    [-(r+width+e)/tan(180/10), (r+width+e)]
    ]);
}        
    }
}

module balls()
{
    for (i=[-108, 108])
        rotate([0,0,i])
    translate([0,r-inner_ring/2,h_ring/2])
    sphere(2);
}

snap_ring();
balls();

difference()
{
translate([-w/2,r,0])cube([w, d, h]);
union()
    {
translate([0,r+6,-e])cylinder(h+2*e, slit/2, slit/2);
translate([-slit/2,r+6,-e])cube([slit, d, h+2*e]);



translate([0,r+d-5,h/2])rotate([0,90,0])translate([0,0,(-w-e)/2])
        {cylinder(w+e, bolt/2, bolt/2);
cylinder(nut_height+e, nut/sqrt(3), nut/sqrt(3), $fn=6);
        }
        
    }
}

