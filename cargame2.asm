; Mensagens padrão
msgLose: string "You Lose! - Press [Space] to continue"
msgStart: string "Press [Space] to Start"
msgScore: string "Score"
msgWin: string "Voce venceu! Xupa Federupa!"

; Strings para imprimir a 'imagem' na tela inicial
linhaIni0: string "   `-------`                            "
linhaIni1: string "   ohhhhhhho              .yyyyyyys     "
linhaIni2: string ":::oyyhhhhho````````      :hhhhhhhh /// "
linhaIni3: string "sssssshdhhhyssssssss/     -hhhhhhhh.yyy`"
linhaIni4: string "ssssssydyssssssssssso`     ```s+`` `yyy`"
linhaIni5: string "ssssssyyssssssysssyyyyso++//::s+.``.yyy`"
linhaIni6: string "ssssssyyssssshdssyddddddsssssssssssssss:"
linhaIni7: string "ssssssyyssssshdssyddddddsssssssssssssss:"
linhaIni8: string "ssssssyyssssssysssyyyyso++//::s+.``.yyy`"
linhaIni9: string "ssssssydyssssssssssso`     ```s+`` `yyy`"
linhaIni10: string "sssssshdhhhyssssssss/     -hhhhhhhh.yyy`"
linhaIni11: string ":::oyyhhhhho````````      :hhhhhhhh /// "
linhaIni12: string "   ohhhhhhho              .yyyyyyys     "
linhaIni13: string "   `-------`                            "

Inicio:

call StartScreen
call printScore

	loadn r0, #1099         ; Posicao inicial
	loadn r1, #0			; Contador do vetor de posições de objetos
	loadn r2, #0			; Contador da pontuação
	loadn r3, #500			; Limite da pontuação

rand: var #40				; Vetor de posições aleatórias dos objetos
	static rand + #0, #141
	static rand + #1, #96
	static rand + #2, #147
	static rand + #3, #54
	static rand + #4, #94
	static rand + #5, #16
	static rand + #6, #136
	static rand + #7, #137
	static rand + #8, #146
	static rand + #9, #13
	static rand + #10, #99
	static rand + #11, #18
	static rand + #12, #22
	static rand + #13, #60
	static rand + #14, #64
	static rand + #15, #134
	static rand + #16, #102
	static rand + #17, #103
	static rand + #18, #61
	static rand + #19, #14
	static rand + #20, #66
	static rand + #21, #145
	static rand + #22, #107
	static rand + #23, #92
	static rand + #24, #17
	static rand + #25, #12
	static rand + #26, #140
	static rand + #27, #19
	static rand + #28, #95
	static rand + #29, #11
	static rand + #30, #62
	static rand + #31, #142
	static rand + #32, #101
	static rand + #33, #63
	static rand + #34, #100
	static rand + #35, #59
	static rand + #36, #52
	static rand + #37, #105
	static rand + #38, #108
	static rand + #39, #51
	
objs: var #10				; Vetor que armazena os 10 objetos simultâneos na tela
	static objs + #0, #0
	static objs + #1, #0
	static objs + #2, #0
	static objs + #3, #0
	static objs + #4, #0	
	static objs + #5, #0	
	static objs + #6, #0	
	static objs + #7, #0	
	static objs + #8, #0	
	static objs + #9, #0	
	
call LoadVector				; Função para carregar o vetor no inicio

printHighway:				; Função que imprime a pista
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
	inc r2					; Incremento da pontuação
	cmp r2, r3				; Compara para saber se o jogo terminou
	jeq WinScreen			; Se terminou, pula para a tela de jogo ganho
	call PrintScore			; Imprime a pontuação
	call printObj			; Imprime objetos
	call moveCar			; Movimenta o carro
	inc r7

jmp main

