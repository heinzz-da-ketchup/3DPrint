// File: Deska+Lamino.stl
// X size: 250.0
// Y size: 225.0
// Z size: 1.9
// X position: 1404.069
// Y position: -745.428
// Z position: -67.545
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
		translate([ -250.0 , -225.0 , 0 ])
		objNE ();
	}

	if (where == SE) {
		translate([ 0 , -225.0 , 0 , ])
		objNE ();
	}

	if (where == CTR) {
	translate([ -125.0 , -112.5 , -0.95 ])
		objNE ();
	}
}

module objNE () {
	translate([ -1404.069 , 745.428 , 67.545 ])
		import("Deska+Lamino.stl");
}
