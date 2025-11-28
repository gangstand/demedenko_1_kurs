section .data

str1 db  'Here is string 1', 0x0A
str1_len    equ $ - str1

pi dw  0x123d

ksi dd  0x12345678

ksi2   dd  'acde'

section .bss

mem resb    12800

section .text

global _start

_start:
mov eax, 4
mov ebx, 1
mov ecx, str1
mov edx, str1_len
int 80h


mov ecx, str1_len

.l:
mov esi, ecx
mov al, byte [str1+esi]
mov byte [mem+esi], al
loop .l

mov esi, ecx
mov al, byte [str1+esi]
mov byte [mem+esi], al


Mov eax, 4
Mov ebx, 1
Mov ecx, mem
Mov edx, str1_len
int 80h

push 1234abc1h
call print_hex


Mov eax, 1
Mov ebx, 0
int 80h

print_hex:
push ebp
mov ebp, esp
sub esp, 8h
Mov ecx, [ebp+8]
Mov esi, 8

.loop:
Mov eax, ecx
And eax, 0xf

Cmp al, 9
jle .print_decimal
.print_hex:
Sub al, 10
add al, 'a'
jmp .print1
.print_decimal:
Add al, '0'
.print1:
Dec esi
Mov byte [esp+esi], al
Shr ecx, 4
jz  .ret
jmp .loop
.ret:
Mov eax, 4
Mov ebx, 1
Mov ecx, esp
Mov edx, 8
int 80h
leave
ret
