package Assignments.Assignment2.hw2Java;

class Rectangle extends Shape
{
    P p2;

    public Rectangle(float x1, float y1, float x2, float y2)
    {
        super(x1,y1);
        this.p2 = new P(x2,y2);
    }

    public Rectangle(Point a, Point b)
    {
        super(a.p.getX(),a.p.getY());
        this.p2 = new P(b.p.getX(),b.p.getY());
    }



    @Override
    P center()
    {
        //( ( x2 "+" x1 ) / 2, ( y2 "+" y1 ) / 2 )?
        return new P ((float) (Math.round((p.getX() + p2.getX()) / 2 * 100)) / 100 ,
                    (float) (Math.round((p.getY() + p2.getY()) / 2 * 100)) / 100);
    }

    @Override
    float area()
    {
        float width= p.getX() - p2.getX();
        float height = p.getY() - p2.getY();
        return width * height;
    }


}
