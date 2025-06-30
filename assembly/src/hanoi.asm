section .data
    mensagem db "Digite o numero de discos[1-9]: ", 0
    mensagem_len equ $ - mensagem

    mover_disco db "Mova o disco "
    disco db "0"
    da_torre db " da Torre "
    origem db "A"
    para_torre db " para Torre "
    destino db "C"
    newline db 10

    len_mover equ $ - mover_disco
    
    concluido db "Concluido!"
    concluido_len equ $ - concluido

section .bss
    input resb 2
    num_discos resb 1

section .text
    global _start

_start:
    ; Mostrar prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, mensagem
    mov edx, mensagem_len
    int 0x80

    ; Ler input
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 2
    int 0x80

    ; Converter input para número
    mov al, [input]
    sub al, '0'
    mov [num_discos], al

    ; Configurar e chamar Hanoi
    movzx eax, byte [num_discos]  ; Número de discos
    mov ebx, 'A'  ; Origem
    mov ecx, 'C'  ; Destino
    mov edx, 'B'  ; Auxiliar
    call hanoi

    ; Mostrar mensagem de conclusão

    mov eax, 4
    mov ebx, 1
    mov ecx, concluido
    mov edx, concluido_len
    int 0x80

    ;Newline

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Sair
    mov eax, 1
    xor ebx, ebx
    int 0x80

hanoi:
    cmp eax, 0
    je .fim

    push eax
    push ebx
    push ecx
    push edx

    ; Primeira chamada recursiva
    dec eax
    push ecx
    mov ecx, edx  ; Troca destino e auxiliar
    pop edx
    call hanoi

    pop edx
    pop ecx
    pop ebx
    pop eax

    ; Configurar impressão
    push eax
    push ebx
    push ecx
    push edx

    add eax, '0'
    mov [disco], al
    mov [origem], bl
    mov [destino], cl

    ; Imprimir movimento
    mov eax, 4
    mov ebx, 1
    mov ecx, mover_disco
    mov edx, len_mover
    int 0x80

    ; Newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    pop edx
    pop ecx
    pop ebx
    pop eax

    ; Segunda chamada recursiva
    push eax
    push ebx
    push ecx
    push edx

    dec eax
    push ebx
    mov ebx, edx  ; Troca origem e auxiliar
    pop edx
    call hanoi

    pop edx
    pop ecx
    pop ebx
    pop eax

.fim:
    ret
