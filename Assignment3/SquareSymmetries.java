package Assignments.Assignment3;


import java.util.ArrayList;
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
        for(Square compare : symmetriesOf(s1))
        {
            if(compare.equals(s2))
            {
                return true;
            }
        }
        return false;
    }

    @Override
    public List<Square> symmetriesOf(Square square)
    {
        List<Square> symmetricalSquare = new ArrayList<>();

        symmetricalSquare.add(square);

        symmetricalSquare.add(square.rotateBy(90));
        symmetricalSquare.add(square.rotateBy(180));
        symmetricalSquare.add(square.rotateBy(270));
        //rotations work in test case

        symmetricalSquare.add(square.horizontalReflection());//works in test case
        symmetricalSquare.add(square.verticalReflection());
        symmetricalSquare.add(square.diagonalReflection());//reflect as seen in document
        symmetricalSquare.add(square.counterDiagonalReflection()); //reflect as seen in document
        //reflections work in test case

        return symmetricalSquare;
    }
}