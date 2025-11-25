section .text
global _start

section .data

msg db 'Hello, world!', 0x0A
len equ $ - msg

_start:
    mov edx, len
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 1
    int 0x80



