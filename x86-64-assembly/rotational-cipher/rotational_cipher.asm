section .data
    smallz db "z", 0
    space db " ", 0
    zero db "0", 0
    nine db "9", 0
    largea db "A", 0
    largez db "Z", 0
    smalla db "a", 0

section .text
global rotate
; rdi - argument 1 (text)
; rsi - argument 2 (rotation)
; rdx - argument 3 (output buffer)
rotate:
    ; Provide your implementation here
    xor r8, r8
    mov r9, 256
.clear_buffer:
    mov byte [rdx + r8], 0
    inc r8
    cmp r8 , r9
    jl .clear_buffer

    mov r8, rdi
    mov r9, rsi
    call copy_string
    ret

copy_string:
.copy_loop:
    mov al, [r8]
    mov cl, al
    cmp al, 0
    je .done
    call .add_rotation
    call .rotate_lower
    mov [rdx], al        
    inc r8
    inc rdx
    jmp .copy_loop
.done:
    ret

.add_rotation:
    cmp al, [rel space]
    je .done_rotate
    cmp al, [rel largea]
    jl .done_rotate
    add al, sil
    ret

.rotate_lower:
    cmp al, [rel largez]
    jbe .done_rotate
    cmp al, [rel smallz]
    jbe .check_case
    sub al, 26
    ret

.check_case:
    cmp cl, [rel smalla]
    jge .done_rotate
    sub al, 26
    ret

.done_rotate:
    ret
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
