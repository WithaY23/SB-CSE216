package Assignments.Assignment2.hw2Java;

class Leaf<T extends Number> extends BinaryTree<T>

{

    private T value;
    public Leaf(T n)
    {
        this.value = n;
    }

    public T getValue()
    {
        return value;
    }

    public void setValue(T value)
    {
        this.value = value;
    }
}