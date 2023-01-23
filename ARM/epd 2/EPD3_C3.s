.data
N: 		.word 4
matrix1:	 .word 1,2,3,4
 		.word 5,6,7,8
 		.word 9,10,11,12
 		.word 13,14,15,16

matrix2:	.word 0,2,4,6
		.word 8,10,12,14
		.word 16,18,20,22
		.word 24,26,28,30

matres:		.word 0,0,0,0
		.word 0,0,0,0
		.word 0,0,0,0
		.word 0,0,0,0

.text
.global main

main: 	ldr r0,=matrix1 
		ldr r8,=matrix2
		ldr r9,=matres
		ldr r2,=N 
		ldr r2,[r2]
		mov r5,#4
		mov r7,r2
		

buc1: 	cmp r2,#0
		beq fbuc1
		mov r3,r7

buc2: 	cmp r3,#0
		beq fbuc2
		ldr r1,[r0],#4
		ldr r4,[r8],#4
		add r5,r1,r4
		str r5,[r9]
		add r9,r9,#4
		sub r3,r3,#1
		b buc2

fbuc2: 		sub r2,r2,#1
		b buc1 

fbuc1:  	bx lr
