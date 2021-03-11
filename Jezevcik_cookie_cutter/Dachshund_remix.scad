final (); 

module jezevcik () {
    resize (newsize=[95, 0, 0], auto=true) 
        import("/home/jan/Downloads/Dachshund.stl");
}

module bez_ucha () {
    projection (cut = true) 
        translate ([0, 0, -15])  
            jezevcik ();
}

module s_uchem () {
    projection (cut = true) 
        translate ([0, 0, -10])   
            jezevcik ();
}

module ucho () {
    difference () {
        s_uchem () ; 
        bez_ucha () ;
    }
}

module zakladna () {
    difference () {
        jezevcik ();
        translate ([-100, -100, 0]) cube (200) ;
    }
}



module final () {
    union () {
        zakladna () ;
        linear_extrude (height = 3) bez_ucha () ;
        linear_extrude (height = 3) offset (r = 0.4) ucho () ;
        linear_extrude (height = 10) offset (r = -0.3) bez_ucha () ;
        linear_extrude (height = 5) offset (r = 0.15) ucho () ;
    }
}



        