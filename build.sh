#!/bin/bash

set -eu

printf "Compiling loader.s...\n"
nasm -f elf32 loader.s

printf "Linking kernel.elf...\n"
ld -T link.ld -melf_i386 loader.o -o kernel.elf

cp kernel.elf iso/boot/

printf "Making iso...\n"

genisoimage -R                              \
            -b boot/grub/stage2_eltorito    \
            -no-emul-boot                   \
            -boot-load-size 4               \
            -A os                           \
            -input-charset utf8             \
            -quiet                          \
            -boot-info-table                \
            -o cragos.iso                   \
            iso

# bochs -f bochsrc.txt -q
# enter 'c' at <bochs:1> prompt
