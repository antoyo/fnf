#include <stdio.h>

#define SIZE 1000000000

void main(void) {
    int array[SIZE] = {0};
    for(int i = 0 ; i < SIZE ; i++) {
        printf("%d\n", array[i]);
    }
}
