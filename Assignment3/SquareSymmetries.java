package Assignments.Assignment3;


import java.util.*;

//Class to validate symmetries of Squares
public class SquareSymmetries implements Symmetries<Square>
{




    @Override
    public boolean areSymmetric(Square s1, Square s2)
    {
        //create list of symmetries for one of them, if the other isn't included then false
//        for(Square compare : symmetriesOf(s1))
//        {
//            if(compare.equals(s2))
//            {
//                return true;
//            }
//        }
//        return false;
        // Create lists of points for both squares
        List<Point> pointsOne = s1.toList();

        List<Point> pointsTwo = s2.toList();

        boolean pointMatch; //flag if points don't match

        //check for all point equivalency
        for (Point pointOne : pointsOne)
        {
            pointMatch = false; // set flag
            //check by coordinates if points are equal, implement in Point
            Iterator<Point> iterator = pointsTwo.iterator();
            while (iterator.hasNext())
            {
                Point pointTwo = iterator.next();
                //check if vertexes are equal
                if (pointOne.isEquivalent(pointTwo))
                {
                    pointMatch = true;
                    iterator.remove(); //remove the point from the inner list
                    break;
                }
            }
            //no match found, return false
            if (!pointMatch)
            {
                return false;
            }
        }

        return true;
//        return s1.isSymmetric(s2);
    }

    //find all symmetries of a provided square
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

    //methods from Square class that form symmetries, use them here
    protected Square horizontalReflection(Square sq)
    {
        //double v = sq.toList().get(0).x;
        return sq.horizontalReflection();
    }

    protected Square verticalReflection(Square sq)
    {
        return sq.verticalReflection();
    }
    protected Square diagonalReflection(Square sq)
    {
        return sq.diagonalReflection();
    }

    //swap opposite points of diagonalReflection, not a clear distinction just opposite
    protected Square counterDiagonalReflection(Square sq)
    {
        return sq.counterDiagonalReflection();
    }


}