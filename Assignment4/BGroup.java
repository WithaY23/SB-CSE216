package Assignments.Assignment4;

import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

public class BGroup<T> implements Group<Function<T,T>>
{
    //variable declaration
    private Set<T> domain; //domain allowed for the set
    private Collection<Function<T,T>> bijections; //bijections found with domain

    public BGroup(Set<T> set)
    {
        this.domain = set;
        this.bijections = BijectionGroup.bijectionsOf(set); //gather all bijections
    }

    @Override
    public Function<T, T> binaryOperation(Function<T, T> one, Function<T, T> other)
    {
        return t-> one.apply(other.apply(t));
    }

    @Override
    public Function<T,T> identity() //return bijection that returns identity i->i, j->j, k->k ...
    {
        return t-> t;
//        return new Function<T,T>()
//        {
//            @Override
//            public T apply(T element)
//            {
//                return element;
//            }
//        };
    }

    @Override
    public Function<T,T> inverseOf(Function<T,T> f)
    {
        Map<T,T> map = domain.stream() //apply function f on all elements
                .collect(Collectors
                        .toMap(f::apply, identity()));  //switch function output and input, represent input as identity
        return map::get; //ele -> map.get(ele);

//        return new Function<T,T>()
//        {
//            @Override
//            public T apply(T ele)
//            {
//               return map.get(ele);
//            }
//        };
    }
}