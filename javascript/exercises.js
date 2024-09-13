import { doesNotMatch } from "node:assert"
import { open } from "node:fs/promises"
import { basename } from "node:path"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then lower case function here
export function firstThenLowerCase(strings, predicate) {
  const first = strings.find(predicate)
  return first?.toLowerCase()
}

// Write your powers generator here
export function* powersGenerator({ ofBase, upTo }) {
  let power = 1
  while (power <= upTo) {
    yield power
    power *= ofBase
  }
}

// Write your say function here
export function say(word) {
  const words = []
  function chain(next_word) {
    if (next_word !== undefined) {
      words.push(next_word)
      return chain
    }
    return words.join(" ")
  }
  if (word !== undefined) {
    words.push(word)
    return chain
  }
  return ""
}

// Write your line count function here
export async function meaningfulLineCount(filename) {
  let count = 0
  let file
  try {
    file = await open(filename, "r")
    for await (const line of file.readLines()) {
      if (line.trim() !== "" && !line.trim().startsWith("#")) {
        count++
      }
    }
    await file.close()
    return count
  } catch (error) {
    throw new Error("File not found.")
  }
}

// Write your Quaternion class here
export class Quaternion {
  constructor(a, b, c, d) {
    this.a = a
    this.b = b
    this.c = c
    this.d = d
    Object.freeze(this)
  }

  get coefficients() {
    return [this.a, this.b, this.c, this.d]
  }

  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d)
  }

  plus(other) {
    return new Quaternion(
      this.a + other.a,
      this.b + other.b,
      this.c + other.c,
      this.d + other.d
    )
  }

  times(other) {
    return new Quaternion(
      this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
      this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
      this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
      this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
    )
  }

  toString() {
    const terms = []
    if (this.a !== 0) {
      terms.push(`${this.a}`)
    }
    if (this.b !== 0) {
      terms.push(`${this.b === 1 ? "" : this.b === -1 ? "-" : this.b}i`)
    }
    if (this.c !== 0) {
      terms.push(`${this.c === 1 ? "" : this.c === -1 ? "-" : this.c}j`)
    }
    if (this.d !== 0) {
      terms.push(`${this.d === 1 ? "" : this.d === -1 ? "-" : this.d}k`)
    }

    if (terms.length === 0) {
      return "0"
    }
    let result = terms[0]
    for (let i = 1; i < terms.length; i++) {
      if (terms[i][0] === "-") result += terms[i]
      else result += `+${terms[i]}`
    }
    if (result[0] === "+") {
      result = result.slice(1)
    }
    return result
  }
}
