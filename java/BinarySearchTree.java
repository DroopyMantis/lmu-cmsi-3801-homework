public sealed interface BinarySearchTree permits Empty, Node {

    // Returns the size of the tree
    int size();

    // Checks if the tree contains a specific value
    boolean contains(String value);

    // Inserts a new value into the tree and returns a new tree
    BinarySearchTree insert(String value);

    // Returns a string representation of the tree
    String toString();
}
