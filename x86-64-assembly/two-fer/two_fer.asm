section .data
    prefix db "One for ", 0               ; prefix-format
    suffix db ", one for me.", 0          ; suffix-format
    default_name db "you", 0              ; default name

section .text
global two_fer

; two_fer:
; rdi - argument 1 (name)
; rsi - argument 2 (output buffer)
two_fer:
    ; initialize
    xor rdx, rdx              ; rdx = 0
    mov rcx, 256              
.clear_buffer:
    mov byte [rsi + rdx], 0   ; 
    inc rdx
    cmp rdx, rcx
    jl .clear_buffer          ; 

    lea rdx, [rel prefix]       ; 
    call copy_string        ; 

    call find_end           ; 
    cmp rdi, 0              ; 
    je default_name_set        ; 

    lea rdx, [rdi]          ; 
    call copy_string        ; 

    
    call find_end           ; 
    lea rdx, [rel suffix]   ; 
    call copy_string        ; 

    ; 
    ret

copy_string:
.copy_loop:
    mov al, [rdx]           ; 
    cmp al, 0               ; 
    je .done                ;
    mov [rsi], al           ; 
    inc rdx                 ; 
    inc rsi                 ; 
    jmp .copy_loop          ; 
.done:
    ret


find_end:
.find_end_loop:
    mov al, [rsi]           ; 
    cmp al, 0               ; 
    je .found               ; 
    inc rsi                 ; 
    jmp .find_end_loop      ; 
.found:
    ret

; 
default_name_set:
    lea rdx, [rel default_name] ; 
    call copy_string        ; 
    
    call find_end           ; 
    lea rdx, [rel suffix]   ; 
    call copy_string        ; 
