	
$fs=0.1;
$fa=1;

// Hlavni objekt
color ("red") klicka ();

// promenne, v mm. Nejsou osetreny proti picovinam! = )
// Priorita: Text > Logo > nic
d_nohy = 10.5;
h_nohy = 37;
vysun_zapadky = 3;	// na modelu osa X
sirka_zapadky = 4;	// na modelu osa Y
vyska_zapadky = 5;	// na modelu osa Z
h_zapadky = 2.5;	// od zeme
sirka_madla = 3.5;
vyska_madla = 20;
delka_madla = 30;
hrubost_textury = 0.5;	// sirka linek na texture gripu
vyska_textury = 0.5;	// vyska extruze gripu
dira = true;		// dira na klice
logo = "hvezda";		// hvezda, fiat, pica
//logo_text = " HEINZZ      "; // velikost automaticky upravena podle delky textu a vysky/sirka madla

// pomocne moduly

function velikost (word,x,y) = (x-5)/len(word) < y/4 ? (x-5)/len(word) : y/4 ;	// velikost textu zavisla na jeho delce a rozmerech madla. Limitovana vyskou.

function prurez_nohy (r,h) = 2* sqrt ( r*r - h*h);		// spocita sirku pruniku nohy a madla. r = polomer nohy, h = sirka madla/2

module napis (word) {						// wrapper pro formatovani textu
	rotate ([0,0,180]) text (word, size = font_size, valign = "center");
}

