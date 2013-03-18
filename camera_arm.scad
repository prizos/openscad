//nuts etc
/*
 *  OpenSCAD Metric Fastners Library (www.openscad.org)
 *  Copyright (C) 2010-2011  Giles Bathgate
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 3 of the License,
 *  LGPL version 2.1, or (at your option) any later version of the GPL.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
*/

$fn=50;
apply_chamfer=true;

module cap_bolt(dia,len)
{
	e=1.5*dia;
	h1=1.25*dia;
	cylinder(r=dia/2,h=len);
	translate([0,0,-h1]) cylinder(r=e/2,h=h1);
}

module csk_bolt(dia,len)
{
	h1=0.6*dia;
	h2=len-h1;
	cylinder(r=dia/2,h=h2);
	cylinder(r1=dia,r2=dia/2,h=h1);
}

module washer(dia)
{
	t=0.1*dia;
	difference()
	{
		cylinder(r=dia,h=t);
		translate([0,0,-t/2])cylinder(r=dia/2,h=t*2);
	}
}

module flat_nut(dia)
{
	m=0.8*dia;
	e=1.8*dia;
	c=0.2*dia;
	difference()
	{
		cylinder(r=e/2,h=m,$fn=6);
		translate([0,0,-m/2])cylinder(r=dia/2,h=m*2);
		if(apply_chamfer)
		    translate([0,0,c])cylinder_chamfer(e/2,c);
	}
}

module bolt(dia,len)
{
	e=1.8*dia;
	k=0.7*dia;
	c=0.2*dia;
	difference()
	{
		cylinder(r=e/2,h=k,$fn=6);
		if(apply_chamfer)
		    translate([0,0,c])cylinder_chamfer(e/2,c);
	}

	cylinder(r=dia/2,h=len);

}

module cylinder_chamfer(r1,r2)
{
	t=r1-r2;
	p=r2*2;
	rotate_extrude()
	difference()
	{
		translate([t,-p])square([p,p]);
		translate([t,0])circle(r2);
	}
}

module chamfer(len,r)
{
	p=r*2;
	linear_extrude(height=len)
	difference()
	{
		square([p,p]);
		circle(r);
	}
}

union()
{
//csk_bolt(3,14);
//washer(3);
//flat_nut(3);
//bolt(4,14);
//cylinder_chamfer(8,1);
//chamfer(10,2);
}


//nuts etc


//Camera mount
include <./Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>

module base_plate(){
difference(){
union(){
cube([80,25,75]);
translate([80/2,25/2,0]){cylinder(h = 5, r=28, $fs=1);}

translate([-3,25/2,80-16/2]){rotate([90,0,90]){#cylinder(h = 8, r=16, $fs=1);}}
translate([80-5,25/2,80-16/2]){rotate([90,0,90]){#cylinder(h = 8, r=16, $fs=1);}}
}
translate([5,0,5])cube([70,25,75]);

//holes for side bearings
translate([0-3,25/2,80-16/2]){rotate([90,0,90]){#cylinder(h = 7, r=22.4/2, $fs=1);}}
translate([80-4,25/2,80-16/2]){rotate([90,0,90]){#cylinder(h = 7, r=22.4/2, $fs=1);}}

//holes for bolts on side bearings
translate([0-6,25/2,80-16/2]){rotate([90,0,90]){#cylinder(h = 12, r=8.4/2, $fs=1);}}
translate([80-6,25/2,80-16/2]){rotate([90,0,90]){#cylinder(h = 12, r=8.4/2, $fs=1);}}


//bottom strengthening plate
translate([80/2,25/2,-14]){cylinder(h = 20, r=8/2, $fs=1);}

//connecting holes to gear
#translate([(80/2)-15,25/2,-14]){cylinder(h = 20, r=2, $fs=1);}
#translate([(80/2)+15,25/2,-14]){cylinder(h = 20, r=2, $fs=1);}
}
}

module gear_module(){
difference(){
translate([80/2,25/2,-9]){pulley ( "T5" , T5_pulley_dia , 1.19 , 3.264 );}
#translate([(80/2)-15,25/2,-14]){cylinder(h = 20, r=2, $fs=1);}
#translate([(80/2)+15,25/2,-14]){cylinder(h = 20, r=2, $fs=1);}
}
}

module bottom_plate(){
difference(){
union(){
translate([80/2,25/2,-25]){cylinder(h = 12, r=22, $fs=1);}
translate([80/2,-20,-25]){rotate([0,0,30]){cube([90,55,10]);}}
}
translate([80/2,25/2,-20]){cylinder(h = 7, r=22.4/2, $fs=1);}
translate([80/2,25/2,-30]){#cylinder(h = 20, r=8.4/2, $fs=1);}
translate([58,29,-46]){rotate([0,0,-15]){bottom_motor_house();}}

#translate([80/2,25/2,-25]){difference(){

union(){
rotate([0,0,80]){translate([-40,-58,-0]){cube([50,90,10]);}}
rotate([0,0,30]){translate([-40,-58,-0]){cube([50,90,10]);}}
}
cylinder(h = 12, r=22, $fs=1);
}
}

translate([54,52,-46]){rotate([0,0,-15]){#cube([60,50,40]);}}


translate([80/2,25/2,-25]){flat_nut(8);}
}
}

module bottom_motor_house(){
//difference(){ //renable for a true servo image
union(){
//translate([80/2,50,-45]){cube([40,20,36]);}
translate([32,20/2,0]){#cylinder(h = 36+6, r=8.4/2, $fs=1);}
#cube([42,20,36]);
translate([42,(20/2)-6.25/2,0]){#cube([5,6.25,40]);}
translate([(42-55)/2,0,29]){#cube([55,20,2.35]);}
}
#hull(){
   translate([((42-55)/2)+2.2+1.5, 1.6+2.2, 15]) cylinder(h = 20, r=2.2, $fs=1);
   translate([((42-55)/2)+2.2+1.5, 5+2.2, 15])cylinder(h = 20, r=2.2, $fs=1);
   }
   
#hull(){
   translate([((42-55)/2)+2.2+1.5, 1.6+2.2+20/2, 15]) cylinder(h = 20, r=2.2, $fs=1);
   translate([((42-55)/2)+2.2+1.5, 5+2.2+20/2, 15])cylinder(h = 20, r=2.2, $fs=1);
   }
   
#hull(){
   translate([((42-55)/2)-2.2-1.5+55, 1.6+2.2, 15]) cylinder(h = 20, r=2.2, $fs=1);
   translate([((42-55)/2)-2.2-1.5+55, 5+2.2, 15])cylinder(h = 20, r=2.2, $fs=1);
   }
   
#hull(){
   translate([((42-55)/2)-2.2-1.5+55, 1.6+2.2+20/2, 15]) cylinder(h = 20, r=2.2, $fs=1);
   translate([((42-55)/2)-2.2-1.5+55, 5+2.2+20/2, 15])cylinder(h = 20, r=2.2, $fs=1);
   }

//} //re-enable for a true servo image
}



//base_plate();
//gear_module();
//translate([55,30,-45]){rotate([0,0,-10]){
//bottom_motor_house();
bottom_plate();