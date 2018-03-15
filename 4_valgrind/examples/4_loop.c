#include <stdio.h>
#include <stdlib.h>

int const SIZE = 100;

void main(void) {
    int* array = calloc(SIZE, sizeof(*array));
    int end;
    for(int i = 0 ; i <= end ; i++) {
        array[i] = 42;
    }
    free(array);
}
