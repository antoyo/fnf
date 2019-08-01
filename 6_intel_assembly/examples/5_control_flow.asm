global main

extern printf

section .data
    align 2

    message1: db '10 <= 32', 10, 0
    message2: db '10 > 32', 10, 0
    message3: db '%d', 10, 0
section .text

main:
    push rbp
    mov rbp, rsp

    mov rax, 10
    mov rbx, 32

    cmp rax, rbx   ; <1>
    jg else        ; <2>
then:
    mov rdi, message1  ; '10 <= 32'
    jmp end
else:
    mov rdi, message2  ; '10 > 32'
end:

    call printf

    mov rbx, 0

loop_start:
    cmp rbx, 5
    jg loop_end        ; <1>

    mov rdi, message3  ; '%d'
    mov rsi, rbx
    call printf

    inc rbx
    jmp loop_start     ; <2>

loop_end:

    mov rax, 0

    leave
    ret
