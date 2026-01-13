linear_extrude(2.5)
{
$fn=20;
hull(){
 translate([5,20-5])circle(5);  
 translate([95-5,20-5])circle(5);  

 translate([1,1])circle(1);  
 translate([95-1,1])circle(1);  
}

}