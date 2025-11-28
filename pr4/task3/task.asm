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

call scan_int;
mov [x], eax

mov eax, 4
mov ebx, 1
mov ecx, input_y_msg
mov edx, input_y_msg_len
int 80h

call scan_int;
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
call print_int;

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
call print_int;

mov eax, 1
int 80h

call print_int; напечатать int, который находится в вершине стека
; в стандартный поток вывода
; "callfunc" эквивалентно
;    push<адрес_следующей_инструкции>;
;    jmpfunc

mov eax, 1; Эти три строчки эквиваленты exit(0)
mov ebx, 0;
int 0x80;

scan_int:
    ; читаем до 20 байт в buffer
    mov eax, 3          ; sys_read
    mov ebx, 1          ; stdin
    mov ecx, buffer
    mov edx, 20
    int 0x80            ; eax = количество прочитанных байт

    ; ecx будет указателем на buffer
    mov ecx, buffer
    xor eax, eax        ; eax = 0 (будем накапливать число)

.parse:
    mov bl, [ecx]
    cmp bl, 0x0A        ; '\n'?
    je .done

    mov edx, 10
    mul edx
    sub bl, '0'
    add eax, ebx

    inc ecx
    jmp .parse

.done:
    ret

print_int:; функция печати целого числа в stdout
; аргумент (4-байтовое целое число)
; находится в вершине стека
; ebp содержит адрес начала stackframe
; esp содержит адрес вершины стека
; esp<ebp, то есть вершина имеет меньший адрес
; в начале по адресам (ebp-4, ebp-3, ebp -2, ebp -1) лежат
; четыре байта целого числа, которое нам передали
; в качестве аргумента

push ebp; поместим в стек адрес начала стека
; этот push автоматически делает esp -= 4
mov ebp, esp; теперь ebp равно esp

; аргументы находятся по адресу ebp + 8
mov ecx, [ebp+8]; значение переданного нам целого числа поместим в ecx

xor edx, edx; обнулим edx
mov esi, 10; на 10 мы будем делить.

mov edi, 18; символы-цифры нашего числа мы будем помещать
; поадресам buffer + 17, buffer+16, buffer+15, ...

mov byte [buffer + 18], 0xA; 19-й и 20-й символы — это перенос строчки
mov byte [buffer + 19], 0; и символ конца строки

.loop:
mov eax, ecx;
xor edx, edx; данные четыре строки дают
div esi;   ecx = ecx / 10
mov ecx, eax;


add edx, '0'; '0' ассемблером интерпретируется как ASCII код символа '0'
dec edi
mov byte [buffer+edi], dl
cmp ecx, 0
jne .loop

mov eax, 4        ; эквивалентно write( 1, buffer + edi, 19 - edi )
mov ebx, 1
mov ecx, buffer   ; можнокороче — lea ecx, [buffer+edi]
add ecx, edi
mov edx, 19
sub edx, edi
int 0x80

leave; эквивалентноmovesp, ebp
;               popebp
ret; эквивалентно  pop IP
;
