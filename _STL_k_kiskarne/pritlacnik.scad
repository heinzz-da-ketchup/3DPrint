use <M3.scad>;

$fn = 100;
/*% translate ([3.5,3.5,0]) hull(){
offset (r=3.5)  square ([31, 1]);
translate ([15.5,6.25/2,0]) circle (6.25);    
}*/

module body () {
 linear_extrude (20) union (){ 
    translate ([10,0,0]) hull (){
        square ([20,8]);
        translate ([10,6.25,0]) circle (6.25);
    }
    translate ([3,3,0]) offset (r=3) square ([32,2]);
}
}


difference () {
    body(); 
    translate ([0,0,5])cube (10);
    translate ([12,-2,7]) cube ([15,20,6]);
    translate ([32,0,2+(5.5/2)]) rotate ([90,0,0]) resize (newsize=[0,0,5]) NutM3();
    translate ([32,0,20-2-(5.5/2)]) rotate ([90,0,0]) resize (newsize=[0,0,5]) NutM3();
    translate ([32,10,4.75])rotate ([90,0,0]) cylinder (h=10, r=2);
    translate ([32,10,20-4.75])rotate ([90,0,0]) cylinder (h=10, r=2);
    translate ([32,0,2.75]) cube ([10,10,4]);
    translate ([32,0,20-6.75]) cube ([10,10,4]);
    translate ([3.5,4,0])  cylinder (h=20, r=1.5);
    translate ([20,7,0])  cylinder (h=20, r=2);
    }