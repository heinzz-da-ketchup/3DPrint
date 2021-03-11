// File: Desky+10mm.stl
// X size: 575.0
// Y size: 708.6
// Z size: 2.0
// X position: 1079.629
// Y position: -442.108
// Z position: -68.545
NE=1; NW=2; SW=3; SE=4; CTR=5;
module obj2origin (where) {
	if (where == NE) {
		objNE ();
	}

	if (where == NW) {
		translate([ -575.0 , 0 , 0 ])
		objNE ();
	}

	if (where == SW) {
		translate([ -575.0 , -708.6 , 0 ])
		objNE ();
	}

	if (where == SE) {
		translate([ 0 , -708.6 , 0 , ])
		objNE ();
	}

	if (where == CTR) {
	translate([ -287.5 , -354.3 , -1.0 ])
		objNE ();
	}
}

module objNE () {
	translate([ -1079.629 , 442.108 , 68.545 ])
		import("Desky+10mm.stl");
}
