#include <stdio.h>

__attribute__((constructor))
void init() {
    printf("child alive: %s\n", MSG);
}