printObj:					; Funcao que imprime os objetos
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r1, #0			; Inicia o iterador
	loadn r2, #10			; Limite do iterador
	loadn r3, #objs			; Armazena a posicao inicial do vetor de objetos
	loadn r5, #'z'			; Armazena o caractere z para impressão (foi modificado para um quadrado que é o objeto)
	loadn r6, #40			; Armazena 40 para incremento
	loadn r7, #' '			; Armazena espaço para apagar objeto
	
incCountPrintObj:
	loadi r4, r3			; Carrega o valor da posicao de r3 para r4
	call ShouldIEraseOrShouldINot		; Funcao que verifica se o objeto ainda esta na tela
	add r4, r4, r6			; Soma 40 a posicao do objeto
	call ShouldIPrintOrShouldINot		; Funcao que verifica se o objeto ainda esta na tela
	cmp r4, r0				; Compara a ponteiro do objeto com o carro, para saber se houve colisao
	jeq Lose				; Se houve colisao, pula para Lose
	storei r3, r4			; Armazena o novo valor da posicao do objeto
	inc r3					; Incrementa posicao do vetor
	inc r1					; Incrementa iterador
	cmp r1, r2				; Compara se iterador chegou ao fim
	jne incCountPrintObj
	
	pop r7
	pop r6
	pop r5
	loadn r2, #1200
	cmp r4, r2				; Compara se o ultimo objeto chegou ao fim da tela
	pop r4
	pop r3
	pop r2
	pop r1
	cgr LoadVector			; Se chegou, chama a função que carrega o vetor de objetos
	
rts

printCar:
    push r6

    loadn r6, #258
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
	loadn r1, #250
	
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

LoadVector:					; Funcao que carrega o vetor de 10 objetos
	push r2
	push r3
	push r4
	push r5
	push r6
	
	loadn r2, #rand			; Carrega r2 com a posicao inicial do vetor de posicoes
	add r2, r2, r1			; Soma com o indice para saber a partir de qual deve-se armazenar
	
	loadn r3, #0			; Inicia o iterador
	loadn r4, #10			; Limite do iterador
	loadn r5, #objs			; Armazena a posicao inicial do vetor de objetos

IncLoadVector:
	inc r1
	inc r3
	loadi r6, r2			; Carrega r6 com o valor apontado por r2
	inc r2					; Incrementa r2 para andar com o ponteiro
	storei r5, r6			; Armazena o valor de r6 no vetor de objetos
	inc r5					; Incrementa r5 para andar com o ponteiro
	cmp r3, r4				; Compara se iterador chegou ao fim
	jne IncLoadVector		; Se não, volta para o loop
	
	loadn r2, #40			; Posicao final do vetor de posicoes
	cmp r1, r2				; Comprara com o contador de index
	ceq Reset				; Se for igual, reseta o contador de index
	
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
rts

Reset:
	loadn r1, #0			; Reseta o index para a primeira posicao
rts

Imprimestr:		;  Rotina de Impresao de Mensagens:    
				; r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso
				; r1 = endereco onde comeca a mensagem
				; r2 = cor da mensagem
				; Obs: a mensagem sera' impressa ate' encontrar "/0"
				
;---- Empilhamento: protege os registradores utilizados na subrotina na pilha para preservar seu valor				
	push r0	; Posicao da tela que o primeiro caractere da mensagem sera' impresso
	push r1	; endereco onde comeca a mensagem
	push r2	; cor da mensagem
	push r3	; Criterio de parada
	push r4	; Recebe o codigo do caractere da Mensagem
	
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	
	loadi r4, r1		; aponta para a memoria no endereco r1 e busca seu conteudo em r4
	cmp r4, r3			; compara o codigo do caractere buscado com o criterio de parada
	jeq ImprimestrSai	; goto Final da rotina
	add r4, r2, r4		; soma a cor (r2) no codigo do caractere em r4
	outchar r4, r0		; imprime o caractere cujo codigo está em r4 na posicao r0 da tela
	inc r0				; incrementa a posicao que o proximo caractere sera' escrito na tela
	inc r1				; incrementa o ponteiro para a mensagem na memoria
	jmp ImprimestrLoop	; goto Loop
	
