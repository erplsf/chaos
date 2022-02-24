TARGET := i686-elf
CROSSBIN := ~/opt/cross/bin

CC := $(CROSSBIN)/$(TARGET)-gcc
AS := nasm
CXX := $(CROSSBIN)/$(TARGET)-g++

.PHONY: clean all

clean:
	rm -f *.o *.bin

all: boot.o gdt.o kernel.o

kernel.o:
	$(CXX) -c kernel.cpp -o kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

boot.o:
	$(AS) -felf32 boot.s -o boot.o

gdt.o:
	$(AS) -felf32 gdt.s -o gdt.o

chaos.bin: all
	$(CC) -T linker.ld -o chaos.bin -ffreestanding -O2 -nostdlib boot.o gdt.o kernel.o -lgcc

qemu: chaos.bin
	qemu-system-i386 -vga std -kernel chaos.bin
