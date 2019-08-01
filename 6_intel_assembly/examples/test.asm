global main

extern printf

section .data
    align 2

    message: db '%d', 10, 0

section .text

main:
    push rbp
    mov rbp, rsp

    xor rax, rax
    mov ah, 0xFF
    mov al, 0xFF

    mov rdi, message
    mov rsi, rax
    call printf
    mov rax, 0

    ret
