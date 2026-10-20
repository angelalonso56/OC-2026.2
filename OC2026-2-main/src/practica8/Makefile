build:
	mkdir -p ../../bin
	nasm -f elf p8.asm -o p8.o
	ld -m elf_i386 -o ../../bin/practica8.exe p8.o

run: build
	../../bin/practica8.exe

clean:
	rm -f p8.o ../../bin/practica8.exe