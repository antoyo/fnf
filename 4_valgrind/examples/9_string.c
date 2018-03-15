#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int const SIZE = 7;

void main(void) {
    char* name = calloc(SIZE, sizeof(*name));
    strcpy(name, "Hi ");
    strcpy(name + 3, "Bob");
    char exclam = '!';
    strcpy(name + SIZE - 1, &exclam);
    printf("%s\n", name);
}
