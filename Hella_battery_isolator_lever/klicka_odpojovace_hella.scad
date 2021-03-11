
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

//pomocne obekty

module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

//hlavni kod

module klicka (){
	union (){
		noha ();
		translate ([(d_nohy/2)-(vyska_zapadky/2),0,(vyska_zapadky - sirka_zapadky/2) + h_zapadky]) rotate ([ 0, 90, 0])  zapadka();
		translate ([-10-d_nohy/2,sirka_madla/6,h_nohy-10]) rotate ([90,0,0]) madlo ();
	}
}

module noha (){
	difference (){
		cylinder(d=d_nohy, h=h_nohy);
		
		translate ([d_nohy/2, sirka_madla/2, h_nohy+1]) rotate ([0, 180, 0]) prism (d_nohy, (d_nohy - sirka_madla)/2, 10);		//hranol k orezu horni strany nohy
		translate ([-d_nohy/2, -sirka_madla/2, h_nohy+1]) rotate ([0, 180, 180]) prism (d_nohy, (d_nohy - sirka_madla)/2, 10);	//a druhej zrcadlovej
	}
}

module zapadka (){
	hull () {
		cylinder (d=sirka_zapadky, h=vysun_zapadky*2);
		translate ([vyska_zapadky - sirka_zapadky,0,0])	cylinder (d=sirka_zapadky, h=vysun_zapadky*2);
	}
}

module madlo(){
	difference (){																	//odecteni diry od hotovyho madla
		minkowski (){																//mirkowski zaobluje hrany obektu jejich kombinaci s kruhem/kouli
			linear_extrude (sirka_madla/3)													//madlo vytahnu z plochyho lichobezniku
				translate ([0,vyska_madla/6]) minkowski(){										//ten je taky zaoblenej, trnslate proto ze mirkowski zvetsuje	
					hull (){													//lichobeznk je ze spojeni dvou trojuhelniku
						translate ([0,vyska_madla*2/3, 0]) rotate ([0,0,180]) polygon ([[0,0],[vyska_madla/5,0],[0,vyska_madla*2/3]]);
						translate ([delka_madla,0,0]) polygon ([[0,0],[vyska_madla/5,0],[0,vyska_madla*2/3]]);
					}
					circle (vyska_madla/6);												//kruh k zaobleni 2D lichobezniku
				}
			sphere (sirka_madla/3);														//koule k zaobleni 3D madla
		}																	//velikosti ve zlomich dany proto aby sedel vysledek a promenne
		translate ([delka_madla,vyska_madla*4/5, -sirka_madla]) cylinder (d=vyska_madla/5, h=sirka_madla*2);					//"prustrel"
	}
}
