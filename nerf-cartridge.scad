include <./MCAD/3d_triangle.scad>
height = 85;
//width = 24.5;
width = 18;
depth = 81.5;
//cylinder_diam = 25;
cylinder_diam = 22;
side_depth = 12.50;
side_width = 21.50;
side_width_end = 18.50;
shelldepth = 1.5;
shellwidth = 1.5;

module body() {



//translate(v = [height-75,-shelldepth,0] )clip_stop(2,width,depth);
  difference() {
        difference() {
            cube(size = [height,width,depth] );
            translate( v=[shellwidth,shellwidth,shelldepth] ) {
                cube( size = [height+2,width-shellwidth*2,depth-shelldepth*2] );
            }
        }
        translate(v = [height-52,-shelldepth,-1] ) {
            cube( size = [5,width+2*shellwidth,3] );

        }
        
    }

   
}

module clip_stop(x,y,z){
difference(){
cube( size = [x,y+4,z+4] );
translate( v=[shellwidth,shellwidth+1,shelldepth] ) {
                cube( size = [height,width+shellwidth-1,depth-shelldepth] );
            }

}
}

module clip_sides(){
translate (v = [0,0,0])rotate(a=90, v=[0,90,0])rotate(a=180, v=[0,0,90])3dtri_draw([0,0,0],[side_depth,0,0],[side_depth,side_width-side_width_end-shellwidth,0],height);

translate (v = [0,width ,0])rotate(a=90, v=[0,90,0])3dtri_draw([0,0,0],[-side_depth,0,0],[-side_depth,side_width-side_width_end-shellwidth,0],height);

translate (v = [0,0.0001,depth])rotate(a=90, v=[0,90,0])rotate(a=180, v=[0,0,90])3dtri_draw([0,0,0],[-side_depth,0,0],[-side_depth,side_width-side_width_end-shellwidth,0],height);

translate (v = [0,width ,depth])rotate(a=90, v=[0,90,0])3dtri_draw([0,0,0],[side_depth,0,0],[side_depth,side_width-side_width_end-shellwidth,0],height);

}



module bullet_cylinder() {
    difference() {
        translate( v = [height+cylinder_diam/2-9,(width/2),0]) {
            cylinder_hold();
        }
        translate( v = [height+cylinder_diam/2-9,width/2,0]) {
            cylinder_nullspace();
        }
        translate(v= [height-cylinder_diam,(width-11.2)/2,0]) {
            cube(size=[60 ,11.2 , depth ]);
		}

translate(v= [height-cylinder_diam,0,0]) {
            cube(size=[cylinder_diam,width , depth ]);
		}
    }
}

module cylinder_nullspace() {
    cylinder( r = (cylinder_diam/2)-(shellwidth), h = depth, $fs=0.5 );
}

module cylinder_hold() {
    translate( v= [0,0,depth/4]) {
        cylinder( r = (cylinder_diam/2), h = depth/2, $fs=0.5 );
    }
}

module left(){
difference() {
    union() {
        body();
        clip_sides();
        bullet_cylinder();
    }
translate([0,width/2,-100])cube(size=[1000,1000,1000]);
}
}

module right(){
translate([0,50,0])difference() {
    union() {
        body();
        clip_sides();
        bullet_cylinder();
    }
//translate([0,-width/2,-100])cube(size=[1000,width,1000]);
}
}

right();
//left();