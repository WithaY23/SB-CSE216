package Assignments.Assignment2.hw2Java;

//Question 8


enum Operator
{
    ADD("+"),
    SUBTRACT("-"),
    MULTIPLY("*"),
    DIVIDE("/");
    private final String symbol;
    Operator(String symbol) { this.symbol = symbol; }
    public String getSymbol() { return symbol; }
}







public class ArithmeticExpression
{
    public static <T extends Number> double evaluate(BinaryTree<T> tree) 
    {
        if (tree instanceof Leaf) 
        { //if it's a leaf, return its value
            return ((Leaf<T>) tree).getValue().doubleValue();
        } else if (tree instanceof Node) 
        { //it's a node, process it
            Node<T> node = (Node<T>) tree;
            double leftValue = evaluate(node.getLeft()); //evaluate left
            double rightValue = evaluate(node.getRight()); //evaluate right
    
            switch (node.getOperator()) //combine and evaluate based on operator
            { 
                case ADD:
                    return ((double)Math.round((leftValue + rightValue) * 100)) / 100;
                case SUBTRACT:
                    return (double)Math.round((leftValue - rightValue) * 100)/ 100;
                case MULTIPLY:
                    return (double)Math.round((leftValue * rightValue) * 100) / 100;
                case DIVIDE:
                    if (rightValue == 0) 
                    {
                        throw new ArithmeticException("Division by zero");
                    } 
                    return (double)Math.round((leftValue / rightValue) * 100) / 100;
                default:
                   { throw new IllegalArgumentException("Invalid tree");}
                    
            }
        }

        else
        {
            throw new IllegalArgumentException("Invalid tree");
        }
    }
    





    public static void main(String[] args) 
    {
        BinaryTree<Integer> expressionTree = new Node<>(
        Operator.ADD,
        new Leaf<>(1),
        new Node<>(Operator.MULTIPLY, new Leaf<>(2), new Leaf<>(3)));
        double result = evaluate(expressionTree);
        System.out.println("Result of expression: " + result);


        // Constructing another expression: (1.5 + 0.75) - 0.25
        BinaryTree<Double> secondTree = new Node<>
        (
        Operator.SUBTRACT,
        new Node<>(Operator.ADD, new Leaf<>(1.5), new Leaf<>(0.75)),
        new Leaf<>(0.25));
        double secondResult = evaluate(secondTree);
        System.out.println("Result of another expression: " + secondResult);


        // Constructing for expression: (5 / 2)
        BinaryTree<Integer> thirdTree = new Node<>(
                Operator.DIVIDE,
                new Leaf<>(5),
                new Leaf<>(2)
        );
        double thirdResult = evaluate(thirdTree);
        System.out.println("Result of third expression: " + thirdResult);
        // it is ok if the output is 2.5 in this third test
        // BinaryTree<Integer> fourthTree = new Leaf<>(5);
                
    }
    
    















}



