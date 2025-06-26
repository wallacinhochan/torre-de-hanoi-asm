section .data
    mover_disco     db "mova o disco "
    disco           db "0"
    da_torre        db " da torre "
    origem_label    db "A"
    para_torre      db " para torre "
    destino_label   db "C", 10
    len_total       equ $ - mover_disco

section .text
    global _start

_start:
    ; parâmetros iniciais para hanoi(3, 'A', 'C', 'B')
    mov eax, 3          ; número de discos
    mov ebx, 'A'        ; origem
    mov ecx, 'C'        ; destino
    mov edx, 'B'        ; auxiliar
    call hanoi

    ; saída do programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

; função hanoi(n, origem, destino, auxiliar)
hanoi:
    cmp eax, 0
    je .fim

    ; salva os registradores (estado atual)
    push eax
    push ebx
    push ecx
    push edx

    ; primeira chamada: hanoi(n-1, origem, auxiliar, destino)
    dec eax
    push ecx           ; salva destino
    mov ecx, edx       ; ecx = auxiliar
    pop edx            ; edx = destino original
    call hanoi

    ; restaura estado após primeira chamada
    pop edx
    pop ecx
    pop ebx
    pop eax

    ; imprime o movimento
    push eax
    push ebx
    push ecx

    add eax, '0'
    mov [disco], al
    mov [origem_label], bl
    mov [destino_label], cl
    call imprimir_movimento

    pop ecx
    pop ebx
    pop eax

    ; segunda chamada: hanoi(n-1, auxiliar, destino, origem)
    push eax
    push ebx
    push ecx
    push edx

    dec eax
    push edx
    mov edx, ebx
    pop ebx
    call hanoi

    pop edx
    pop ecx
    pop ebx
    pop eax

.fim:
    ret

; função para imprimir o movimento
imprimir_movimento:
    mov eax, 4
    mov ebx, 1
    mov ecx, mover_disco
    mov edx, len_total
    int 0x80
    ret