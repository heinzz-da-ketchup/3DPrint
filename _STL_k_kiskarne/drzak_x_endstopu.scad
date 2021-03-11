$fn=100;


union () {
    base ();
    translate ([-16,28]) difference() {
        cube ([13,5,62]);
        translate ([9,0,15]) cube ([4,5,62-15]);
        translate ([4.5,5,59])rotate ([90,0,0]) #cylinder (d=3,h=5);
        translate ([4.5,5,59-15])rotate ([90,0,0]) #cylinder (d=3,h=5);
    }
    
        
}


module base (){
linear_extrude (3) union () {
    translate ([-16, 11])square ([13,22]);
    difference (){
        union() {
           # circle (d=25);
            translate ([-16,-2.5]) square ([16,13.5]);
        }
        circle (d=11);
        translate ([(22/2)-3, 0]) circle (d=3);
        translate ([0,(22/2)-3]) circle (d=3);
        translate ([-(22/2)+3, 0]) circle (d=3);
        translate ([0,-15]) square (25, true);
       }
    }
}
