#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

uint64_t const SIZE = 0xAD6EA8807E4E4E81;

void main(void) {
    int* array = calloc(SIZE, sizeof(*array));
    for(int i = 0 ; i < SIZE ; i++) {
        array[i] = 0;
    }
}
