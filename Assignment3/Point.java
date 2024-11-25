package Assignments.Assignment3;

import java.util.StringJoiner;

/**
 * A point in the standard two-dimensional Euclidean space. The coordinates of such a point are given by exactly two
 * doubles specifying its <code>x</code> and <code>y</code> values. Each point also has a unique unmodifiable name,
 * which is a <code>String</code> value.
 */
public class Point
{

    public double x, y;
    public final String name;

    public Point(String name, double x, double y)
    {
        this.name = name;
        this.x    = x;
        this.y    = y;
    }

    @Override
    public String toString()
    {
        double x = ((double) (Math.round(this.x * 100))) / 100;
        double y = ((double) (Math.round(this.y * 100))) / 100;
        return new StringJoiner(", ", "(", ")").add(name).add(Double.toString(x)).add(Double.toString(y)).toString();
    }

    @Override
    public boolean equals(Object o)
    {
        if (this == o) return true;
        if (!(o instanceof Point)) return false;
        Point point = (Point) o;
        if (Double.compare(point.x, x) != 0) return false;
        if (Double.compare(point.y, y) != 0) return false;
        return name.equals(point.name);
    }

    protected Point difference(Point v2)
    {
        return new Point("Difference",this.x - v2.x,this.y-v2.y);
    }

    protected Point shift(double x, double y)
    {
        return new Point(this.name,this.x + x,this.y + y);
    }

    protected boolean isEquivalent(Point v)
    {
        double p1X = ((double) (Math.round(this.x * 100))) / 100;
        double p1Y = ((double) (Math.round(this.y * 100))) / 100;
        double p2X = ((double) (Math.round(v.x * 100))) / 100;
        double p2Y = ((double) (Math.round(v.y * 100))) / 100;

        return p1X == p2X && p1Y == p2Y;


    }



}