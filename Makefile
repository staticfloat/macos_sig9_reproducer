CC ?= clang


main: main.c
	$(CC) -o $@ $<

original/child.dylib: child.c
	@mkdir -p original
	$(CC) -shared -o $@ '-DMSG="original"' $<

clone/child.dylib: child.c
	@mkdir -p clone
	$(CC) -shared -o $@ '-DMSG="clone"' $<

run: main original/child.dylib clone/child.dylib
	@rm -f child.dylib
	cp original/child.dylib child.dylib
	@echo "First run:"
	./main
	@# Uncomment the following line to work around the problem
	#rm child.dylib
	cp clone/child.dylib child.dylib
	@echo "Second run:"
	./main

clean:
	rm -rf main child.dylib original clone