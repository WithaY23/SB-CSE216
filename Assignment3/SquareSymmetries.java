package Assignments.Assignment3;


import java.util.Collection;
import java.util.Collections;
import java.util.List;

//<B extends Square>
public class SquareSymmetries implements Symmetries<Square>//<A extends Shape>
{




    @Override
    public boolean areSymmetric(Square s1, Square s2)
    {
        //create list of symmetries for one of them, if the other isn't included then false
        return false;
    }

    @Override
    public List<Square> symmetriesOf(Square square)
    {
        //8 symmetries, just do them
        return Collections.emptyList();
    }
}