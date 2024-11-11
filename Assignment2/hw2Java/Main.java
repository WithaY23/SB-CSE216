package Assignments.Assignment2.hw2Java;

import java.util.ArrayList;
import java.util.List;

//Question 7

// abstract class Shape
// {
//     P p; //set of floats similar to the one expressed in OCaml
//         //if the type point were replaced by float *float, class P would not be necessary

//     public Shape(float x, float y)
//     {
//        this.p = new P(x,y);

//     }

//     abstract P center();

//     abstract float area();

//     @Override //separate for
//     public String toString()
//     {
//         return "The center is: " + this.center() + "\n The area is: " + this.area();
//     }

// }


// class Point extends Shape
// {
//     public Point(float x, float y){super(x,y);}

//     @Override
//     P center()
//     {
//         return p;
//     }

//     @Override
//     float area()
//     {
//         return 0;
//     }


// }

// class Circle extends Shape
// {
//     float radius;

//     public Circle(float x, float y, float r)
//     {
//         super(x,y);
//         this.radius = r;
//     }

//     public Circle(Point a, float r)
//     {
//         super(a.p.getX(),a.p.getY());
//         this.radius = r;
//     }

//     @Override
//     P center()
//     {
//         return p;
//     }

//     @Override
//     float area()
//     {
//         return (float) Math.round((Math.PI * Math.pow(radius,2)) * 100) / 100;
//     }

// }




public class Main
{

    public static void main(String... args)
    {
        Shape s1 = new Point(0, 0);
        Shape s2 = new Circle((Point)s1, 2); // TODO: correct the type error in this line
        Shape s3 = new Circle(new Point(0, 0), 3);
        List<Shape> shapes = new ArrayList<>();
        shapes.add(s1);
        shapes.add(s2);
        shapes.add(s3);
        for (Shape s : shapes) {
// TODO: override the required method to make the output human-readable
            System.out.println("center: " + s.center() + "; area: " + s.area());

        }

        
        
            
    }
}





/*
You may have additional methods in your classes even if such methods are not stated as required by
this assignment. Such additional methods, however, must not be public.
type ('a,'b) tree =
| Leaf of 'a
| Tree of ('a, 'b) node
and
('a,'b) node = {
operator: 'b;
left: ('a,'b) tree;
right: ('a,'b) tree
};;
 */