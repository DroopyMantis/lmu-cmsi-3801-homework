import java.io.FileNotFoundException;
import java.nio.file.Paths;
import java.util.*;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

    // Write your first then lower case function here
    static Optional<String> firstThenLowerCase(List<String> a, Predicate<String> p) {
        return a.stream() // Convert list to stream
                .filter(p) // Filter stream, keep elements that satisfy p
                .map(String::toLowerCase) // Lowercase all that pass filter
                .findFirst(); // Return first element as optional
    }

    // Write your say function here
    public static Say say() {
        return new Say(""); // Initialize with an empty phrase
    }

    public static Say say(String word) {
        return new Say(word); // Initialize with provided word
    }

    public static class Say {
        private final String phrase; // Store phrase

        public Say(String phrase) {
            this.phrase = phrase; // Handle empty/non-empty phrases
        }

        public Say and(String word) {
            // Chainable and to append words
            String newPhrase; // Create a new instance with updated phrase
            if (phrase.isEmpty()) {
                newPhrase = word.isEmpty() ? " " : word; // If current phrase is empty
            } else {
                newPhrase = phrase + (word.isEmpty() ? " " : " " + word); // Append space and new word
            }
            return new Say(newPhrase); // Return a new instance
        }

        // Read only method
        public String phrase() {
            return phrase;
        }
    }

    // Write your line count function here
    public static long meaningfulLineCount(String filename) throws IOException {
        System.out.println("Trying to read from: " + Paths.get(filename).toAbsolutePath().toString());

        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            return reader.lines()
                    .filter(line -> !line.trim().isEmpty())  // Filter out empty and whitespace lines
                    .filter(line -> line.trim().charAt(0) != '#')  // Filter out lines starting with #
                    .count();  // Count lines
        } catch (FileNotFoundException e) {
            throw new FileNotFoundException("No such file: " + filename);
        }
    }
}

