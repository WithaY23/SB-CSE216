package Assignments.Assignment3;
import java.lang.Math;


/**
 * The class impementing squares.
 * Note: you can add more methods if you want, but additional methods must be <code>private</code> or <code>protected</code>.
 *
 * @author Ayden Budhoo
 */
public class Square implements Shape
{

    //p1 = top right
    //p2 = top left
    //p3 = bottom left
    //p4 = bottom right
    private Point p1;
    private Point p2;
    private Point p3;
    private Point p4;
    private Point center;

    /**
     * The constructor accepts an array of <code>Point</code>s to form the vertices of the square. If more than four
     * points are provided, only the first four are considered by this constructor.
     *
     * If less than four points are provided, or if the points do not form a valid square, the constructor throws
     * <code>java.lang.IllegalArgumentException</code>.
     *
     * @param vertices the array of vertices (i.e., <code>Point</code> instances) provided to the constructor.
     */
    public Square(Point... vertices)
    {

        if (vertices.length < 4) //check if valid # of points
            throw new IllegalArgumentException("There must be at least 4 points given to make a square");

        center = this.calculateCenter(vertices[0],vertices[2]); // DABC, use D and B

        p1 = vertices[0];
        if (this.vOrderCheck(p1, vertices[1]))
            throw new IllegalArgumentException("The second point supplied isn't in degree order specified");

        p2 = vertices[1];
        if (this.vOrderCheck(p2, vertices[2]))
            throw new IllegalArgumentException("The third point supplied isn't in degree order specified");

        p3 = vertices[2];
        if (this.vOrderCheck(p3,vertices[3]))
            throw new IllegalArgumentException("The fourth point supplied isn't in degree order specified");

        p4 = vertices[3];

        double length1 = calculateLength(p1,p2);
        double length2 = calculateLength(p1,p4);
        double length3 = calculateLength(p3,p2);
        double length4 = calculateLength(p3,p4);

        if (!(length1 == length2 && length3 == length4 && length1== length4))
        {
            throw new IllegalArgumentException("Distance isn't valid");
        }

    }

    protected double calculateLength(Point v1,Point v2)
    {
        Point p = v1.difference(v2);
        return Math.sqrt(Math.pow(p.x,2) + Math.pow(p.y,2));
    }

    //valid order supplied was DABC, D and B are across from eachother so use their points as input
    //DC
    protected Point calculateCenter(Point v1, Point v2)
    {
        return new Point("Center", (v1.x + v2.x) /2, (v1.y+ v2.y) / 2);
    }
    protected boolean vOrderCheck(Point v1, Point v2) //ensure the order of the vertices are valid
    {
        ////check if both x and y are on different lines, false if true
        //return v1.x != v2.x && v1.y != v2.y;

        //v1 should be less than v2,
        return this.calculateAngle(v1) > this.calculateAngle(v2);

    }

    protected double calculateAngle(Point v)
    {
        //adjust by the center
//        double x = v.x - center().x;
//        double y = v.y - center().y;

        Point p = centerToAxis(v);

        //calculate the angle difference from x-axis, arctangent (atan2) accounts for negative center (Q2, Q3)
        double radians = Math.atan2(p.y,p.x);

        //adjusts radian answer to degree within range [0,360), arctangent supplies negative so adjust
        double degrees = (Math.toDegrees(radians) + 360) % 360;
        return  degrees;
    }

    //translate point from (0 + c.x, 0 + c.y) to (0,0)
    protected Point centerToAxis(Point v)
    {
        return new Point (v.name,v.x - center().x,v.y- center().y);
    }

    //translate point from (0,0)  to (0 + c.x, 0 + c.y)
    protected Point axisToCenter(Point v)
    {
        return new Point (v.name,v.x + center().x,v.y+ center().y);
    }



    protected Point rotateP(Point v, double radians)
    {
        double x = v.x* Math.cos(radians) - v.y* Math.sin(radians);
        double y = v.x * Math.sin(radians) + v.y * Math.cos(radians);
        return new Point(v.name,x,y);
//        return new Point(v.name + "'",x,y); i'm keeping this commented because its intuitive and useful for tests
    }


