include <Desky+10mm.scad>

difference () {
    projection(cut = false) obj2origin(NE);
    projection(cut = true) difference(){
        obj2origin(NE); 
        translate ([323,195,-1]) cube ([252,127,3]);
    }
}
