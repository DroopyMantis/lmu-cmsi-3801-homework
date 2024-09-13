# CMSI 3801 Homework

## Carson Cabrera (c44rson) and Julian Mazzier (DroopyMantis)

### Homework 1 (Scripting): Lua, Python, JavaScript

- firstThenLowerCase(a, p)

  - Straightforward function that finds the first string in a list (a) that satisfies some condition (p).

- powersGenerator(base, limit)

  - Generator that takes in a base arg and yields powers in order until the arg limit.

- say(word)

  - Kinda tricky.

  - Nested function (or coroutine?) that allows chained calls and prints each call separated by a " ".

  - Took a bit to figure out that we needed to use a helper recursive function "chain".

    - For some reason also took too long to figure out the empty call edge case.

- meaningfulLineCount(filename)

  - Straightforward file reader function.

  - Just read docs and figured out how to close in JS and used python implementation from class to guide.

- class Quaternion

  - Once we figured out what Quaternions were it was pretty smooth sailing.

  - Learned syntactical differences in classes (tables?) between all three languages.

  - Don't really understand what "get" is needed for but it works!

### Homework 2 (Enterprise): Java, Kotlin, Swift

### Homework 3 (Theory): TypeScript, OCaml, Haskell

### Homework 4 (Systems): C, C++, Rust

### Homework 5 (Concurrency): Go

### Lua

```
lua exercises_test.lua
```

### Python

```
python3 exercises_test.py
```

### JavaScript

```
npm test
```

### Java

```
javac *.java && java ExercisesTest
```

### Kotlin

```
kotlinc *.kt -include-runtime -d test.jar && java -jar test.jar
```

### Swift

```
swiftc -o main exercises.swift main.swift && ./main
```

### TypeScript

```
npm test
```

### OCaml

```
ocamlc exercises.ml exercises_test.ml && ./a.out
```

### Haskell

```
ghc ExercisesTest.hs && ./ExercisesTest
```

### C

```
gcc string_stack.c string_stack_test.c && ./a.out
```

### C++

```
g++ -std=c++20 stack_test.cpp && ./a.out
```

### Rust

```
cargo test
```

### Go

```
go run restaurant.go
```