    //used by rotateBy to arrange the order of points for the new Square
    protected Point[] calculateOrder(Point... vertices)
    {
        //assume vertices has 4 points stored inside, as it is used by a Square
        //use insertion sort to return ordered sequence, 4 elements used

        Point current;
        int tracker; //length - 1
        for(int i = 1; i<4; i++)
        {
            current = vertices[i];
            tracker = i - 1;
            //comparison is calculateAngle, need to adjust center beforehand
            while (tracker >= 0 && calculateAngle(vertices[tracker]) > calculateAngle(current))
            {
                vertices[tracker+1] = vertices[tracker];
                tracker -=1;
            }

            vertices[tracker+1] = current;

        }

        return vertices;



    }
    @Override
    public Square rotateBy(int degrees)
    {
        double radians = Math.toRadians(degrees);
        Point ap1 = centerToAxis(p1);
        ap1 = rotateP(ap1,radians);
        ap1 = axisToCenter(ap1);

        Point ap2 = centerToAxis(p2);
        ap2 = rotateP(ap2,radians);
        ap2 = axisToCenter(ap2);


        Point ap3 = centerToAxis(p3);
        ap3 = rotateP(ap3,radians);
        ap3 = axisToCenter(ap3);

        Point ap4 = centerToAxis(p4);
        ap4 = rotateP(ap4,radians);
        ap4 = axisToCenter(ap4);

        //shouldn't need to caclulate center again, does so when creating instance of shape
        //it does need to caclulate center, in order to rearrange the new representation of Square
//        //recalculate center after transformation, diagonal points
        calculateCenter(ap1,ap3); //DC

        Point[] points = calculateOrder(ap1,ap2,ap3,ap4);

        return new Square(points[0],points[1],points[2],points[3]);// TODO
    }

    @Override
    public Shape translateBy(double x, double y)
    {
        //each new point will be marked as ' after a translation
        //keeping this because its intuitive and useful for testing
//        Point ap1 = new Point(p1.name + "'",p1.x + x,p1.y+y);
//        Point ap2 = new Point(p2.name + "'",p2.x + x,p2.y+y);
//        Point ap3 = new Point(p3.name + "'",p3.x + x,p3.y+y);
//        Point ap4 = new Point(p4.name + "'",p4.x + x,p4.y+y);

        Point ap1 = new Point(p1.name,p1.x + x,p1.y+y);
        Point ap2 = new Point(p2.name,p2.x + x,p2.y+y);
        Point ap3 = new Point(p3.name,p3.x + x,p3.y+y);
        Point ap4 = new Point(p4.name,p4.x + x,p4.y+y);

        //they should still maintain the angle separation, as they are operations within a group.

        //recalculate center after transformation
        //DC shoudln't need to

        //DC to make sure this produces a shape within the set S of shapes, translateBy must be a group operation
        //might not retain same order, DC

        return new Square(ap1,ap2,ap3,ap4); // TODO
    }

    @Override
    public String toString()
    {
        //order needed: increasing angle from the positive x-axis
        //the elements should already be in the correct order, as is the condition of making a square
        //round the values of points accordingly
        return "[" + p1 + "; " +p2 + "; " + p3+ "; " + p4 + "]";// TODO
    }

    //build the string representation of a point
//    protected String pointString(Point v)
//    {
//        return "(" + v.name + ", "+ v.x+ ", " + v.y + ")" ;
//    }

    @Override
    public Point center()
    {
        double x = ((double) (Math.round(this.center.x * 100))) / 100;
        double y = ((double) (Math.round(this.center.y * 100))) / 100;








        return new Point(center.name, x,y); //ensures that a public method returning a point is rounded
//        return center; test code included


    }

    //horizontal reflection is similar to a rotation with top left and bottom right swapped
    protected Square horizontalReflection()
    {
        Point swap1 = new Point(this.p2.name,p4.x,p4.y); //put 2 in 4's spot

        Point swap2 = new Point(this.p4.name,p2.x,p2.y);

        //DON'T use rotations for reflections, doesn't work for 45 degrees
        //use center and transform off that
        //rotate by 90 degrees counterclockwise
        return (new Square(p1,swap2,p3,swap1)).rotateBy(90);
    }

    //vertical reflection is similar to a rotation with 1 and 3 swapped respectively
    protected Square verticalReflection()
    {
        Point swap1 = new Point(this.p1.name,p3.x,p3.y);

        Point swap2 = new Point(this.p3.name,p1.x,p1.y);

        //rotate by 90 degrees
        return (new Square(swap2,p2,swap1,p4)).rotateBy(90);

        //try rotating the horizontal reflection by 180
        // return (this.horizontalReflection).rotateBy(180);

    }

