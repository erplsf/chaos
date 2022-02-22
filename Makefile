TARGET := i686-elf
CROSSBIN := ~/opt/cross/bin

CC := $(CROSSBIN)/$(TARGET)-gcc
AS := nasm
CXX := $(CROSSBIN)/$(TARGET)-g++

.PHONY: clean

clean:
	rm -f boot.o kernel.o chaos.bin

all: boot.o kernel.o chaos.bin

kernel.o:
	$(CXX) -c kernel.cpp -o kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

boot.o:
	$(AS) -felf32 boot.s -o boot.o

chaos.bin: kernel.o boot.o
	$(CC) -T linker.ld -o chaos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

qemu: chaos.bin
	qemu-system-i386 -vga std -kernel chaos.bin
