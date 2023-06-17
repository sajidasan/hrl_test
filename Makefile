all: main

main: main.o
	gcc -Wall -std=c99 -o main main.o

main.o: main.c
	gcc -Wall -std=c99 -c main.c

.PHONY: clean

clean:
	rm -f main main.o
