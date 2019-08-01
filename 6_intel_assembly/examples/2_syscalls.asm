global main

section .data
    align 2

    message: db 'Hello, World!', 10

section .text
main:
    push rbp
    mov rbp, rsp

    mov rax, 1 ; 1 is write syscall
    mov rdi, 1 ; 1 is stdout
    mov rsi, message
    mov rdx, 14 ; size of message
    syscall     ; <1>
    mov rax, 60 ; 60 is exit syscall
    mov rdi, 0 ; error code of 0
    syscall
    ret
