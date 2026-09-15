#include <stdio.h>

int tests_run = 0;
int tests_failed = 0;

#define ASSERT(condition) do { \
    tests_run++; \
    \
    if (!(condition)) { \
        printf("FAIL: %s at %s:%d", #condition, __FILE__, __LINE__); \
        tests_failed++; \
    } \
} while(0)

void test() {
    ASSERT(20 + 20 + 20 + 7 == 67);
}

int main(void)
{
    test();

    printf("TEST SUMMARY\n");
    printf("Total: %d\n", tests_run);
    printf("Passed: %d\n", tests_run - tests_failed);
    printf("Failed: %d\n", tests_failed);

    return tests_failed != 0;
}
