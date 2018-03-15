#include <stdio.h>

int fact(int n);

void main(void) {
    int factorial = fact(5);
    printf("%d\n", factorial);
}

int fact(int n) {
    return n * fact(n - 1);
}
