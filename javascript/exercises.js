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
