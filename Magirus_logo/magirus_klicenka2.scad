 $fn = 20; 
// modul amdg_chamfered_logo nahackovan z:
//(c)2018-01-06 Alex Gibson: admg chamfered_logo text module
//Licence: Creative Commons [CC BY-SA 4.0]  https://creativecommons.org/licenses/by-sa/4.0/

module logo () {
	difference () {
	union () {
		translate ([1, 0.5, 0]) offset (delta = 0.5) { resize ([0,50,0],auto=true) import ("magirus.dxf"); }
		translate ([19,35,0]) circle (3);
		}
	translate ([19,35,0])  circle (1);
	}
}


module admg_chamfered_logo (text_depth,chamfer_depth,chamfer_width) {
	translate ([0,0,text_depth-chamfer_depth]) difference() {
		translate ([0,0,-(text_depth-chamfer_depth)]) linear_extrude (text_depth) logo () ;
		minkowski () {
			difference () {
				cube ([500,500,text_depth],center=true);
				translate ([0,0,-text_depth]) linear_extrude (text_depth*2) logo () ;
			}
			translate ([0,0,text_depth/2]) cylinder (chamfer_depth,0,chamfer_width);
		}
	}
}


module final () {
	admg_chamfered_logo(2,0.5,0.5);
	mirror ([0,0,1]) admg_chamfered_logo(2,0.5,0.5);
}

//translate ([0, 0, 0]) logo ();
rotate ([90,0,0]) final ();
