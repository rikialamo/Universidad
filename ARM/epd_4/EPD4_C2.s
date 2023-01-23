.data
	
valor1:	.word 0
valor2:	.word 9
valor3:	.word 17
valor4:	.word 100
valor5:	.word 600

resul1:	.word -1
resul2:	.word -1
resul3:	.word -1
resul4:	.word -1
resul5:	.word -1

.text
.global main

main:	ldr r0,=valor1
		ldr r0,[r0]
		ldr r1,=resul1
		bl subrut
		ldr r0,=valor2
		ldr r0,[r0]
		ldr r1,=resul2
		bl subrut
		ldr r0,=valor3
		ldr r0,[r0]
		ldr r1,=resul3
		bl subrut
		ldr r0,=valor4
		ldr r0,[r0]
		ldr r1,=resul4
		bl subrut
		ldr r0,=valor5
		ldr r0,[r0]
		ldr r1,=resul5
		bl subrut
		mov lr,#0
		bx lr
		

subrut:	mov r3, #1		/* Inicializa r3 */
bucle2:	mul r2, r3, r3
		cmp r2, r0
		bgt finsub
		add r3, #1
		b bucle2
finsub:	sub r3, #1
		str r3,[r1]
		bx lr