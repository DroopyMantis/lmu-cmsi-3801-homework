#include "string_stack.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define INITIAL_CAPACITY 16  // Starting capacity for the stack

// struct for stack
typedef struct _Stack {
    char** elements;  // Dynamic array of strings
    int capacity;     // Current capacity of the stack
    int top;          // Index of the next available slot
} _Stack;

// create new stack
stack_response create() {
    stack_response res;
    stack s = (stack)malloc(sizeof(_Stack));
    if (!s) {
        res.code = out_of_memory;
        res.stack = NULL;
        return res;
    }

    s->elements = (char**)malloc(INITIAL_CAPACITY * sizeof(char*));
    if (!s->elements) {
        free(s);
        res.code = out_of_memory;
        res.stack = NULL;
        return res;
    }

    s->capacity = INITIAL_CAPACITY;
    s->top = 0;

    res.code = success;
    res.stack = s;
    return res;
}

// get size
int size(const stack s) {
    return s ? s->top : 0;
}

// check if empty
bool is_empty(const stack s) {
    return s ? s->top == 0 : true;
}

// check if full
bool is_full(const stack s) {
    return s ? s->top == MAX_CAPACITY : false;
}

// push onto stack
response_code push(stack s, char* item) {
    if (!s || !item) return out_of_memory;

    if (strlen(item) >= MAX_ELEMENT_BYTE_SIZE) {
        return stack_element_too_large;
    }

    if (is_full(s)) {
        return stack_full;
    }

    if (s->top == s->capacity) {
        int new_capacity = s->capacity * 2;
        if (new_capacity > MAX_CAPACITY) {
            new_capacity = MAX_CAPACITY;
        }

        char** new_elements = (char**)realloc(s->elements, new_capacity * sizeof(char*));
        if (!new_elements) {
            return out_of_memory;
        }

        s->elements = new_elements;
        s->capacity = new_capacity;
    }

    // allocate mem
    s->elements[s->top] = (char*)malloc(strlen(item) + 1);
    if (!s->elements[s->top]) {
        return out_of_memory;
    }

    strcpy(s->elements[s->top], item);
    s->top++;
    return success;
}

// pop from stack
string_response pop(stack s) {
    string_response res;
    if (!s || is_empty(s)) {
        res.code = stack_empty;
        res.string = NULL;
        return res;
    }

    // return top element
    res.string = s->elements[--s->top];
    res.code = success;

    return res;
}

// destroy stack, free allocated memory
void destroy(stack* s) {
    if (!s || !*s) return;

    for (int i = 0; i < (*s)->top; i++) {
        free((*s)->elements[i]);
    }

    free((*s)->elements);
    free(*s);
    *s = NULL;
}