public final class Node implements BinarySearchTree {
    private final String value;
    private final BinarySearchTree left;
    private final BinarySearchTree right;

    // Constructor
    public Node(String value, BinarySearchTree left, BinarySearchTree right) {
        this.value = value;
        this.left = left;
        this.right = right;
    }

    @Override
    public int size() {
        return 1 + left.size() + right.size();
    }

    // Check if node tree contains a value
    @Override
    public boolean contains(String value) {
        int cmp = this.value.compareTo(value);
        if (cmp == 0) {
            return true;
        } else if (cmp > 0) {
            return left.contains(value);
        } else {
            return right.contains(value);
        }
    }

    // Insert new value into node tree
    @Override
    public BinarySearchTree insert(String value) {
        int cmp = this.value.compareTo(value);
        if (cmp > 0) {
            return new Node(this.value, left.insert(value), right); // Insert in the left subtree
        } else if (cmp < 0) {
            return new Node(this.value, left, right.insert(value)); // Insert in the right subtree
        } else {
            return this; // If the value already exists, return the same tree
        }
    }

    // String representation
    @Override
    public String toString() {
        String leftStr = left instanceof Empty ? "" : left.toString();
        String rightStr = right instanceof Empty ? "" : right.toString();
        // Correctly format the string representation to match expected results
        return "(" + leftStr + value + rightStr + ")";
    }
}