package Assignments.Assignment3;

import java.util.function.Predicate;


/*
"Parameterizes" FiniteGroupOfOrderTwo, declaring the elements in the set.
Only can have values -1 or 1
 */
class PlusOrMinusOne implements Group<Integer>
{

    //Variables
    //using predicate for test of valid numbers
    private static final Predicate<Integer> valid = n -> n==-1 || n==1;
    Integer num;


    //Constructors
    PlusOrMinusOne(){};
    PlusOrMinusOne(Integer n)
    {
        if (!valid.test(n))
        {
            this.num = n;
        }
        else
        {
            throw new IllegalArgumentException("The number must be valid within the set");
        }


    }



    //Methods
    @Override
    public Integer binaryOperation(Integer x, Integer y) //preserves closure of items through multiplication
    {
        if (valid.test(x) && valid.test(y)) //validate provided inputs are elements within the set
        {
            return x * y;
        }
        else
        {
            throw new IllegalArgumentException("The number must be valid within the set");
        }
    }

    //verify that the provided value is within the set range, once it is validated,
    // it will not be invalid given the operations of the set

    //Replaced by predicate
//    private boolean valid(Integer n)
//    {
//        return n == 1 || n == -1;
//    }

    @Override
    public Integer identity()
    {
        return num;
    }

    @Override
    public Integer inverseOf(Integer n) //preserves closure of items in the set
    {
        return -n;
    }

    //list of valid values, can update predicate to match the values
    protected static PlusOrMinusOne[] values()
    {
        return new PlusOrMinusOne[]{new PlusOrMinusOne(-1), new PlusOrMinusOne(1)};
    }

    @Override
    public String toString()
    {
        return String.valueOf(num);
    }

}
public class FiniteGroupOfOrderTwo extends PlusOrMinusOne
{
    //inverse override, takes plusorminus one's returns plusorminusone
    public FiniteGroupOfOrderTwo()
    {


    }

    //utilizing set elements, do an operation. Elements will still be valid after
    public PlusOrMinusOne binaryOperation(PlusOrMinusOne x, PlusOrMinusOne y)
    {
        return new PlusOrMinusOne(binaryOperation(x.num,y.num));
    }
}