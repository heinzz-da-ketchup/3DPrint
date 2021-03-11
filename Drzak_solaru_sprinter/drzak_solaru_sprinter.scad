$fn = 100 ;



preview ();			//Preview kompletniho setupu, zakomentovat pro tisk
//test_pisma ();		//odkomentuj pro zkusebni tisk pisma
//roh_LZ ();			//odkomentuj jednotlive radky pro tisk. Od kazdeho je potreba 2ks.
//roh_PZ ();
//rovny_bok ();
//rovny_celo ();


//Testovaci a preview moduly

module test_pisma () {
	difference () {
		cube ([150, 10, 10]);
		translate ([10, 1, 8]) linear_extrude (3) text ("WWW.BESKYDKARAVAN.CZ", size = 7, font = "Liberation Sans:style=Bold");
	}
}


module preview () {
	color ("blue") translate ([0,0,40]) solar ();
	%translate ([-10, 0, 0]) vyrez_podlahy ();
	%translate ([480, 0,20]) vyrez_podlahy ();
	%translate ([970, 0, 0]) vyrez_podlahy ();

	color ("grey") roh_LZ ();
	color ("grey") translate ([990, 1650]) rotate (180) roh_LZ ();
	color ("grey") translate ([990, 0, 0]) roh_PZ ();
	color ("grey") translate ([0, 1650, 0]) rotate (180) roh_PZ ();

	color ("grey") translate ([0, 725, 0]) rovny_bok ();
	color ("grey") translate ([990, 925, 0]) rotate (180) rovny_bok ();

	color ("grey") translate ([495, 0, 0]) rovny_celo ();
	color ("grey") translate ([495, 1650, 0]) rotate (180) rovny_celo ();
}

//moduly pro tiskk

module rovny_celo () {
	difference () {
		translate ([100, 0, 0]) rotate (90) rovny_dil ();
		translate ([-15, 0,20]) vyrez_podlahy ();
		cube ([220, 150, 40], true);
	}
}

module rovny_bok () {
	difference () {
		rovny_dil ();
		translate ([-10, 0, 0]) vyrez_podlahy ();
	}
}

module roh_PZ () {
	difference () {
		rotate (90) rohovy_dil ();
		translate ([-20, 0, 0]) vyrez_podlahy ();
	}
}

module roh_LZ () {
	difference () {
		rohovy_dil ();
		translate ([-10, 0, 0]) vyrez_podlahy ();
	}
}


//pomomcne moduly a mezikroky

module vyrez_podlahy () {
	translate ([0, 1720]) rotate ([90, 0, 0]) linear_extrude (1800) 
		difference () {
			hull () {
				square ([30, 10]);
				translate ([-10, -10]) square ([50, 10]);
			}
			translate ([-10, -11]) square ([50, 10]);
		}
}

module solar () {
	 %cube ([990, 1650, 40]);
}



module rohovy_dil () {
	difference () {
		translate ([-10,-10,0]) minkowski () {
			 cube ([150,150,30]);
			 sphere (60);
		}

		 translate ([-100,-100,-100]) cube ([400, 400, 100]);
		 translate ([0,0,40]) cube ([300, ,300, 100]);
		 translate ([140, -100, -5]) cube ([100, 400, 110]);
		 rotate (90) translate ([140, -300, -5]) cube ([100, 400, 110]);
		 translate ([50, 50, -5]) cube ([200, 200, 50]);
		 translate ([0, -9, 88]) linear_extrude (3) text ("WWW.BESKYDKARAVAN.CZ", size = 7, font = "Liberation Sans:style=Bold");
	}
}

module rovny_dil () {
	difference () {
		translate ([-10,-10,0]) minkowski () {
			 cube ([210,210,30]);
			 sphere (60);
		}

		 translate ([-100,-100,-100]) cube ([400, 400, 100]);
		 translate ([0,-80,40]) cube ([300, ,300, 100]);
		 translate ([50, -100, -5]) cube ([300, 400, 110]);
		 rotate (90) translate ([200, -300, -5]) cube ([100, 400, 110]);
		 translate ([-100, 0, -5]) rotate (-90) cube ([100, 400, 110]);
		 translate ([50, 50, -5]) cube ([200, 200, 40]);
		 translate ([-9, 140, 88]) rotate (-90)  linear_extrude (3) text ("WWW.BESKYDKARAVAN.CZ", size = 7, font = "Liberation Sans:style=Bold");
	}
}
