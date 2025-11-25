section .text
global _start

msg1 db "Я учусь на специальности программная инженерия",0x0A
len1 equ $-msg1

msg2 db "Я в группе ПРИZS-3102",0x0A
len2 equ $-msg2

msg3 db "!!!!!!!!!!!!!!!!!!!!",0x0A
len3 equ $-msg3

section .data

_start:
    mov edx, len1
    mov ecx, msg1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len2
    mov ecx, msg2
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len3
    mov ecx, msg3
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 1
    int 0x80


