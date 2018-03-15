#include <stdio.h>
#include <string.h>

void main(void) {
    char *string = "hello world";
    string[strlen(string) - 1] = '\0';
    printf("%s\n", string);
}
