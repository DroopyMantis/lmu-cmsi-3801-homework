#include <stdexcept>
#include <memory>
#include <algorithm>
using namespace std;

#define MAX_CAPACITY 32768
#define INITIAL_CAPACITY 16

template <typename T>
class Stack {
private:
    unique_ptr<T[]> elements; // pointer to array of elements
    size_t capacity;          // capacity of the array
    size_t top;               // next available slot

    Stack(const Stack&) = delete;
    Stack& operator=(const Stack&) = delete;

    // resize stack
    void reallocate(size_t new_capacity) {
        if (new_capacity > MAX_CAPACITY) {
            throw overflow_error("Stack has reached maximum capacity");
        }
        if (new_capacity < INITIAL_CAPACITY) {
            new_capacity = INITIAL_CAPACITY;
        }

        // new array and copy elements
        unique_ptr<T[]> new_elements = make_unique<T[]>(new_capacity);
        copy(elements.get(), elements.get() + top, new_elements.get());

        // replace old array with new
        elements = move(new_elements);
        capacity = new_capacity;
    }

public:
    // constructor
    Stack()
        : elements(make_unique<T[]>(INITIAL_CAPACITY)),
          capacity(INITIAL_CAPACITY),
          top(0) {}

    // Get size of stack
    size_t size() const {
        return top;
    }

    // check if empty
    bool is_empty() const {
        return top == 0;
    }

    // check if full
    bool is_full() const {
        return top == capacity;
    }

    // push element onto stack
    void push(const T& value) {
        if (is_full()) {
            if (capacity >= MAX_CAPACITY) {
                throw overflow_error("Stack has reached maximum capacity");
            }
            reallocate(min(capacity * 2, static_cast<size_t>(MAX_CAPACITY)));
        }
        elements[top++] = value;
    }

    // pop element
    T pop() {
        if (is_empty()) {
            throw underflow_error("cannot pop from empty stack");
        }
        return elements[--top];
    }
};
