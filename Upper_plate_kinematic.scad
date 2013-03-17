include <./MCAD/nuts_and_bolts.scad>

module upper_plate()
{
translate(){
cube([40,40,8],true);
}
}

module half_ball(x){
difference() {
  // A ball with a 5mm radius
  # sphere(r=x, $fn=100); 
  // push 5mm downwards
  translate(v=[0,0,-x]) {
    //The cube for cutting 
    # cube(size = x*2, center = true);
   }
}
}

module combined_plate(){
difference(){
upper_plate();
translate([15,15,5])sphere(r=4, $fn=100);
translate([15,15,-5])cylinder(h = 4.5, r=3.3);
//ball hole
translate([15,15,-5])boltHole(size=4.1,length=30);
//translate([15,15,1])nutHole(4);
//two corner holes
translate([-15,15,1])nutHole(4.1);
translate([15,-15,1])nutHole(4.1);
//m4 holes
translate([-15,15,-5])boltHole(size=4.1,length=10);
translate([15,-15,-5])boltHole(size=4.1,length=10);
}
}

module cut_plate(){
difference(){
combined_plate();
translate([-10,-10,0])cube([40,40,10],true);
}
}

cut_plate();