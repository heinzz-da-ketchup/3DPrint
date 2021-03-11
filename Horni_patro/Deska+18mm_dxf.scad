include <Deska+18mm.scad>

difference () {
    projection(cut = false) obj2origin(NE);
    projection(cut = true) obj2origin(NE);
}