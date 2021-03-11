$fn = 100;

linear_extrude (10) difference() {
    offset (2) square ([41,34], true);
    square ([37,12], true);
    translate ([15,(38/2)-7.5]) circle (d=5);
    translate ([15,-(38/2)+7.5]) circle (d=5);
    translate ([-(45/2)+14.5,(38/2)-7.5]) circle (d=5);
    translate ([-(45/2)+14.5,-(38/2)+7.5]) circle (d=5);
}

