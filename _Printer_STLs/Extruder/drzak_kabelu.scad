$fn = 100;

union () {
translate ([15,19,10]) cylinder (20,r=3);    
difference () {  
    linear_extrude (10) offset (1) difference () {
        square ([30,23]);
        translate ([0,12]) rotate (45) square (20);
        translate ([30,12]) rotate (45) square (20);
        translate ([3.5,3])circle (d=4);
        translate ([26.5,3])circle (2);
    }
    translate ([-2,15.5,-3.5])rotate ([0,90,0]) cylinder (35,d=15);
    //translate ([0,6,0]) cube ([30,20,4]);
}
}