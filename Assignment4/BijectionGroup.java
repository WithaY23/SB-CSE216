package Assignments.Assignment4;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.function.Function;


public class BijectionGroup
{
    // your methods go here

    //return type: List, Set, or Collection, do not know
    protected static <A> List<Function<A,A>> bijectionsOf(Set<A> domain) //A in Set is supposed to be T
    {

        List<A> domainList = new ArrayList<>(domain);

        // Generate all permutations of the domain
        List<List<A>> permutations = permute(domainList);

//        System.out.println("Permutations: " +permutations);

        //create a function for each permutation
        List<Function<A, A>> bijections = new ArrayList<>();
        for (List<A> perm : permutations) {
            bijections.add(createBijection(domainList, perm));
        }

        return bijections;
    }


    //create all possible permutations of size two of elements
    private static <T> List<List<T>> permute(List<T> list)
    {
        if (list.isEmpty())
        {
            return Collections.singletonList(Collections.emptyList());
        }

//        List<List<T>> permutations = new ArrayList<>();





        // Generate permutations by moving each element to each possible position
//        for (int i = 0; i < list.size(); i++)
//        {
//            T first = list.get(i);
//            List<T> rest = new ArrayList<>(list);
//            rest.remove(i);  // Remove the element from the list

        // Permute the rest and insert the first element at every possible position
//            for (List<T> perm : permute(rest))
//            {
//                List<T> newPerm = new ArrayList<>();
//                newPerm.add(first);
//                newPerm.addAll(perm);
//                System.out.println("newPerm: " +newPerm);
//                permutations.add(newPerm);
//                System.out.println("Permutations: " +permutations);
//
//            }


        T first = list.get(0);  // The first element
        List<T> rest = list.subList(1, list.size()); // The rest of the elements
        List<List<T>> restPermutations = permute(rest);

        // Use map to insert `first` into every possible position of each permutation
        return restPermutations.stream()
                .flatMap(perm -> { //flatten all permutations gathered so far
                    List<List<T>> result = new ArrayList<>();
                    for (int i = 0; i <= perm.size(); i++) {
                        List<T> newPerm = new ArrayList<>(perm);
                        newPerm.add(i, first);  // Insert the first element at position i
//                        System.out.println("newPerm: " +newPerm);
                        result.add(newPerm);
//                        System.out.println("Result: " +result);

                    }
                    return result.stream(); //return gathered as stream for flatMap (intermediate)
                })
                .collect(Collectors.toList()); //gather all possible permutations
    }

//        }

//        return permutations;


    //organize the permutations into their respective elements, use unique indices from permutations to do so
    private static <T> Function<T, T> createBijection(List<T> domain, List<T> perm)
    {
        return input -> perm.get(domain.indexOf(input));
    }



    private static <T> BGroup<T> bijectionGroup(Set<T> collection) //dc set vs collection
    {
        return new BGroup<>(collection);
    }



    public static void main(String... args)
    {
        Set<Integer> a_few = Stream.of(1, 2, 3).collect(Collectors.toSet());

        // you have to figure out the data type in the line below
        Collection<Function<Integer,Integer>> bijections = bijectionsOf(a_few); //if apply = Function, bijectionsOf is Collection<Function<A,B>>
        bijections.forEach(aBijection ->
        {
            a_few.forEach(n -> System.out.printf("%d --> %d; ", n, aBijection.apply(n))); //aBijection likely is a function
            System.out.println();
        });

        // you have to figure out the data types in the lines below
        // some of these data types are functional objects
        // so, look into java.util.function.Function
        BGroup<Integer> g = bijectionGroup(a_few); // if 2 is true, bijectionGroup returns a collection/list/... of the Group implemented as a bijection
        Function<Integer,Integer> f1 = bijectionsOf(a_few).stream().findFirst().get(); //likely gets the first element of a containment
        Function<Integer,Integer> f2 = g.inverseOf(f1); //return element within the set of a_few (same group), typeOf(f1) == typeOf(f2) true
        Function<Integer,Integer> id = g.identity(); //same type as f1

        System.out.println("Identity: ");
        a_few.forEach(ele -> System.out.println(ele + "," + id.apply(ele)));

        System.out.println("First function: ");
        a_few.forEach(ele -> System.out.println(ele + "," + f1.apply(ele)));

        System.out.println("Inverse of first function: ");
        a_few.forEach(ele -> System.out.println(ele + "," + f2.apply(ele)));

        Function<Integer, Integer> f3 = bijections.stream().skip(2).findFirst().get();
        Function<Integer,Integer> f4 = g.inverseOf(f3);

        System.out.println("Second function: ");
        a_few.forEach(ele -> System.out.println(ele + "," + f3.apply(ele)));

        System.out.println("Inverse of second function: ");
        a_few.forEach(ele -> System.out.println(ele + "," + f4.apply(ele)));

        System.out.println("Inverse cancellation: ");
        a_few.forEach(ele -> System.out.println(ele + "," + g.binaryOperation(f3,f4).apply(ele)));
        System.out.println("Binary Operation cancellation: ");
        a_few.forEach(ele -> System.out.println(ele + "," + g.binaryOperation(f3,f4).apply(ele)));

        Function<Integer, Integer> f5 = bijections.stream().skip(3).findFirst().get();

        System.out.println("Binary Operation associative: ");
        a_few.forEach(ele -> System.out.println(ele + "," + g.binaryOperation(f5,g.binaryOperation(f3,f4)).apply(ele)));
        a_few.forEach(ele -> System.out.println(ele + "," + g.binaryOperation(g.binaryOperation(f5,f3),f4).apply(ele)));






    }

}
