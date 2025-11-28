section .data

x1 dd 0x07b72
y1 dd 0x02A1

msg1 db  'Сумма чисел 07b72 и 02A1 равна '
msg1_len equ $-msg1

x2 dd 0x102c
y2 dd 0x42

msg2 db  'Разность чисел 102c и 42 равна '
msg2_len equ $-msg2

line_msg db  0x0A
line_msg_len equ $-line_msg

section .text

global _start

_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, msg1_len
int 80h


mov eax, [x1]
add eax, [y1]
push eax
call print_hex

mov eax, 4
mov ebx, 1
mov ecx, line_msg
mov edx, line_msg_len
int 80h


mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, msg2_len
int 80h

mov eax, [x2]
add eax, [y2]
push eax
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
