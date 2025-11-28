section .data
    hello_msg db "Hellow"
    hello_msg_len equ $ - hello_msg

section .text
global _start
_start:

    mov     byte [hello_msg+hello_msg_len],'!'

    mov     ecx, hello_msg
    mov     edx, hello_msg_len+1
    mov     ebx, 1
    mov     eax, 4
    int     0x80

    mov     eax, 1
    int     0x80
