package Assignments.Assignment2.hw2Java;

class Circle extends Shape
{
    float radius;

    public Circle(float x, float y, float r)
    {
        super(x,y);
        this.radius = r;
    }

    public Circle(Point a, float r)
    {
        super(a.p.getX(),a.p.getY());
        this.radius = r;
    }

    @Override
    P center()
    {
        return p;
    }

    @Override
    float area()
    {
        return (float) Math.round((Math.PI * Math.pow(radius,2)) * 100) / 100;
    }

}
