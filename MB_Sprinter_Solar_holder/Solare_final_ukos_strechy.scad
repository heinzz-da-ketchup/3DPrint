$fn = 40; 
include <MCAD/2Dshapes.scad>;

preview_maly ();
//preview ();
//strana ();
//predek ();
//zadek ();
//predni_roh_P ();
//predni_roh_L ();
//zadni_roh_P ();
//zadni_roh_L ();

module preview_maly () {
	translate ([0, 150, 0]) strana ();
	translate ([400, 250, 0]) rotate ([0, 0, 180]) strana ();
	translate ([400, 400, 0]) rotate ([0, 0, 180])   zadni_roh_P ();
	translate ([0,400, 0]) zadni_roh_L ();
	translate ([400, 0, 0]) predni_roh_P ();
	predni_roh_L(); 
	translate ([200, 0, 0]) predek ();
	translate ([200, 400, 0]) rotate ([0, 0, 180]) zadek ();
}
module preview () {
	translate ([960, 0, 0]) %vyrez_podlahy ();
	%vyrez_podlahy ();
	translate ([0,0,33]) solar ();
	translate ([0, 800, 0]) strana ();
	translate ([990, 900, 0]) rotate ([0, 0, 180]) strana ();
	translate ([990, 1650, 0]) rotate ([0, 0, 180])   zadni_roh_P ();
	translate ([0,1650, 0]) zadni_roh_L ();
	translate ([990, 0, 0]) predni_roh_P ();
	predni_roh_L(); 
	translate ([445, 0, 0]) predek ();
	translate ([445, 1650, 0]) rotate ([0, 0, 180]) zadek ();
}

