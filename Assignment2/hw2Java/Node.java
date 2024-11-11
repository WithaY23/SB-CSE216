package Assignments.Assignment2.hw2Java;

class Node<T extends Number> extends BinaryTree<T>

{

    private Operator o;
    private BinaryTree<T> left;
    private BinaryTree<T> right;
    public Node(Operator o, BinaryTree<T> l, BinaryTree<T> r)
    {
        this.o = o;
        this.left = l;
        this.right = r;
    }


    public BinaryTree<T> getLeft()
    {
        return left;
    }
    public BinaryTree<T> getRight()
    {
        return right;
    }

    public Operator getOperator()
    {
        return o;
    }

    //can't use general method "next", check individually if its a node or leaf, do respective options
    protected void next()
    {
        System.out.println(o.getSymbol());//print out option always


        if(left instanceof Node)//check if its a node
        {
            ((Node<T>) left).next();
        }
        else if (left instanceof Leaf) //its a leaf
        {
            System.out.println("Left: " + ((Leaf<T>) left).getValue()); //Test value, NOT used in code
        }

        if(right instanceof Node)//similar for right
        {
            ((Node<T>) right).next();
        }
        else if (right instanceof Leaf)
        {
            System.out.println("Right: " + ((Leaf<T>) right).getValue());
        }

    }



}
