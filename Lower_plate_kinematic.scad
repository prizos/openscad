include <./MCAD/regular_shapes.scad>
include <./MCAD/nuts_and_bolts.scad>


module lower_plate()
{
difference(){
cube([40,40,6],true);
//translate([15,15,3.5])rotate(a=[0,180,0])square_pyramid(9, 9, 4);
}
//translate([15,15,-3])cube([10,10,4],true);
}

difference(){
lower_plate();

translate([-15,-15,2])sphere(r=3, $fn=100);
translate([-15,15,2])sphere(r=3, $fn=100);
translate([15,-15,2])sphere(r=3, $fn=100);

translate([-15,-15,-5])cylinder(h = 4.5, r=3.3);
translate([-15,15,-5])cylinder(h = 4.5, r=3.3);
translate([15,-15,-5])cylinder(h = 4.5, r=3.3);

translate([15,15,-4])cylinder(h = 4.5, r=3.3);

translate([15,15,4])sphere(r=4, $fn=100);

translate([-10,-16,-6])boltHole(size=3,length=10);
translate([-10,16,-6])boltHole(size=3,length=10);
translate([10,-16,-6])boltHole(size=3,length=10);

}