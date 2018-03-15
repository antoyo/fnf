#include <stdio.h>
#include <stdint.h>
#include <xmmintrin.h>

#define ARRAY_SIZE 4

void main(void) {
    uint32_t array[] = {
        12, // Size of the array.
        10, 20, 30, 40,
        21, 31, 41, 51,
        0, 0, 0, 0
    };
    __m128i* reg1 = (__m128i*) (array + 1);
    __m128i* reg2 = (__m128i*) (array + 5);
    __m128i* result = (__m128i*) (array + 9);
    __m128i reg3 = _mm_set_epi32(42, 24, 12, 6);
    __m128i reg4 = _mm_add_epi32(*reg1, *reg2);
    *result = _mm_sub_epi32(reg3, reg4);
    printf("%d, %d, %d, %d\n", array[9], array[10], array[11], array[12]);
}
