#include <stdio.h>
#include <stdlib.h>

int const SIZE = 100;

void main(void) {
    int* array = calloc(SIZE, sizeof(*array));
    for(int i = 0 ; i <= SIZE ; i++) {
        array[i] = 42;
    }
    free(array);
}