module prism(l, w, h){						// Rutina k vytvoreni klinu
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module solar () {
	 %cube ([990, 1650, 40]);
}

module vyrez_podlahy () {
	translate ([0, 1720]) rotate ([90, 0, 0]) linear_extrude (1800) 
		difference () {
			hull () {
				square ([30, 10]);
				translate ([-7.5, -10]) square ([45, 10]);
			}
			translate ([-7.5, -12]) square ([45, 10]);
		}
}

module strana () {
	difference () {
		translate ([0, 0, -10]) minkowski () {
			rotate_extrude () ellipsePart (50, 166,2);
			cube ([200,  200, 10]);
		}
		translate ([0,0,-250]) cube (500, true);
		translate ([-50,-50,-10]) cube ([300, 50, 100]);
		translate ([50,-10,-10]) cube ([300, 300, 100]);
		translate ([0,-10,33]) cube ([60, 300, 40.2]);
		translate ([-100,100,-10]) cube (300);
		translate ([1,-50,64]) rotate ([0, 45, 0])  cube ([100, 200, 100]);
		translate ([0, 100, 33]) rotate ([0, 0, -90]) prism (100, 100, -4.28);

		translate ([0, -10, 73]) union () {
		 translate ([5,0,0]) cube (200);
		 mirror ([1,0,0]) rotate (90) prism (200, 10, 20);
		}
		translate ([0, 0, 1]) vyrez_podlahy ();
	}
}

module zadek () {
	difference () {
		translate ([-100, 0, 0]) 
			translate ([0,0,-10]) minkowski () {
				rotate_extrude () ellipsePart (50, 166,2);
				cube ([200,  200, 10]);
			}
		translate ([350, 0, 0]) cube (600, center=true);
		translate ([-350, 0, 0]) cube (600, center=true);
		translate ([0, 0, -300]) cube (600, center=true);
		translate ([0, 350, 0]) cube (600, center=true);
		translate ([-60,0,33]) cube ([120, 60, 40.2]);
		translate ([100, 0, 0]) rotate ([0, 0, 90]) translate ([0, -10, 73]) union () {
			translate ([5,0,0]) cube (200);
			mirror ([1,0,0]) rotate (90) prism (200, 10, 20);
		}
		translate ([-15, 0, 9]) vyrez_podlahy ();
		cube ([200, 200, 16], center=true);
		translate ([60, 1, 64]) rotate ([0, 45, 90])  cube ([100, 200, 100]);
	}
}

module predek () {
	difference () {
		translate ([-100, 0, 0]) 
			translate ([0,0,-10]) minkowski () {
				rotate_extrude () ellipsePart (120, 166,2);
				cube ([200,  200, 10]);
			}
		translate ([350, 0, 0]) cube (600, center=true);
		translate ([-350, 0, 0]) cube (600, center=true);
		translate ([0, 0, -300]) cube (600, center=true);
		translate ([0, 350, 0]) cube (600, center=true);
		translate ([-60,0,33]) cube ([120, 60, 40.2]);
		translate ([100, 0, 0]) rotate ([0, 0, 90]) translate ([0, -10, 73]) union () {
			translate ([5,0,0]) cube (200);
			mirror ([1,0,0]) rotate (90) prism (200, 10, 20);
		}
		translate ([-15, 0, 9]) vyrez_podlahy ();
		cube ([200, 200, 16], center=true);
		translate ([60, 1, 64]) rotate ([0, 45, 90])  cube ([100, 200, 100]);
	}
}

module predni_roh_P () {
	difference () {
		translate ([-200, 0, 0]) intersection () {
			translate ([0,-100,-10]) minkowski () {
				rotate_extrude () ellipsePart (50, 166,2);
				cube ([200,  200, 10]);
			}
			translate ([0,0,-10]) minkowski () {
				rotate_extrude () ellipsePart (120, 166,2);
				cube ([200,  200, 10]);
			}
		}
		translate ([0,0,-250]) cube (500, true);
		translate ([-350,50,-10]) cube ([300, 300, 100]);
		translate ([-300,0,33]) cube ([300, 300, 40.2]);
		translate ([-100,100,-10]) cube (200);
		rotate (90) translate ([-100,100,-10]) cube (200);
		translate ([-30, 0, 1]) vyrez_podlahy ();
		translate ([-1, 50, 64]) rotate ([0, -135, 0])  cube ([100, 100, 100]);
		translate ([-50,1,64]) rotate ([0, 45,90])  cube ([100, 100, 100]);
		translate ([0, 0, 33]) rotate ([0, 0, -270]) prism (100, 100, -4.28);
		rotate ([0, 0, 90]) translate ([30, 30, 33]) intersection () {
			translate ([0,0,0]) rotate ([0, 45, 0])  cube ([100, 100, 100]);
			translate ([100,0,0]) rotate ([0, 45,90])  cube ([100, 100, 100]);
		}
		rotate ([0, 0,  90]) intersection () {
			translate ([0, 0, 73]) union () {
			 translate ([5,0,0]) cube ([110, 110, 10]);
			 mirror ([1,0,0]) rotate (90) prism (110, 10, 20);
			}
			translate ([110, 0, 0]) rotate (90) translate ([0, 0, 73]) union () {
			 translate ([5,0,0]) cube ([110, 110, 10]);
			 mirror ([1,0,0]) rotate (90) prism (110, 10, 20);
			}
		}
	}
}
module predni_roh_L () {
	difference () {
		intersection () {
			translate ([0,-100,-10]) minkowski () {
				rotate_extrude () ellipsePart (50, 166,2);
				cube ([200,  200, 10]);
			}
			translate ([0,0,-10]) minkowski () {
				rotate_extrude () ellipsePart (120, 166,2);
				cube ([200,  200, 10]);
			}
		}
		translate ([0,0,-250]) cube (500, true);
		translate ([50,50,-10]) cube ([300, 300, 100]);
		translate ([0,0,33]) cube ([300, 300, 40.2]);
		translate ([-100,100,-10]) cube (200);
		rotate (-90) translate ([-100,100,-10]) cube (200);
		translate ([0, 0, 1]) vyrez_podlahy ();
		translate ([1,50,64]) rotate ([0, 45, 0])  cube ([100, 100, 100]);
		translate ([150,1,64]) rotate ([0, 45,90])  cube ([100, 100, 100]);
		translate ([30, 30, 33]) intersection () {
			translate ([0,0,0]) rotate ([0, 45, 0])  cube ([100, 100, 100]);
			translate ([100,0,0]) rotate ([0, 45,90])  cube ([100, 100, 100]);
		}
		intersection () {
			translate ([0, 0, 73]) union () {
			 translate ([5,0,0]) cube ([110, 110, 10]);
			 mirror ([1,0,0]) rotate (90) prism (110, 10, 20);
			}
			translate ([110, 0, 0]) rotate (90) translate ([0, 0, 73]) union () {
			 translate ([5,0,0]) cube ([110, 110, 10]);
			 mirror ([1,0,0]) rotate (90) prism (110, 10, 20);
			}
		}
		translate ([0, 100, 33]) rotate ([0, 0, -90]) prism (100, 100, -4.28);
		
	}
}

module  zadni_roh_L () {
	difference () {
		rotate ([0, 0, -90]) difference () {
			translate ([0,0,-10]) minkowski () {
				rotate_extrude () ellipsePart (50, 166,2);
				cube ([200,  200, 10]);
			}
			translate ([0,0,-250]) cube (500, true);
			translate ([50,50,-10]) cube ([300, 300, 100]);
			translate ([0,0,33]) cube ([300, 300, 40.2]);
			translate ([-100,100,-10]) cube (200);
			rotate (-90) translate ([-100,100,-10]) cube (200);

			translate ([1,50,64]) rotate ([0, 45, 0])  cube ([100, 100, 100]);
			translate ([150,1,64]) rotate ([0, 45,90])  cube ([100, 100, 100]);
			translate ([30, 30, 33]) intersection () {
				translate ([0,0,0]) rotate ([0, 45, 0])  cube ([100, 100, 100]);
				translate ([100,0,0]) rotate ([0, 45,90])  cube ([100, 100, 100]);
			}
			intersection () {
				translate ([0, 0, 73]) union () {
				 translate ([5,0,0]) cube ([110, 110, 10]);
				 mirror ([1,0,0]) rotate (90) prism (110, 10, 20);
				}
				translate ([110, 0, 0]) rotate (90) translate ([0, 0, 73]) union () {
				 translate ([5,0,0]) cube ([110, 110, 10]);
				 mirror ([1,0,0]) rotate (90) prism (110, 10, 20);
				}
			}
		}
		translate ([0, -110, 1]) vyrez_podlahy ();
		translate ([0, 0, 33]) rotate ([0, 0,-90]) prism (100, 100, -4.28);
	}
}

module  zadni_roh_P () {
	difference () {
		translate ([0,0,-10]) minkowski () {
			rotate_extrude () ellipsePart (50, 166,2);
			cube ([200,  200, 10]);
		}
		translate ([0,0,-250]) cube (500, true);
		translate ([50,50,-10]) cube ([300, 300, 100]);
		translate ([0,0,33]) cube ([300, 300, 40.2]);
		translate ([-100,100,-10]) cube (200);
		rotate (-90) translate ([-100,100,-10]) cube (200);
		translate ([0, 0, 1]) vyrez_podlahy ();

		translate ([1,50,64]) rotate ([0, 45, 0])  cube ([100, 100, 100]);
		translate ([150,1,64]) rotate ([0, 45,90])  cube ([100, 100, 100]);
		translate ([30, 30, 33]) intersection () {
			translate ([0,0,0]) rotate ([0, 45, 0])  cube ([100, 100, 100]);
			translate ([100,0,0]) rotate ([0, 45,90])  cube ([100, 100, 100]);
		}
		intersection () {
			translate ([0, 0, 73]) union () {
			 translate ([5,0,0]) cube ([110, 110, 10]);
			 mirror ([1,0,0]) rotate (90) prism (110, 10, 20);
			}
			translate ([110, 0, 0]) rotate (90) translate ([0, 0, 73]) union () {
			 translate ([5,0,0]) cube ([110, 110, 10]);
			 mirror ([1,0,0]) rotate (90) prism (110, 10, 20);
			}
		}
		translate ([0, 100, 33]) rotate ([0, 0,-90]) prism (100, 100, -4.28);
	}
}


