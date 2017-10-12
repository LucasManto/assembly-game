loadn r0, #1099         ; Posicao inicial
loadn r1, #'w'          ; Armazena caractere 'w' para comparacao
loadn r2, #'a'          ; Armazena caractere 'a' para comparacao
loadn r3, #'s'          ; Armazena caractere 's' para comparacao
loadn r4, #'d'          ; Armazena caractere 'd' para comparacao
loadn r5, #' '          ; Armazena caractere ' ' para comparacao

jmp main

main:

    inchar r7           ; Le um valor do teclado e coloca em r7
    cmp r7, r1          ; Compara o valor lido com 'w'
    ceq moveCarT        ; Se for igual, movimenta o carro para cima
    cmp r7, r2          ; Compara o valor lido com 'a'
    ceq moveCarL        ; Se for igual, movimenta o carro para a eraseCar
    cmp r7, r3          ; Compara o valor lido com 's'
    ceq moveCarD        ; Se for igual, movimenta o carro para baixo
    cmp r7, r4          ; Compara o valor lido com 'd'
    ceq moveCarR        ; Se for igual, movimenta o carro para a direita

jmp main

printCar:
    push r6

    loadn r6, #2
    loadn r7, #40

    outchar r6, r0      ; Imprime a primeira parte do carro
    inc r6              ; Incrementa r6 para mudar o caractere para a segunda parte do carro
    add r0, r0, r7      ; Soma 40 a posicao para imprimir na linha de baixo
    outchar r6, r0      ; Imprime a segunda parte do carro
    sub r0, r0, r7      ; Decrementa 40 para voltar a linha de cima

    pop r6
rts

moveCarT:
    push r6

    loadn r6, #389
    cmp r0, r6          ; Compara com o valor maximo de movimento
    jel dontMoveT       ; Nao realiza a movimentacao

    call eraseCar
    loadn r7, #40
    sub r0, r0, r7
    call printCar

dontMoveT:
    pop r6
rts

moveCarL:
    push r6

    loadn r6, #40
    mod r7, r0, r6      ; Calcula o modulo por 40
    loadn r6, #10       ; Estipula um valor para o carro nao passar
    cmp r7, r6          ; Compara se a posicao é igual ao valor
    jeq dontMoveL       ; Nao realiza a movimentacao

    call eraseCar
    dec r0
    call printCar

dontMoveL:
    pop r6
rts

moveCarD:
    push r6

    loadn r6, #1130
    cmp r0, r6          ; Compara com o valor maximo de movimento
    jeg dontMoveD       ; Nao realiza a movimentacao

    call eraseCar
    loadn r7, #40
    add r0, r0, r7
    call printCar

dontMoveD:
    pop r6
rts

moveCarR:
    push r6

    loadn r6, #40

    mod r7, r0, r6      ; Calcula o modulo por 40
    loadn r6, #30       ; Estipula um valor para o carro nao passar
    cmp r7, r6          ; Compara se a posicao é igual ao valor
    jeq dontMoveR       ; Nao realiza a movimentacao

    call eraseCar
    inc r0              ; Realiza a movimentacao
    call printCar

dontMoveR:
    pop r6
rts

eraseCar:
    loadn r7, #40
    outchar r5, r0      ; Apaga a primeira parte do carro
    add r0, r0, r7      ; Soma 40 a posicao para imprimir na linha de baixo
    outchar r5, r0      ; Apaga a segunda parte do carro
    sub r0, r0, r7      ; Decrementa 40 para voltar a linha de cima
rts