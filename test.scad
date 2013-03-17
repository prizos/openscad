include <./MCAD/3d_triangle.scad>
height = 75;
//width = 24.5;
width = 19;
depth = 81.5;
cylinder_diam = 24.5;
side_depth = 12.50;
side_width = 21.5;
side_width_end = 18;
shelldepth = 2;
shellwidth = 2;

translate (v = [0,width ,depth])rotate(a=90, v=[0,90,0])3dtri_draw([0,0,0],[side_depth,0,0],[side_depth,side_width-side_width_end,0],height);