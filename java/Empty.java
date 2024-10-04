public final class Empty implements BinarySearchTree {

    // Size of the empty tree
    @Override
    public int size() {
        return 0;
    }

    // Check if the empty tree contains a value (always false)
    @Override
    public boolean contains(String value) {
        return false;
    }

    // Insert a new value into the empty tree
    @Override
    public BinarySearchTree insert(String value) {
        return new Node(value, this, this);
    }

    // String representation of the empty tree
    @Override
    public String toString() {
        return "()";
    }
}