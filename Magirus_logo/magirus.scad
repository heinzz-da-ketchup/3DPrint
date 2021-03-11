 $fn = 100; 
// modul amdg_chamfered nahackovan z:
//(c)2018-01-06 Alex Gibson: admg chamfered text module
//Licence: Creative Commons [CC BY-SA 4.0]  https://creativecommons.org/licenses/by-sa/4.0/
module admg_chamfered(text_depth,chamfer_depth,chamfer_width)
                {
                translate([0,0,text_depth-chamfer_depth])
                                difference()
                                                {
                                                translate([0,0,-(text_depth-chamfer_depth)])
                                                                linear_extrude(text_depth)
									resize ([0, 200, 0], auto = true) import ("magirus.dxf");
                                                minkowski()
                                                                {
                                                                difference()
                                                                                {
                                                                                cube([500,500,text_depth],center=true);
                                                                                translate([0,0,-text_depth])
                                                                                linear_extrude(text_depth*2)
											resize ([0, 200, 0], auto = true) import ("magirus.dxf");
                                                                                }
                                                                translate([0,0,text_depth/2])
                                                                                cylinder(chamfer_depth,0,chamfer_width);
                                                                }
                                                }
                }

color ("black") linear_extrude (1) offset (delta=1) resize ([0, 200, 0], auto = true) import ("magirus.dxf");
color ("green") translate ([0,0,1]) admg_chamfered(3,1.5,1.5);
