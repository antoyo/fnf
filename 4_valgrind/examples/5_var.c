#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int const SIZE = 10;

void main(void) {
    int* ptr = NULL;
    srand(time((void*)ptr));
    ptr = calloc(1, sizeof(*ptr));
    free(ptr);

    int* array = calloc(SIZE, sizeof(*array));
    for(int i = 0 ; i < SIZE ; i++) {
        array[i] = rand();
        time_t new_time = time(NULL);
        int* tmp = &array[i];
        *tmp += new_time;
    }

    *ptr = 42;

    for(int i = 0 ; i < SIZE ; i++) {
        printf("%d\n", array[i]);
    }

    free(array);
}
