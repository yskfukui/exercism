section .deta 
    dash db "-", 0
    largex db "X", 0
    zero db "0", 0
    colon db ":", 0
    largea db "A", 0
    largeb db "B", 0

section .text
global is_valid
is_valid:
    mov rcx, 10
    mov r9, 11
    mov rax, 0
    mov rdx,0
    mov r10, 0
    ; mov al, 0

.loop:
    mov rax, 0
    mov r8, 0
    add al, dl
    
    mov r8, [rdi]

    ; null check
    cmp r8, 0
    je .done

    cmp r8b, byte [rel zero]
    jl .skip


    cmp r8b, byte [rel largex]
    cmove r8, [rel colon]

    call .check_x

    cmp r8b, byte [rel largea]
    jge .error
    
    

   

    sub r8, [rel zero]
    imul r8, rcx
    add al, r8b
    div r9b ;ah = al % r9b (8bit)
    ; add al, ah
    mov dl, ah
    inc rdi
    sub rcx, 1
    cmp rcx, 0
    je .done
    jmp .loop
    ret

.check_x:
    cmp r8b, byte [rel colon]
    jne .just_return
    cmp rcx, 1
    jne .error

.just_return:
    ret

.skip:
    inc rdi
    jmp .loop
    
    ; jmp .loop
.done:
    mov r8, [rdi]
    cmp r8b, 0
    jne .error
    cmp dl, 0
    je .isvalid
    mov rax, 0
    ret
.isvalid:
    mov rax, 1
    ret
.error:
    mov rax, 0
    ret 

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
