import java.io.File
import java.io.IOException

fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }

    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}

// Write your first then lower case function here
fun firstThenLowerCase(a: List<String>, p: (String) -> Boolean): String? {
    return a.firstOrNull { p(it) }?.lowercase()
}

// Write your say function here
fun say(): Say {
    return Say("") // Initialize empty phrase
}

fun say(word: String): Say {
    return Say(word) // Initialize with the provided word
}

class Say(private val currentPhrase: String) {

    fun and(word: String): Say {
        // Chainable and
        val newPhrase = if (currentPhrase.isEmpty()) {
            if (word.isEmpty()) " " else word // Handle empty phrase
        } else {
            currentPhrase + if (word.isEmpty()) " " else " $word" // Append space and word
        }
        return Say(newPhrase) // Return new instance with updated phrase
    }

    // Read only
    val phrase: String
        get() = currentPhrase
}

// Write your meaningfulLineCount function here
@Throws(IOException::class)
fun meaningfulLineCount(filename: String): Long {
    // Check if file exists before trying to read it
    val file = File(filename)
    if (!file.exists()) {
        throw IOException("No such file")
    }

    return file.bufferedReader().use { reader ->
        reader.lineSequence().count { line ->
            val trimmed = line.trim()
            trimmed.isNotEmpty() && !trimmed.startsWith("#")
        }.toLong()
    }
}

// Write your Quaternion data class here
data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {

    init {
        require(!a.isNaN() && !b.isNaN() && !c.isNaN() && !d.isNaN()) {
            "Coefficients cannot be NaN"
        }
    }

    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

    // Coefficients
    fun coefficients(): List<Double> {
        return listOf(a, b, c, d)
    }

    // Addition
    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(
            a + other.a,
            b + other.b,
            c + other.c,
            d + other.d
        )
    }

    // Multiplication
    operator fun times(other: Quaternion): Quaternion {
        return Quaternion(
            a * other.a - b * other.b - c * other.c - d * other.d,
            a * other.b + b * other.a + c * other.d - d * other.c,
            a * other.c - b * other.d + c * other.a + d * other.b,
            a * other.d + b * other.c - c * other.b + d * other.a
        )
    }

    // Conjugate
    fun conjugate(): Quaternion {
        return Quaternion(a, -b, -c, -d)
    }

    // toString
    override fun toString(): String {
        val str = StringBuilder()

        if (a != 0.0) str.append(a)

        if (b != 0.0) {
            if (b > 0 && str.isNotEmpty()) str.append("+")
            str.append(if (b == 1.0) "i" else if (b == -1.0) "-i" else "$b" + "i")
        }

        if (c != 0.0) {
            if (c > 0 && str.isNotEmpty()) str.append("+")
            str.append(if (c == 1.0) "j" else if (c == -1.0) "-j" else "$c" + "j")
        }

        if (d != 0.0) {
            if (d > 0 && str.isNotEmpty()) str.append("+")
            str.append(if (d == 1.0) "k" else if (d == -1.0) "-k" else "$d" + "k")
        }

        return if (str.isEmpty()) "0" else str.toString()
    }
}

// Write your Binary Search Tree interface and implementing classes here
sealed interface BinarySearchTree {

    // Returns number of elements in tree
    fun size(): Int

    // Inserts new element into tree
    fun insert(value: String): BinarySearchTree

    // Checks if tree contains element
    fun contains(value: String): Boolean

    // Generates string representation of tree
    override fun toString(): String

    // Empty
    object Empty : BinarySearchTree {
        override fun size(): Int = 0

        override fun insert(value: String): BinarySearchTree = Node(value, Empty, Empty)

        override fun contains(value: String): Boolean = false

        override fun toString(): String = "()"
    }

    // Node
    data class Node(
        val value: String,
        val left: BinarySearchTree = Empty,
        val right: BinarySearchTree = Empty
    ) : BinarySearchTree {
        override fun size(): Int = 1 + left.size() + right.size()

        override fun insert(newValue: String): BinarySearchTree {
            return when {
                newValue < value -> Node(value, left.insert(newValue), right)
                newValue > value -> Node(value, left, right.insert(newValue))
                else -> this // No duplicates, return current node
            }
        }

        override fun contains(searchValue: String): Boolean {
            return when {
                searchValue < value -> left.contains(searchValue)
                searchValue > value -> right.contains(searchValue)
                else -> true // Found value
            }
        }

        override fun toString(): String {
            return when {
                left == Empty && right == Empty -> "($value)"
                left == Empty -> "($value$right)"
                right == Empty -> "($left$value)"
                else -> "($left$value$right)"
            }
        }
    }
}