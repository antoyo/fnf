global main

extern printf

section .data
    align 2

    message: db '%d', 10, 0

section .text

add:
    mov rax, rdi
    add rax, rsi
    ret

add_no_ret:
    mov rax, rdi
    add rax, rsi
    jmp rbx

add_without_ret:
    mov rax, rdi
    add rax, rsi
    pop rbx      ; Pop the return address from the stack.
    jmp rbx      ; <1>

factorial:
    push rbp
    mov rbp, rsp

    ; If parameter <= 0, jump to the label factorial_zero.
    cmp rdi, 0
    jle factorial_zero

    ; Compute the factorial of (n - 1).
    push rdi
    sub rdi, 1
    call factorial
    pop rdi
    ; Multiply n with !(n - 1).
    mul rdi

    jmp factorial_end

factorial_zero:
    mov rax, 1

factorial_end:
    leave
    ret

factorial_no_ret:
    push rbp
    mov rbp, rsp

    cmp rdi, 0
    jle factorial_no_ret_zero

    push rdi
    sub rdi, 1
    mov rbx, factorial_no_ret_return_address
    jmp factorial_no_ret
factorial_no_ret_return_address:
    pop rdi
    mul rdi

    jmp factorial_no_ret_end

factorial_no_ret_zero:
    mov rax, 1

factorial_no_ret_end:
    leave
    jmp rbx

main:
    push rbp
    mov rbp, rsp

    mov rdi, 40
    mov rsi, 2
    call add

    mov rdi, message
    mov rsi, rax
    call printf

    mov rdi, 20
    mov rsi, 1
    call add_without_ret

    mov rdi, message
    mov rsi, rax
    call printf

    mov rdi, 15
    mov rsi, 1
    mov rbx, return_address1
    jmp add_no_ret
return_address1:

    mov rdi, message
    mov rsi, rax
    call printf

    mov rdi, 10
    mov rsi, 1
    push return_address2
    jmp add_without_ret  ; <1>
return_address2:

    mov rdi, message
    mov rsi, rax
    call printf

    ;call try_factorial_no_ret
    call print_array
    mov rdi, 5
    call factorial

    mov rdi, message
    mov rsi, rax
    call printf
    call print_array_without_loop
    mov qword [param1], 40
    mov qword [param2], 2
    call add_data

    mov rdi, message
    mov rsi, rax
    call printf
    call print_array_with_lea
    mov rax, 0
    ret

section .data
    align 8
    param1: dq 0
    param2: dq 0

section .text

add_data:
    mov rax, qword [param1]
    add rax, qword [param2]
    ret

try_factorial_no_ret:
    mov rdi, 5
    mov rbx, return_address3
    jmp factorial_no_ret
return_address3:
    ret

print_array:
    push rbp      ; <1>
    mov rbp, rsp
    sub rsp, 80   ; array of 10 64-bits (8 bytes) integers.

    mov rbx, rsp
    mov r12, 1

print_array_init_loop_start:
    cmp r12, 10
    jg print_array_init_loop_end
    mov qword [rbx], r12
    inc r12
    add rbx, 8       ; <1>
    jmp print_array_init_loop_start

print_array_init_loop_end:

    mov rbx, rsp
    mov r12, 1

print_array_print_loop_start:
    cmp r12, 10
    jg print_array_print_loop_end

    mov rdi, message
    mov qword rsi, [rbx]
    call printf

    inc r12
    add rbx, 8
    jmp print_array_print_loop_start

print_array_print_loop_end:

    leave    ; <1>
    ret

print_array_without_loop:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov rbx, rsp
    mov r12, 1

print_array_without_loop_init_loop_start:
    cmp r12, 10
    jg print_array_without_loop_init_loop_end
    mov qword [rbx], r12
    inc r12
    add rbx, 8       ; <1>
    jmp print_array_without_loop_init_loop_start

print_array_without_loop_init_loop_end:

    mov rbx, rsp

    mov rdi, message
    mov qword rsi, [rbx]
    call printf

    mov rdi, message
    mov qword rsi, [rbx + 8]
    call printf

    mov rdi, message
    mov qword rsi, [rbx + 16]
    call printf

    mov rdi, message
    mov qword rsi, [rbx + 24]
    call printf

    mov rdi, message
    mov qword rsi, [rbx + 32]
    call printf

    mov rdi, message
    mov qword rsi, [rbx + 40]
    call printf

    mov rdi, message
    mov qword rsi, [rbx + 48]
    call printf

    mov rdi, message
    mov qword rsi, [rbx + 56]
    call printf

    mov rdi, message
    mov qword rsi, [rbx + 64]
    call printf

    mov rdi, message
    mov qword rsi, [rbx + 72]
    call printf

    leave
    ret

print_array_with_lea:
    push rbp
    mov rbp, rsp
    sub rsp, 80

    mov rbx, rsp
    mov r12, 1

print_array_with_lea_init_loop_start:
    cmp r12, 10
    jg print_array_with_lea_init_loop_end
    mov qword [rbx], r12
    inc r12
    add rbx, 8
    jmp print_array_with_lea_init_loop_start

print_array_with_lea_init_loop_end:

    mov rbx, rsp

    mov rdi, message
    mov rax, 3
    mov rcx, 8
    mul rcx
    add rax, rcx
    mov qword rsi, [rbx + rax]
    call printf

    mov rdi, message
    mov rax, 3
    lea rsi, [rbx + rax * 8 + 8]
    mov qword rsi, [rsi]
    call printf

    mov rdi, message
    mov rax, 3
    mov rsi, [rbx + rax * 8 + 8]
    call printf

    leave
    ret
