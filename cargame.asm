jmp PreMain

PreMain:
	loadn r0, #1139
	loadn r1, #123 ;Car
	loadn r2, #0
	loadn r3, #255
	loadn r4, #'d'
	loadn r5, #'a'
	loadn r6, #1
	loadn r7, #' '
	jmp main
	
main:
	jmp Game
	
Game:
	inchar r2
	cmp r2, r4
	jeq PrintCarDireita
	cmp r2, r5
	jeq PrintCarEsquerda
	jmp Game

PrintCarDireita:
	mov r2, r0
	outchar r7, r0
	add r0, r2, r6
	outchar r1, r0
	jmp Game
	
PrintCarEsquerda:
	mov r2, r0
	outchar r7, r0
	sub r0, r2, r6
	outchar r1, r0
	jmp Game

halt