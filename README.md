# macOS Big Sur sig9 kill reproducer

macOS Big Sur on apple silicon requires codesigned libraries.  The default linker will ad-hoc codesign all objects created, but there appears to be a cache somewhere that keeps track of what has been loaded previously.  This cache seems to be emptied upon deletion of a file, but appears to become out-of-sync if a new (valid) codesigned object is copied over a previous one.  As an example, when running `make install` while developing a library.

This can be easily seen with the following minimal reproducer, which has a main program (`main.c`) who simply `dlopen()`'s a child (`child.c`).  The child gets built twice, with two configurations, and executing the `make run` recipe will showcase the following behavior:

```
$ make run
cp original/child.dylib child.dylib
First run:
./main
main alive
child alive: original
loaded child!
cp clone/child.dylib child.dylib
Second run:
./main
main alive
make: *** [run] Killed: 9
```

Note that there is a commented line in `Makefile` that will 'work around' the problem by first `rm`'ing `child.dylib`.