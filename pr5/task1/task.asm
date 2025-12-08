section .data
    ; "Кульпинов Никита Алексеевич"
    fio db 0xD0,0x9A,0xD1,0x83,0xD0,0xBB,0xD1,0x8C,0xD0,0xBF,0xD0,0xB8,0xD0,0xBD,0xD0,0xBE,0xD0,0xB2,0x20,0xD0,0x9D,0xD0,0xB8,0xD0,0xBA,0xD0,0xB8,0xD1,0x82,0xD0,0xB0,0x20,0xD0,0x90,0xD0,0xBB,0xD0,0xB5,0xD0,0xBA,0xD1,0x81,0xD0,0xB5,0xD0,0xB5,0xD0,0xB2,0xD0,0xB8,0xD1,0x87
    fio_len equ $-fio

    ; "ПРИZS-3102"
    key db 0xD0,0x9F,0xD0,0xA0,0xD0,0x98,0x5A,0x53,0x2D,0x33,0x31,0x30,0x32
    key_len equ $-key

    key_text db "ПРИZS-3102"
    key_text_len equ $-key_text

    newline db 10
    spacechar db " "
    hexbuf db "00"


    hex_encode_msg db "Шифр в 16-ной системе такой: "
    hex_encode_msg_len equ $-hex_encode_msg

    encode_msg db "Если вывести текстом то получится мессиво: "
    encode_msg_len equ $-encode_msg

    decode_msg db "Декодируем обратно: "
    decode_msg_len equ $-decode_msg

section .bss
    encode_value resb 256
    decode_value resb 256

section .text
global _start
_start:


mov esi, fio
mov edi, encode_value
mov ecx, fio_len

encrypt_loop:

   mov eax, esi
   sub eax, fio
   xor edx, edx
   mov ebx, key_len
   div ebx

   mov bl, [key + edx]

   mov al, [esi]
   xor al, bl
   mov [edi], al

   inc esi
   inc edi
   loop encrypt_loop



mov ecx, hex_encode_msg
mov edx, hex_encode_msg_len
call print

mov esi, encode_value
mov ecx, fio_len
call print_hex_chars

mov ecx, newline
mov edx, 1
call print

mov esi, encode_value
mov edi, decode_value
mov ecx, fio_len

decrypt_loop:
    mov eax, esi
    sub eax, encode_value
    xor edx, edx
    mov ebx, key_len
    div ebx

    mov bl, [key + edx]

    mov al, [esi]
    xor al, bl
    mov [edi], al

    inc esi
    inc edi
    loop decrypt_loop

mov ecx, decode_msg
mov edx, decode_msg_len
call print

mov ecx, decode_value
mov edx, fio_len
call print

mov eax,1
xor ebx,ebx
int 0x80


print:
    mov eax,4
    mov ebx,1
    int 0x80
    ret


print_hex_chars:

.hex_print_loop:
    mov al, [esi]
    call .print_hex
    call .print_space

    inc esi
    loop .hex_print_loop
    ret

.print_hex:
    pushad

    mov bl, al

    mov al, bl
    shr al, 4
    call nibble_to_hex
    mov [hexbuf], al


    mov al, bl
    and al, 0x0F
    call nibble_to_hex
    mov [hexbuf+1], al


    mov eax, 4
    mov ebx, 1
    mov ecx, hexbuf
    mov edx, 2
    int 0x80

    popad
    ret

.print_space:
    pushad

    mov ecx, spacechar
    mov edx, 1
    call print

    popad
    ret

nibble_to_hex:
    cmp al, 9
    jbe .digit
    add al, 'A' - 10
    ret
.digit:
    add al, '0'
    ret
