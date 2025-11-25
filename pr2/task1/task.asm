section .data

x db '5'
y db '3'
msg db  "сумма x и y равна "
len equ $ - msg

segment .bss

sum resb 1

section .text

global _start

_start:
    Mov eax, [x]
    Sub eax, '0'
    Mov ebx, [y]
    Sub ebx, '0'
    Add eax, ebx
    Add eax, '0'

    mov  [sum], eax

    mov ecx, msg
    mov edx, len
    mov ebx, 1
    mov eax, 4
    int     0x80

    mov ecx, sum
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int     0x80

    mov eax, 1
    int     0x80