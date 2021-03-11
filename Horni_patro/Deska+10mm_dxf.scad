include <Deska+10mm.scad>

difference () {
    
    projection(cut = false) obj2origin(NE);
    projection () difference (){
        obj2origin(NE);
        translate ([-1,0,-0.25]) cube ([251,125,0.5]);
    }
}
