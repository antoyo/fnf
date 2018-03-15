// Pointer arithmetic.
#include <stdio.h>

void shift1(char* array) {
    size_t i = 0;
    while(*array != '\0') {
        array[i] = array[++i];
    }
}

void main(void) {
    char string[] = "hello bob";
    shift1(string);
}
