global main

extern printf

section .data
    align 2

    message: db 'sqrt((2 + 17 * 30) / (10 - 2)) = %d', 10, 0

section .bss
    temp: resq 1  ; <1>

section .text

main:
    push rbp
    mov rbp, rsp

    mov rax, 17
    mov rcx, 30
    mul rcx      ; <1>
    add rax, 2   ; <1>

    mov rbx, 10
    sub rbx, 2

    mov rdx, 0 ; <1>
    div rbx    ; <2>

    mov [temp], rax    ; <1>
    fild qword [temp]  ; Push temp to the FPU register stack
    fsqrt
    fistp qword [temp] ; <2>

    mov rdi, message
    mov rsi, [temp]
    call printf
    mov rax, 0

    ret
