section .data
        mensagem      db "Digite o numero de discos (1-9): ", 0  
        mensagem_len  equ $ - mensagem                           
        mover_disco db "Mova o disco "                           ; Início da mensagem de movimento
        disco       db " "                                       ; Espaço para o número do disco
        da_torre    db " da torre "                              ; Parte da mensagem
        origem      db " "                                       ; Espaço para a torre de origem
        para_torre  db " para a torre "                          ; Parte da mensagem
        destino     db " "                                       ; Espaço para a torre de destino
        newline     db 10                                        ; Caractere de nova linha
        len_mover   equ $ - mover_disco                          ; Tamanho total da mensagem de movimento
        conclusao   db "Concluido!"                              ; Mensagem de conclusão
        conclusao_len   equ $ - conclusao                        ; Tamanho da mensagem de conclusão

    section .bss
        input       resb 2       ; Buffer para entrada do usuário
        num_discos  resb 1       ; Variável para armazenar o número de discos

    section .text
        global _start

    _start:
        ; Escreve a mensagem pedindo o número de discos
        mov eax, 4                ; Chamada de sistema para write
        mov ebx, 1                ; Descritor de arquivo (stdout)
        mov ecx, mensagem         ; Endereço da mensagem 
        mov edx, mensagem_len   
        int 0x80                  ; Chamada ao kernel

        ; Lê a entrada do usuário
        mov eax, 3                ; Chamada de sistema para read
        mov ebx, 0                ; Descritor de arquivo (stdin)
        mov ecx, input            ; Buffer para armazenar a entrada
        mov edx, 2                ; Número máximo de bytes a serem lidos
        int 0x80                  ; Chamada ao kernel

        ; Converte o caractere ASCII para número e armazena
        mov al, [input]           ; Carrega o caractere digitado
        sub al, '0'               ; Converte de ASCII para valor numérico
        mov [num_discos], al       ; Armazena o número de discos

        ; Configura os parâmetros para a função hanoi
        movzx eax, byte [num_discos] ; Carrega o número de discos (estendendo com zeros)
        mov ebx, 'A'                ; Torre de origem (A)
        mov ecx, 'C'                ; Torre de destino (C)
        mov edx, 'B'                ; Torre auxiliar (B)
        call hanoi                  ; Chama a função recursiva

        ; Escreve a mensagem de conclusão
        mov eax, 4                ; Chamada de sistema para write
        mov ebx, 1                ; Descritor de arquivo (stdout)
        mov ecx, conclusao        ; Mensagem de conclusão
        mov edx, conclusao_len    ; Tamanho da mensagem
        int 0x80                  ; Chamada ao kernel

        ; Escreve uma nova linha
        mov eax, 4                ; Chamada de sistema para write
        mov ebx, 1               ; Descritor de arquivo (stdout)
        mov ecx, newline         ; Caractere de nova linha
        mov edx, 1               ; Tamanho (1 byte)
        int 0x80                 ; Chamada ao kernel

        ; Termina o programa
        mov eax, 1               ; Chamada de sistema para exit
        xor ebx, ebx             ; Código de saída 0
        int 0x80                 ; Chamada ao kernel

    hanoi:
        ; Função recursiva que implementa o algoritmo das Torres de Hanoi
        ; Parâmetros:
        ;   eax - número de discos
        ;   ebx - torre de origem
        ;   ecx - torre de destino
        ;   edx - torre auxiliar
        
        cmp eax, 0                ; Verifica se ainda há discos para mover
        je .fim                   ; Se não, termina a recursão

        ; Passo 1: Move n-1 discos da origem para a auxiliar
        push eax                  ; Salva o estado atual dos registradores
        push ebx
        push ecx
        push edx
        dec eax                   ; Decrementa o número de discos
        xchg ecx, edx             ; Troca destino e auxiliar
        call hanoi                ; Chamada recursiva
        pop edx                   ; Restaura os registradores
        pop ecx
        pop ebx
        pop eax

        ; Passo 2: Move o disco atual da origem para o destino (e imprime)
        push eax
        push ebx
        push ecx
        push edx                  ; Salva edx que será usado na impressão

        ; Prepara os dados para impressão
        add eax, '0'              ; Converte o número do disco para ASCII
        mov [disco], al           ; Armazena no campo disco
        mov [origem], bl          ; Armazena torre origem
        mov [destino], cl         ; Armazena torre destino

        ; Imprime a mensagem de movimento
        mov eax, 4               ; Chamada de sistema para write
        mov ebx, 1               ; Descritor de arquivo (stdout)
        mov ecx, mover_disco     ; Mensagem de movimento
        mov edx, len_mover       ; Tamanho da mensagem
        int 0x80                 ; Chamada ao kernel

        pop edx                  ; Restaura edx
        pop ecx
        pop ebx
        pop eax

        ; Passo 3: Move n-1 discos da auxiliar para o destino
        push eax
        push ebx
        push ecx
        push edx
        dec eax                  ; Decrementa o número de discos
        xchg ebx, edx            ; Troca origem e auxiliar
        call hanoi               ; Chamada recursiva
        pop edx
        pop ecx
        pop ebx
        pop eax

    .fim:
        ret                      ; Retorna da chamada recursiva