module prism(l, w, h){						// Rutina k vytvoreni klinu
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module star(num, radii) {					// rutina k vytvoreni hvezdy. num = pocet vrcholu * pocet radii, radii = seznam polomeru
  polygon([for (i=[0:num-1], a=i*360/num, r=radii[i%len(radii)]) [ r*cos(a), r*sin(a) ]]);
}

module grip (){							// vytvori zmensenou zaoblenou verzi libovolneho 2D obejktu
	offset (0.5) { offset (-1.5) { children ();}}
}

module texture (x,res) {						// vytvori zezadaneho 2D objektu 2D mrizku - texturu. res = hrubost textury.
	difference () {	
		children ();
		offset (-res ) children ();
	}
	
	
	intersection (){
		children ();
		union(){
			for (i = [-x: res*4 : 2*x]) {
				translate ([i,0,0]) rotate (-45) square ([res,x]);
				translate ([i,0,0]) rotate (45) square ([res,x]);
				}
		}
	}
	
}

module rounded_extrude (h,max_r = 1) { 				// linear_extrusion se zaoblenejma rohama, argument je h a maximalni polomer rohu. Vzdy zachova sirku a srovna objekt na ose z
	if (h <= max_r*3)  {
		translate ([0,0,h/3]) minkowski (){
			linear_extrude (h/3) children();
			sphere (h/3);
		}
	} else {
		translate ([0,0,max_r]) minkowski (){
			linear_extrude (h-2*max_r) children();
			sphere (max_r);
		}
	}
}

// loga
// Pridani loga: musi se vejit do  square ([vyska_madla/2], true); a musi se rucne pridat if vetve do modulu final_*

module fiat (h=vyska_madla/2,angle=45) {
	x = h/6;
	y = h;
	translate ([-y/2,-y/2,0]) for (i = [0:1:3]) {
		translate ([i*x/2 + i*x,0,0]) polygon([[0,0],[x,0],
			[x+x*cos(angle)/sin(angle),y],
			[x*cos(angle)/sin(angle),y]]);
	}
}


module pica_obrys (x=vyska_madla/4,y=vyska_madla/2) {
	translate ([0, -y/2]) polygon ([[0,0],[-x/2,y/2],[0,y],[x/2,y/2]]);
}

module pica (h = vyska_madla/2, tloustka = hrubost_textury) {
	linear_extrude (vyska_textury) union () {
		difference () {
			pica_obrys (h/2,h);
			offset (-tloustka) { pica_obrys (h/2,h); }
		}
		translate ([-tloustka/2,-h/4]) square ([tloustka,h/2]);
	}
}


module hvezda (d = vyska_madla/2){											// STERN-Fetisch
	linear_extrude (vyska_textury){
		difference (){															// ramecek
			circle (d = d);

			offset (-0.5) { circle (d = d); }
		}
	}
	linear_extrude (vyska_textury, scale = 0){													// hvezda
		rotate (90) star (6, [1, d/2]);
	}	
}


// hlavni kod

font_size = velikost (logo_text,delka_madla,vyska_madla); 
type_text = logo_text ? true : false;

module klicka (){
	union (){
		noha ();
		translate ([(d_nohy/2)-(vyska_zapadky/2),0,(vyska_zapadky - sirka_zapadky/2) + h_zapadky]) rotate ([ 0, 90, 0])  zapadka();
		translate ([delka_madla*5/7,sirka_madla/2,vyska_madla + h_nohy-10]) rotate ([-90,0,180]) final_madlo (); 
	}
}

module noha (){
	difference (){
		cylinder(d=d_nohy, h=h_nohy);
		
		translate ([d_nohy/2, sirka_madla/2, h_nohy+1]) rotate ([0, 180, 0]) prism (d_nohy, (d_nohy - sirka_madla)/2, 8);		// hranol k orezu horni strany nohy
		translate ([-d_nohy/2, -sirka_madla/2, h_nohy+1]) rotate ([0, 180, 180]) prism (d_nohy, (d_nohy - sirka_madla)/2, 8);		// a druhej zrcadlovej
	}
}

module zapadka (){
	hull () {
		cylinder (d=sirka_zapadky, h=vysun_zapadky*2);
		translate ([vyska_zapadky - sirka_zapadky,0,0])	cylinder (d=sirka_zapadky, h=vysun_zapadky*2);
	}
}

module madlo (){
	offset (2){ hull (){															// lichobeznk ze spojeni dvou trojuhelniku, offsetna zaobleni rohu
			translate ([0,vyska_madla-2, 0]) rotate ([0,0,180]) polygon ([[0,0],[vyska_madla/5,0],[0,vyska_madla-4]]);
			translate ([delka_madla,2,0]) polygon ([[0,0],[vyska_madla/5,0],[0,vyska_madla-4]]);
	}}
}


	

module final_grip (features = false){														// Nakrmime tvarem madla minus detaily, zmensime gripem a upravime texturou
	linear_extrude (vyska_textury) texture (delka_madla,hrubost_textury) { grip () {
		difference () {
			madlo ();
			if (features) {														// chci umet generovat i grip bez detailu, na rubovou stranu
				if (type_text) translate ([delka_madla,vyska_madla/5+font_size/2]) napis (logo_text); 				// pokud je text, nakresli text
				else { translate ([delka_madla/3,vyska_madla/2])								// pokud neni text, posune a nakresli logo (pokud je)
					if (logo == "hvezda" ) circle (d=vyska_madla/2);
					else if (logo == "pica" ) pica_obrys ();
					else if (logo == "fiat" ) fiat ();
				}
			}
			translate ([delka_madla*5/7, vyska_madla]) square ([ prurez_nohy (d_nohy/2, sirka_madla/2) , 20], true);	// noha, velikost upravena podle realnyho pruniku nohy a madla
			if (dira) translate ([2,4,0]) circle (d=4);					// dira na klicek
		}
	}}
}

module final_madlo () {																// analogicky jako final_grip
	difference (){
		union () {				
			rounded_extrude (sirka_madla) { madlo ();}										// telo madla
			translate ([0,0,sirka_madla]) final_grip (true);									// licovy grip
			mirror ([0,0,1]) final_grip ();												// rubovy grip
			if (type_text) translate ([delka_madla,vyska_madla/5+font_size/2,sirka_madla]) linear_extrude (vyska_textury) napis(logo_text);	// text pokud existuje
			else { translate ([delka_madla/3,vyska_madla/2,sirka_madla]) 								// ...pokud ne tak logo (pokud existuje = )
				if (logo == "hvezda") hvezda ();
				else if (logo == "pica") pica ();
				else if (logo == "fiat") fiat ();
			}	
		}	
		if (dira) translate ([2,4,-sirka_madla/2]) cylinder (d=4, h=sirka_madla*2, centre = true);	// dira na klicek
	}
}
