package Assignments.Assignment3;
import java.util.*;
import java.util.function.BiFunction;
//import java.util.function.Consumer;

public class HigherOrderUtils

{
    //T: First type of argument
    //U: Second type of argument
    //R: Return type of argument
    //Mimic a bifunction in java
    public static interface NamedBiFunction<T,U,R> extends BiFunction<T,U,R>
    {
        String name();
    }

    //create instances of NamedBiFunction with relevant operations
    public static NamedBiFunction<Double,Double,Double> add = new NamedBiFunction<Double, Double, Double>()
    {
        @Override
        public String name()
        {
            return "plus";
        }

        @Override
        public Double apply(Double x, Double y)
        {
            return x+y;
        }
    };

    public static NamedBiFunction<Double,Double,Double> subtract = new NamedBiFunction<Double,Double,Double>()
    {
        @Override
        public String name()
        {
            return "minus";
        }

        @Override
        public Double apply(Double x, Double y)
        {
            return x-y;
        }


    };

    public static NamedBiFunction<Double,Double,Double> multiply = new NamedBiFunction<Double,Double,Double>()
    {
        @Override
        public String name()
        {
            return "mult";
        }

         @Override
        public Double apply(Double x, Double y)
        {
            return x * y;
        }



    };

    public static NamedBiFunction<Double,Double,Double> divide= new NamedBiFunction<Double,Double,Double>()
    {
        @Override
        public String name()
        {
            return "div";
        }

        @Override
        public Double apply(Double numerator, Double denominator)
        {
            if (denominator == 0)
            {
                throw new ArithmeticException("Division by zero");
            }
            return numerator/denominator;
        }




    };





    /**
     * Professor description:
     * Applies a given list of bifunctions -- functions that take two arguments of a certain type
     * and produce a single instance of that type -- to a list of arguments of that type. The
     * functions are applied in an iterative manner, and the result of each function is stored in
     * the list in an iterative manner as well, to be used by the next bifunction in the next
     * iteration. For example, given
     * List<Double> args = Arrays.asList(-0.5, 2d, 3d, 0d, 4d), and
     * List<NamedBiFunction<Double, Double, Double>> bfs = Arrays.asList(add, multiply, add, divide),
     * <code>zip(args, bfs)</code> will proceed as follows:
     * - the result of add(-0.5, 2.0) is stored in index 1 to yield args = [-0.5, 1.5, 3.0, 0.0, 4.0]
     * - the result of multiply(1.5, 3.0) is stored in index 2 to yield args = [-0.5, 1.5, 4.5, 0.0, 4.0]
     * - the result of add(4.5, 0.0) is stored in index 3 to yield args = [-0.5, 1.5, 4.5, 4.5, 4.0]
     * - the result of divide(4.5, 4.0) is stored in index 4 to yield args = [-0.5, 1.5, 4.5, 4.5, 1.125]
     *
     * @param args the arguments over which <code>bifunctions</code> will be applied.
     * @param bifunctions the list of bifunctions that will be applied on <code>args</code>.
     * @param <T> the type parameter of the arguments (e.g., Integer, Double)
     * @return the item in the last index of <code>args</code>, which has the final result
     * of all the bifunctions being applied in sequence.
     *
     * @throws IllegalArgumentException if the number of bifunction elements and the number of argument
     * elements do not match up as required.
     */


    //using ? extends BiFunction<T, T, T> to include both BiFunction and NamedBiFunction
    public static <T> T zip(List<T> args, List<? extends BiFunction<T, T, T>> bifunctions)
    {
        if(bifunctions.size() != args.size() -1)
            throw new IllegalArgumentException("Size of lists are invalid");
        if (bifunctions.isEmpty())
            return args.get(0); //only one element, technically the arguments "match up as required"

        //set the "accumulator" to the first element of args
        T acc = args.get(0);

        List<T> argsCopy = new LinkedList<T>(args); //maintain "functional" style
        //shouldn't need to as the code represents a side effect of affecting the outside args list.



        //used to iterate through the list with modifications
        ListIterator<T> iterateArg = argsCopy.listIterator(1);



        //the length of iterateArg and bifunctions are now the same, they will "run out" of elements at the same time
        for(BiFunction<T,T,T> function : bifunctions)
        {
           acc =  function.apply(acc,iterateArg.next());// apply the function value
            iterateArg.set(acc); //store accumulator accordingly
        }

        return acc; //the last value is stored in the accumulator, return that
    };




    public static void main(String... args)
    {
        //professors comment and test code
        List<Double> numbers = Arrays.asList(-0.5, 2d, 3d, 0d, 4d); // documentation example
        List<NamedBiFunction<Double, Double, Double>> operations = Arrays.asList(add,multiply,add,divide);
        Double d = zip(numbers, operations); // expected correct value: 1.125
        // different use case, not with NamedBiFunction objects
        List<String> strings = Arrays.asList("a", "n", "t");
        // note the syntax of this lambda expression
        BiFunction<String, String, String> concat = (s, t) -> s + t;
        String s = zip(strings, Arrays.asList(concat, concat)); // expected correct value: "ant"



        //personal custom test cases
       System.out.println("First double: " + d);
       System.out.println("First string: " + s);

       //4 elements total, 3 bifunctions needed
       List<String> strings1 = Arrays.asList(s,"s are", " small", " creatures!");
       System.out.println("Second string: " + zip(strings1,Arrays.asList(concat, concat, concat)));

       //invalid size difference
       List<Double> numbers1 = Arrays.asList(2.,3.,5.);
       System.out.println("Invalid size difference: " + zip(numbers1,operations));

       //no elements in instance of BiFunctions
       List<Double> numbers2 = Arrays.asList(1.);
       List<NamedBiFunction<Double,Double,Double>> operations1 = new ArrayList<>();
       System.out.println("No elements provided: " + zip(numbers2,operations1));
       List<Double> numbers3 = Arrays.asList(0d,0d,0d,0d,0d);
       System.out.println(zip(numbers3,operations)); //div by zero error




    }




}