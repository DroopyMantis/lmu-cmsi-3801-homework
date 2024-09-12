from dataclasses import dataclass
from collections.abc import Callable
from typing import Optional


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


# Write your first then lower case function here
def first_then_lower_case(a: str, p: bool, /) -> Optional[str]:
    for string in a:
        if p(string):
            return string.lower()
    return None

# Write your powers generator here
def powers_generator(*, base, limit) -> int:
    exponent = 0
    while base ** exponent <= limit:
        yield base ** exponent
        exponent += 1

# Write your say function here
def say(word = None, /) -> str:
    if word == None:
        return ""

    words = []

    def chain(next_word = None):
        if next_word is not None:
            words.append(next_word)
            return chain
        else:
            return ' '.join(words)

    if word is not None:
        words.append(word)

    return chain

# Write your line count function here
def meaningful_line_count(filename, /) -> int:
    count = 0
    try:
        with open(filename, "r") as f:
            for x in f:
                x_trunc = x.strip()
                if x_trunc and x_trunc[0] != "#":
                    count += 1
    except FileNotFoundError:
        raise FileNotFoundError('No such file')

    return count

# Write your Quarternion class here
@dataclass(frozen = True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float
    
    @property
    def coefficients(self, /) -> tuple:
        return (self.a, self.b, self.c, self.d)

    @property
    def conjugate(self, /) -> "Quaternion":
        return Quaternion(self.a, -self.b, -self.c, -self.d)
    
    def __add__(self, other: "Quaternion", /) -> "Quaternion":
        return Quaternion(
            self.a + other.a, 
            self.b + other.b, 
            self.c + other.c, 
            self.d + other.d)

    def __mul__(self, other: "Quaternion", /) -> "Quaternion":
        return Quaternion(
            self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d,
            self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c,
            self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b,
            self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
        )

    def __eq__(self, other: "Quaternion", /) -> "Quaternion":
        return (self.a == other.a) and (self.b == other.b) and (self.c == other.c) and (self.d == other.d)

    def __str__(self, /) -> str:
        terms = []
        if self.a != 0:
            terms.append(f"{self.a}")
        if self.b != 0:
            if self.b == 1:
                terms.append("i")
            elif self.b == -1:
                terms.append("-i")
            else:
                terms.append(f"{self.b}i")
        if self.c != 0:
            if self.c == 1:
                terms.append("j")
            elif self.c == -1:
                terms.append("-j")
            else:
                terms.append(f"{self.c}j")
        if self.d != 0:
            if self.d == 1:
                terms.append("k")
            elif self.d == -1:
                terms.append("-k")
            else:
                terms.append(f"{self.d}k")

        if not terms:
            return "0"

        result = terms[0]
        for term in terms[1:]:
            if term[0] == "-":
                result += term
            else:
                result += f"+{term}"

        if result[0] == "+":
            result = result[1:]
        
        return result