ImprimestrSai:	
;---- Desempilhamento: resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
	rts		; retorno da subrotina

Lose:						;Funcao de perda
	call eraseCar
	call IncApagaTela
	loadn r0, #602			; Posiciona a mensagem
	loadn r1, #msgLose		; Carrega o inicio da mensagem
	loadn r2, #0			; Cor da mensagem, no caso, branca
	call Imprimestr			; Imprime a mensagem
	call wait_key			; Espera tecla para saber se quer jogar novamente
	
wait_key:
	push r0
	push r1
	loadn r1, #' '			; Carrega caractere espaço
wait_loop:
	inchar r0				; Armazena o valor do teclado em r1
	cmp r0, r1				; Se a tecla for espaço
	jne wait_loop			; Se nao, volta para o loop
	pop r1
	pop r0
	call IncApagaTela
	jmp Inicio
	
IncApagaTela:		; Funcao que apaga a tela
	push r0
	push r1
	push r2
	loadn r0, #0
	loadn r1, #1200
	loadn r2, #' '
ApagaLoop:
	outchar r2, r0
	inc r0
	cmp r0, r1
	jne ApagaLoop
	pop r2 
	pop r1
	pop r0
	rts
	
StartScreen:					; Imprime a tela de inicio
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r1, #linhaIni0
	loadn r2, #0
	call ImprimeTela
	
	loadn r0, #689
	loadn r1, #msgStart
	loadn r2, #0	
	call Imprimestr
	loadn r4, #' '
StartLoop:
	inchar r3
	cmp r3, r4
	jne StartLoop
	call IncApagaTela
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
rts
	
printScore:						; Imprime o mensagem de score
	loadn r0, #0
	loadn r1, #msgScore
	loadn r2, #0	
	call Imprimestr
	rts

ShouldIPrintOrShouldINot:		; Verifica se o carro ultrapassou a tela, se não, imprime
	push r0
	loadn r0, #1200
	cmp r4, r0
	jeg NotPrint
	outchar r5, r4
NotPrint:
	pop r0
	rts

ShouldIEraseOrShouldINot: 		; Verifica se o carro ultrapassou a tela, se não, apaga
	push r0
	loadn r0, #1200
	cmp r4, r0
	jeg NotPrint
	outchar r7, r4
NotPrint:
	pop r0
	rts
	
PrintScore:					; Imprime valor do score
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r0, #83
	loadn r1, #10
	loadn r4, #'0'
	loadn r5, #768
	
LoopPrintScore:
	mod r3, r2, r1
	add r3, r3, r4
	add r3, r3, r5
	outchar r3, r0
	dec r0
	jz StopPrintScore
	div r2, r2, r1
	jnz LoopPrintScore
	
StopPrintScore:
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
rts

ImprimeTela: 	;  Rotina de Impresao de Cenario na Tela Inteira
				;  r1 = endereco onde comeca a primeira linha do Cenario
				;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r4 na pilha para ser usado na subrotina

	loadn r0, #80  	; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  	; Incremento da posicao da tela!
	loadn r4, #41  	; incremento do ponteiro das linhas da tela
	loadn r5, #640 ; Limite da tela!
	
   ImprimeTela_Loop:
		call Imprimestr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	pop r5	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
WinScreen:						;Tela de fim

	loadn r5, #0
	call IncApagaTela
	call PrintScore
	call printScore
	loadn r0, #607
	loadn r1, #msgWin
	loadn r2, #512
	call Imprimestr
	call wait_key_2

wait_key_2:
	push r0
	push r1
	loadn r0, #' '
wait_key_loop_2:
	inchar r1
	cmp r1, r0
	jne wait_key_loop_2
	call IncApagaTela
	jmp Inicio