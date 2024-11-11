package Assignments.Assignment2.hw2Java;

abstract class Shape
{
    P p; //set of floats similar to the one expressed in OCaml
        //if the type point were replaced by float *float, class P would not be necessary

    public Shape(float x, float y)
    {
       this.p = new P(x,y);

    }

    abstract P center();

    abstract float area();

    @Override //separate for
    public String toString()
    {
        return "The center is: " + this.center() + "\n The area is: " + this.area();
    }

    class P
    {
        float x;
        float y;

        protected P(float x, float y)
        {
            this.x = x;
            this.y = y;
        }

        protected float getX()
        {
            return x;
        }

        protected float getY()
        {
            return y;
        }

        protected void setX(float x)
        {
            this.x = x;
        }

        protected void setY(float y)
        {
            this.y = y;
        }

        @Override //separate for
        public String toString()
        {
            return "(" + x + ", " + y + ")";
        }




    }

}

