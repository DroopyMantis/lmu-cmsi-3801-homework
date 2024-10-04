import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

// Write your first then lower case function here
func firstThenLowerCase(of array: [String], satisfying predicate: (String) -> Bool) -> String? {
    return array.first(where: predicate)?.lowercased()
}

// Write your say function here
struct Sayer {
    private var words: [String] = []

    init(_ word: String = "") {
        if !word.isEmpty {
            words.append(word)
        }
    }

    func and(_ word: String) -> Sayer {
        var newSayer = self
        
        if newSayer.words.isEmpty {
            newSayer.words.append("")
        }
        
        newSayer.words.append(word)
        return newSayer
    }

    var phrase: String {
        return words.joined(separator: " ")
    }
}

func say(_ word: String = "") -> Sayer {
    return Sayer(word)
}

// Write your meaningfulLineCount function here
func meaningfulLineCount(_ filename: String) async -> Result<Int, NoSuchFileError> {
    guard let contents = try? String(contentsOfFile: filename) else {
        return .failure(NoSuchFileError())
    }
    return .success(contents.split(separator: "\n").filter { !$0.isEmpty }.count)
}

// Write your Quaternion struct here
struct Quaternion: Equatable, CustomStringConvertible {
    let a: Double
    let b: Double
    let c: Double
    let d: Double

    static let ZERO = Quaternion(a: 0.0, b: 0.0, c: 0.0, d: 0.0)
    static let I = Quaternion(a: 0.0, b: 1.0, c: 0.0, d: 0.0)
    static let J = Quaternion(a: 0.0, b: 0.0, c: 1.0, d: 0.0)
    static let K = Quaternion(a: 0.0, b: 0.0, c: 0.0, d: 1.0)

    init(a: Double = 0.0, b: Double = 0.0, c: Double = 0.0, d: Double = 0.0) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }

    var coefficients: [Double] {
        return [a, b, c, d]
    }

    var conjugate: Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }

    static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(
            a: lhs.a + rhs.a,
            b: lhs.b + rhs.b,
            c: lhs.c + rhs.c,
            d: lhs.d + rhs.d
        )
    }

    static func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(
            a: lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d,
            b: lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c,
            c: lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b,
            d: lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        )
    }

    static func == (lhs: Quaternion, rhs: Quaternion) -> Bool {
        return (lhs.a == rhs.a) && (lhs.b == rhs.b) && (lhs.c == rhs.c) && (lhs.d == rhs.d)
    }

    var description: String {
        if a == 0 && b == 0 && c == 0 && d == 0 {
            return "0"
        }
        
        var terms: [String] = []

        if a != 0 {
            terms.append("\(a)")
        }
        if b != 0 {
            terms.append(b == 1 ? "i" : (b == -1 ? "-i" : "\(b)i"))
        }
        if c != 0 {
            terms.append(c == 1 ? "j" : (c == -1 ? "-j" : "\(c)j"))
        }
        if d != 0 {
            terms.append(d == 1 ? "k" : (d == -1 ? "-k" : "\(d)k"))
        }

        var result = terms[0]
        for term in terms.dropFirst() {
            if term.first == "-" {
                result += term
            } else {
                result += "+\(term)"
            }
        }

        return result.lstrip("+")
    }
}

extension String {
    func lstrip(_ character: Character) -> String {
        var result = self
        while result.first == character {
            result.removeFirst()
        }
        return result
    }
}

// Write your Binary Search Tree enum here
indirect enum BinarySearchTree: CustomStringConvertible, Equatable {
    case empty
    case node(value: String, left: BinarySearchTree, right: BinarySearchTree)

    static func == (lhs: BinarySearchTree, rhs: BinarySearchTree) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty):
            return true
        case let (.node(valueL, leftL, rightL), .node(valueR, leftR, rightR)):
            return valueL == valueR && leftL == leftR && rightL == rightR
        default:
            return false
        }
    }

    var size: Int {
        switch self {
        case .empty:
            return 0
        case let .node(_, left, right):
            return 1 + left.size + right.size
        }
    }

    func insert(_ value: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(value: value, left: .empty, right: .empty)
        case let .node(nodeValue, left, right):
            if value < nodeValue {
                return .node(value: nodeValue, left: left.insert(value), right: right)
            } else {
                return .node(value: nodeValue, left: left, right: right.insert(value))
            }
        }
    }

    func contains(_ value: String) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(nodeValue, left, right):
            if value == nodeValue {
                return true
            } else if value < nodeValue {
                return left.contains(value)
            } else {
                return right.contains(value)
            }
        }
    }

    var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(value, left, right):
            let leftDesc = left == .empty ? "" : "\(left.description)"
            let rightDesc = right == .empty ? "" : "\(right.description)"
            return "(\(leftDesc)\(value)\(rightDesc))"
        }
    }
}