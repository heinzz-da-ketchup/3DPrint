
$fs=0.1;
$fa=1;

//Hlavni objekt
color ("red") klicka ();

//promenne, v mm. Nejsou osetreny proti picovinam! = )
d_nohy = 10.5;
h_nohy = 37;
vysun_zapadky = 3;	//na modelu osa X
sirka_zapadky = 4;	//na modelu osa Y
vyska_zapadky = 5;	//na modelu osa Z
h_zapadky = 2.5;	//od zeme
sirka_madla = 3.5;
vyska_madla = 20;
delka_madla = 40;
hrubost_textury = 0.2;	//sirka linek na texture gripu 

//pomocne moduly

module prism(l, w, h){	// Rutina k vytvoreni klinu
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module star(num, radii) {	//rutina k vytvoreni hvezdy. num = pocet vrcholu * 2, radii = seznam raiusu, stridaji se
  polygon([for (i=[0:num-1], a=i*360/num, r=radii[i%len(radii)]) [ r*cos(a), r*sin(a) ]]);
}

module grip (){			//vytvori zmensenou zaoblenou verzi libovolneho 2D obejktu
	offset (0.5) { offset (-1.5) { children ();}}
}

module texture () {		//vytvori zezadaneho 2D objektu 2D mrizku - texturu
	difference () {	
		children ();
		offset (-hrubost_textury ) children ();
	}
	
	
	intersection (){
		children ();
		union(){
		for (i = [-500: hrubost_textury*4 : 500]) {
		translate ([i,-1,0]) rotate (315) square ([hrubost_textury ,100]);
		translate ([i,-1,0]) rotate (45) square ([hrubost_textury,100]);
		}
		}
	}
	
}

module rounded_extrude (sirka) { 	//linear_extrusion se zaoblenejma rohama, argument je sirka, maximalni polomer rohu je 1mm
	if (sirka <= 3) {
		minkowski (){
			linear_extrude (sirka/3) children();
			sphere (sirka/3);
		}
	} else {
		minkowski (){
			linear_extrude (sirka-2) children();
			sphere (1);
		}
	}
}

//hlavni kod

module klicka (){
	union (){
		noha ();
		translate ([(d_nohy/2)-(vyska_zapadky/2),0,(vyska_zapadky - sirka_zapadky/2) + h_zapadky]) rotate ([ 0, 90, 0])  zapadka();
		translate ([delka_madla - 7 - d_nohy/2 ,sirka_madla/2,vyska_madla + h_nohy-10]) rotate ([-90,0,180]) final_madlo ();
	}
}

module noha (){
	difference (){
		cylinder(d=d_nohy, h=h_nohy);
		
		translate ([d_nohy/2, sirka_madla/2, h_nohy+1]) rotate ([0, 180, 0]) prism (d_nohy, (d_nohy - sirka_madla)/2, 8);		//hranol k orezu horni strany nohy
		translate ([-d_nohy/2, -sirka_madla/2, h_nohy+1]) rotate ([0, 180, 180]) prism (d_nohy, (d_nohy - sirka_madla)/2, 8);		//a druhej zrcadlovej
	}
}

module zapadka (){
	hull () {
		cylinder (d=sirka_zapadky, h=vysun_zapadky*2);
		translate ([vyska_zapadky - sirka_zapadky,0,0])	cylinder (d=sirka_zapadky, h=vysun_zapadky*2);
	}
}


module final_madlo () {
	difference (){
	union () {
		translate ([0,0,1]) rounded_extrude (sirka_madla) { madlo ();}									//tohle translate je prasarna, posunout podle sirky (if branch)
		translate ([0,0,sirka_madla - 0.1]) final_grip ();										
		mirror ([0,0,1]) final_grip ();
		translate ([delka_madla/3,vyska_madla/2,sirka_madla]) hvezda ();
		mirror ([0,0,1]) translate ([delka_madla/3,vyska_madla/2,0]) hvezda ();
	}

	translate ([vyska_madla/10,vyska_madla/5,-sirka_madla/2]) cylinder (d=vyska_madla/5, h=sirka_madla*2, centre = true);			//Dira na klicek
	}
}

module madlo (){
	offset (2){ hull (){															//lichobeznk ze spojeni dvou trojuhelniku
			translate ([0,vyska_madla-2, 0]) rotate ([0,0,180]) polygon ([[0,0],[vyska_madla/5,0],[0,vyska_madla-4]]);
			translate ([delka_madla,2,0]) polygon ([[0,0],[vyska_madla/5,0],[0,vyska_madla-4]]);
	}}
}

	

module final_grip (){																// Nakrmime tvarem madla minus detaily, zmensime gripem a upravime texturou
linear_extrude (0.5) texture () { grip () {
	difference () {
		madlo ();

		translate ([delka_madla/3,vyska_madla/2]) circle (d=vyska_madla/2);								// Tady bude hvezda
		translate ([delka_madla -d_nohy - 7, vyska_madla - 10]) square ([ d_nohy , vyska_madla]);					// tady bude noha
		translate ([vyska_madla/10,vyska_madla/5,0]) circle (d=vyska_madla/5);								// tady bude dira na klicek
	}
}}
}

module hvezda (){																//STERN-Fetisch
	linear_extrude (0.5){
		difference (){															//ramecek
			circle (d=vyska_madla/2);

			offset (-hrubost_textury){circle (d=vyska_madla/2);}
		}
	}
	linear_extrude (0.5, scale = 0){													//hvezda
		rotate (90) star (6, [1,vyska_madla/4]);
	}	
}
