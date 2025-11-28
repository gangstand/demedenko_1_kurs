section .data

input_x_msg db "Ввведите x: ", 0x0A
input_x_msg_len equ $-input_x_msg

input_y_msg db "Ввведите y: ", 0x0A
input_y_msg_len equ $-input_y_msg

sum_msg db "Сумма x и y равна "
sum_msg_len equ $-sum_msg

mul_msg db "Произведение x и y равно "
mul_msg_len equ $-mul_msg

nline_msg db 0x0A
nline_msg_len equ $-nline_msg

section .bss
buffer resb 20

x resb 4
y resb 4

sum resb 4
mult resb 4

section .text
global _start
_start:

mov eax, 4
mov ebx, 1
mov ecx, input_x_msg
mov edx, input_x_msg_len
int 80h

call scan_int
mov [x], eax

mov eax, 4
mov ebx, 1
mov ecx, input_y_msg
mov edx, input_y_msg_len
int 80h

call scan_int
mov [y], eax

mov eax, [x]
mov ebx, [y]

add eax, ebx
mov [sum], eax

mov eax, 4
mov ebx, 1
mov ecx, sum_msg
mov edx, sum_msg_len
int 80h

mov eax, [sum]
push eax
call print_int

mov eax, 4
mov ebx, 1
mov ecx, nline_msg
mov edx, nline_msg_len
int 80h

mov eax, [x]
mov edx, [y]
mul edx
mov [mult], eax

mov eax, 4
mov ebx, 1
mov ecx, mul_msg
mov edx, mul_msg_len
int 80h

mov eax, [mult]
push eax
call print_int

mov eax, 1
int 80h

call print_int

mov eax, 1
mov ebx, 0
int 0x80

scan_int:

    mov eax, 3
    mov ebx, 1
    mov ecx, buffer
    mov edx, 20
    int 0x80

    mov ecx, buffer
    xor eax, eax

.parse:
    mov bl, [ecx]
    cmp bl, 0x0A
    je .done

    mov edx, 10
    mul edx
    sub bl, '0'
    add eax, ebx

    inc ecx
    jmp .parse

.done:
    ret

print_int:

push ebp
mov ebp, esp

mov ecx, [ebp+8]

xor edx, edx
mov esi, 10

mov edi, 18

mov byte [buffer + 18], 0xA
mov byte [buffer + 19], 0

.loop:
mov eax, ecx
xor edx, edx
div esi
mov ecx, eax


add edx, '0'
dec edi
mov byte [buffer+edi], dl
cmp ecx, 0
jne .loop

mov eax, 4
mov ebx, 1
mov ecx, buffer
add ecx, edi
mov edx, 19
sub edx, edi
int 0x80

leave
ret