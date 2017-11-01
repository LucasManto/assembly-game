loadn r0, #1099         ; Posicao inicial

rand: var #20
	static rand + #0, #11
	static rand + #18, #12
	static rand + #12, #13
	static rand + #16, #14
	static rand + #13, #15
	static rand + #10, #16
	static rand + #4, #17
	static rand + #6, #18
	static rand + #14, #19
	static rand + #11, #20
	static rand + #15, #21
	static rand + #17, #22
	static rand + #2, #23
	static rand + #8, #24
	static rand + #7, #25
	static rand + #1, #26
	static rand + #5, #27
	static rand + #3, #28
	static rand + #9, #29
	
objs: var #5
	static objs + #0, #20
	static objs + #1, #56
	static objs + #2, #13
	static objs + #3, #66
	static objs + #4, #28
	

printHighway:
	push r0
	push r1
	push r2
	loadn r2, #9
	loadn r7, #31
	loadn r0, #'|'
	loadn r1, #40
	loadn r6, #1231
printAgain:
	outchar r0, r2
	outchar r0, r7
	add r2, r2, r1
	add r7, r7, r1
	cmp r7, r6
	jne printAgain
	pop r2
	pop r1
	pop r0

main:
	
incObs:
	call Delay
	call printObj
	call moveCar
	inc r7

jmp main

printObj:
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r1, #0
	loadn r2, #5
	loadn r3, #objs
	loadn r5, #'0'
	loadn r6, #40
	loadn r7, #' '
	
incCountPrintObj:
	loadi r4, r3
	outchar r7, r4
	add r4, r4, r6
	outchar r5, r4
	storei r3, r4
	inc r3
	inc r1
	cmp r1, r2
	jne incCountPrintObj
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
rts

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


Delay:
	push r1
	push r2
	push r3
	
	loadn r2, #3
	loadn r3, #0
	
loadR1:
	loadn r1, #1000
	
decR1:
	dec r1
	cmp r1, r3
	jne decR1
	
	dec r2
	cmp r2, r3
	jne loadR1
	
	pop r3
	pop r2
	pop r1
	

rts

moveCar:
	
	push r1
	push r2
	push r3
	push r4
	push r5
	
	loadn r1, #'w'          ; Armazena caractere 'w' para comparacao
	loadn r2, #'a'          ; Armazena caractere 'a' para comparacao
	loadn r3, #'s'          ; Armazena caractere 's' para comparacao
	loadn r4, #'d'          ; Armazena caractere 'd' para comparacao
	loadn r5, #' '          ; Armazena caractere ' ' para comparacao

	
	call printCar

    inchar r7           ; Le um valor do teclado e coloca em r7
    cmp r7, r1          ; Compara o valor lido com 'w'
    ceq moveCarT        ; Se for igual, movimenta o carro para cima
    cmp r7, r2          ; Compara o valor lido com 'a'
    ceq moveCarL        ; Se for igual, movimenta o carro para a eraseCar
    cmp r7, r3          ; Compara o valor lido com 's'
    ceq moveCarD        ; Se for igual, movimenta o carro para baixo
    cmp r7, r4          ; Compara o valor lido com 'd'
    ceq moveCarR        ; Se for igual, movimenta o carro para a direita
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	
rts