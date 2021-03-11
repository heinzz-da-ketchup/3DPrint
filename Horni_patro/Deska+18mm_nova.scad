// File: /home/jan/Documents/3D Tisk/Horni_patro/Deska+18mm.stl
// X size: 250.0
// Y size: 125.0
// Z size: 1.8
// X position: 1404.629
// Y position: -442.108
// Z position: -68.545
NE=1; NW=2; SW=3; SE=4; CTR=5;
module obj2origin (where) {
	if (where == NE) {
		objNE ();
	}

	if (where == NW) {
		translate([ -250.0 , 0 , 0 ])
		objNE ();
	}

	if (where == SW) {
		translate([ -250.0 , -125.0 , 0 ])
		objNE ();
	}

	if (where == SE) {
		translate([ 0 , -125.0 , 0 , ])
		objNE ();
	}

	if (where == CTR) {
	translate([ -125.0 , -62.5 , -0.9 ])
		objNE ();
	}
}

module objNE () {
	translate([ -1404.629 , 442.108 , 68.545 ])
		import("/home/jan/Documents/3D Tisk/Horni_patro/Deska+18mm_nova.stl");
}
