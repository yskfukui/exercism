section .text
global square_root
square_root:
    ; Provide your implementation here
    mov rsi, 1
    mov rbx, rdi
    
calculate_sqrt:
    mov rax, rsi
    imul rax, rsi

    cmp rax, rbx
    je .found_sqrt

    inc rsi
    jmp calculate_sqrt

.found_sqrt:
    mov rax, rsi
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
