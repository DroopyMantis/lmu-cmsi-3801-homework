import { open } from "node:fs/promises"

export function change(amount: bigint): Map<bigint, bigint> {
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let counts: Map<bigint, bigint> = new Map()
  let remaining = amount
  for (const denomination of [25n, 10n, 5n, 1n]) {
    counts.set(denomination, remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then apply function here
export function firstThenApply<T, R>(
  a: T[], 
  p: (element: T) => boolean, 
  f: (element: T) => R
): R | undefined {
  const foundElement: T | undefined = a.find(p);
  return foundElement !== undefined ? f(foundElement) : undefined;
}

// Write your powers generator here
export function* powersGenerator(base: bigint): Generator<bigint, void, unknown> {
  let power = 1n;
  
  while (true) {
    yield power;
    power *= base;
  }
}

// Write your line count function here
import { createReadStream } from "fs";
import * as readline from "readline";

export async function meaningfulLineCount(filePath: string): Promise<number> {
  let count = 0;

  // Create read stream and line reader interface
  const fileStream = createReadStream(filePath, { encoding: "utf-8" });

  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
  });

  // Read lines asynch
  try {
    for await (const line of rl) {
      const trimmedLine = line.trim();
      if (trimmedLine.length > 0 && !trimmedLine.startsWith("#")) {
        count++;
      }
    }
  } catch (err) {
    throw new Error(`Error reading file: ${err}`);
  } finally {
    rl.close(); // Ensure the readline interface is closed
  }

  return count;
}


// Write your shape type and associated functions here
export type Shape = 
  | { kind: "Sphere"; radius: number }
  | { kind: "Box"; width: number; length: number; depth: number };

// Volume
export function volume(shape: Shape): number {
  switch (shape.kind) {
    case "Sphere":
      return (4 / 3) * Math.PI * Math.pow(shape.radius, 3);
    case "Box":
      return shape.width * shape.length * shape.depth;
  }
}

// Surface area
export function surfaceArea(shape: Shape): number {
  switch (shape.kind) {
    case "Sphere":
      return 4 * Math.PI * Math.pow(shape.radius, 2);
    case "Box":
      const { width, length, depth } = shape;
      return 2 * (width * length + length * depth + width * depth);
  }
}


// Write your binary search tree implementation here
export interface BinarySearchTree<T> {
  insert(value: T): BinarySearchTree<T>;
  contains(value: T): boolean;
  size(): number;
  inorder(): Generator<T>;
}

// Empty
export class Empty<T> implements BinarySearchTree<T> {
  insert(value: T): BinarySearchTree<T> {
    return new Node(value, new Empty(), new Empty());
  }

  contains(_: T): boolean {
    return false;
  }

  size(): number {
    return 0;
  }

  *inorder(): Generator<T> {
  }

  toString(): string {
    return "()";
  }
}

// Node
class Node<T> implements BinarySearchTree<T> {
  constructor(
    private readonly value: T,
    private readonly left: BinarySearchTree<T>,
    private readonly right: BinarySearchTree<T>
  ) {}

  insert(newValue: T): BinarySearchTree<T> {
    if (newValue < this.value) {
      return new Node(this.value, this.left.insert(newValue), this.right);
    } else if (newValue > this.value) {
      return new Node(this.value, this.left, this.right.insert(newValue));
    } else {
      return this;
    }
  }

  contains(target: T): boolean {
    if (target < this.value) {
      return this.left.contains(target);
    } else if (target > this.value) {
      return this.right.contains(target);
    } else {
      return true;
    }
  }

  size(): number {
    return 1 + this.left.size() + this.right.size();
  }

  *inorder(): Generator<T> {
    yield* this.left.inorder();
    yield this.value;
    yield* this.right.inorder();
  }

  toString(): string {
    const leftStr = this.left instanceof Empty ? "" : `${this.left}`;
    const rightStr = this.right instanceof Empty ? "" : `${this.right}`;
    return `(${leftStr}${this.value}${rightStr})`.trim();
  }
}
