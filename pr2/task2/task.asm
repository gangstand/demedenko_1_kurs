section .text

section .data
x1 db '2'
y1 db '7'
msg1 db "2 + 7 = "
len1 equ $ - msg1

x2 db '8'
y2 db '5'
msg2 db "8 - 5 = "
len2 equ $ - msg2

a db '1'
b db '3'
c db '4'
msg3 db "1 + 3 + 4 = "
len3 equ $ - msg3

newline db 0x0A

section .bss
sum1 resb 1
dif1 resb 1
sum3 resb 1

global _start

_start:
    mov eax, [x1]
    sub eax, '0'
    mov ebx, [y1]
    sub ebx, '0'
    add eax, ebx
    add eax, '0'
    mov [sum1], eax

    mov ecx, msg1
    mov edx, len1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, sum1
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, newline
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [x2]
    sub eax, '0'
    mov ebx, [y2]
    sub ebx, '0'
    sub eax, ebx
    add eax, '0'
    mov [dif1], eax

    mov ecx, msg2
    mov edx, len2
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, dif1
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, newline
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [a]
    sub eax, '0'
    mov ebx, [b]
    sub ebx, '0'
    mov ecx, [c]
    sub ecx, '0'

    add eax, ebx
    add eax, ecx
    add eax, '0'
    mov [sum3], eax

    mov ecx, msg3
    mov edx, len3
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, sum3
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, newline
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 1
    int 0x80



