#include <stdio.h>
#include <dlfcn.h>

int main() {
    printf("main alive\n");
    dlopen("./child.dylib", RTLD_LOCAL | RTLD_NOW);
    printf("loaded child!\n");
}
