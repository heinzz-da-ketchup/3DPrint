include <Deska+18mm_nova.scad>

translate ([250+75,0]) difference () {
    projection(cut = false) obj2origin(NE);
    projection(cut = true) obj2origin(NE);
}