    //similar to horizontal reflection rotated by 90 degrees
    protected Square diagonalReflection()
    {
        //try rotating the horizontal reflection by 90
        // return (this.horizontalReflection).rotateBy(90);
        return null;
    }

    //similar to horizontal reflection rotated by 90 degrees
    protected Square counterDiagonalReflection()
    {
        //try rotating the horizontal reflection by 90
        // return (this.horizontalReflection).rotateBy(90);
        return null;
    }





    public static void main(String... args) {
        Point  a = new Point("A", 1, 4);
        Point  b = new Point("B", 1, 1);
        Point  c = new Point("C", 4, 1);
        Point  d = new Point("D", 4, 4);

        Point p = new Point("P", 0.3, 0.3);

//        Square sq1 = new Square(a, b, c, d); // throws an IllegalArgumentException
        Square sq2 = new Square(d, a, b, c); // forms a square

        Square sq3 = new Square(p, p, p, p); // forms a "trivial" square (this is a limiting case, but still valid)

        // prints: [(D, 4.0, 4.0); (A, 1.0, 4.0); (B, 1.0, 1.0); (C, 4.0, 1.0)]
        System.out.println(sq2);

        
        System.out.println(sq2.center());

        // prints: [(C, 4.0, 4.0); (D, 1.0, 4.0); (A, 1.0, 1.0); (B, 4.0, 1.0)]
        // note that the names denote which point has moved where
        System.out.println(sq2.rotateBy(90));

        //rearrange the order to display new formation
        Square sq4 = sq2.rotateBy(180);
        System.out.println("Rotate by 180: " + sq4);

        //print values as given
        Point p2 = new Point("P2", 0.03, 0.03);
        Square sq5 = new Square(p2,p2,p2,p2);
        System.out.println("2 precision points: " + sq5 );

        //should have too low of precision to print values
        Point p3 = new Point("P3", 0.003, 0.003);
        Square sq6 = new Square(p3,p3,p3,p3);
        System.out.println("Loss of precision: " + sq6 );

        //testing printing center
        Point p4 = new Point ("P4", .06,.06);
        Point p5 = new Point ("P5", .06,.03);
        Point p6 = new Point ("P6", .03,.06);

        Square sq7 = new Square(p4,p6,p2,p5);

        //DOES NOT properly ensure center() is rounded
        //tested by removing the toString rounding in Point and returning center in point, rounding works
        System.out.println("Center rounding: " + sq7.center());

        Square sq8 = (Square) sq4.translateBy(5,5);

        System.out.println("Translating sq4: " + sq8);

        Square sq9 = (Square) sq4.translateBy(5.555,5.555);

        System.out.println("Rounding translation: " + sq9);

        //Trying to build an out of order square from a rotating square, should print an error
        //sq4/sq2 values rearranged
        // Square sq10 = new Square(b,d,a,c); //throws an IllegalArgumentException


        //try building rotated squares that are symmetrical to sq2
        //rotation and translation works

        //figure out square symmetries

        //start by aligning centers of the two shapes
        //Point transform = sq1.center().difference(sq2.center());
        // sq3= sq2.translateBy(transform.x,transform.y);

        //id: if all points align, return true
            //implements equals method
        //rotation 90: if a figure is rotated 90 degrees, check equivalency
        //rotation 180, 270: similar to rotation 90

        //reflection across y-center, horizontal reflection
            //Ignore this
                //make a boolean method vOrderCheckerFinal (change vOrderChecker to helper)
                    //returns true if angle order is valid, false if not
            //rotate and swap 2,4, build method in class
                //if sq1 and sq2 are equivalent through horizontal reflection
                //Square temp = this.rotate(90);
                //return new Square (temp.p1,temp.p4,temp.p3,temp.p2);

        System.out.println("Horizontal Reflection: " + sq2.horizontalReflection());
        System.out.println("Horizontal Reflection Again: " + sq2.horizontalReflection().horizontalReflection());

        Square sq11 = sq2.rotateBy(45);
        System.out.println("45 degree rotation: " + sq11);
        System.out.println(sq11.center());
        System.out.println("Horizontal reflection of 45 rotation:" + sq11.horizontalReflection());
        //


        //invalid length
//        Square sq11 = new Square(d,new Point("A Fake",1.1,4.1),b,c); //throws an IllegalArgumentException for distance

    }
}