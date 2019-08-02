global main

extern printf

section .data
    align 2

    message: db '%d', 10, 0
    msg1: db 'before', 10, 0
    msg2: db 'after', 10, 0

    num: dq 42

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

    xor rax, rax

    push rax
    push 0

    cmp rsp, rax
    cmp rsp, 0

    lea eax, [ebx + 8 * ecx - 1000]

    mov eax, ecx
    shl eax, 3
    add eax, ebx
    sub eax, 1000

    mov rcx, 8
    mul rcx

    shl rax, 3

    xor rax, rax
    cmp rax, 0

    jz after

    mov rdi, msg1
    call printf

after:
    mov rdi, msg2
    call printf

    mov qword [num], 10

    pop rax
    pop rax
    pop rbp

    ret
