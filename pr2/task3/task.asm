section .data

msg db "сумма x и y равна "
len equ $ - msg

section .bss

x resb 1
y resb 1
sum resb 1
space resb 1

section .text
global _start

_start:
    mov eax, 3
    mov ebx, 0
    mov ecx, x
    mov edx, 1
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, space
    mov edx, 1
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, y
    mov edx, 1
    int 0x80

    mov al, [x]
    sub al, '0'
    mov bl, [y]
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [sum], al

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, sum
    mov edx, 1
    int 0x80

    mov eax, 1
    int 0x80