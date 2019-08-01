global main       ; <1>

extern printf     ; <2>

section .data     ; <3>
    align 2       ; <4>

    message: db 'Hello, World!', 10, 0    ; <5>

section .text

main:                    ; <1>
    push rbp
    mov rbp, rsp

    mov rdi, message     ; <2>
    call printf
    mov rax, 0           ; <3>

    leave
    ret
