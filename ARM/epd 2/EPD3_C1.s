.data
N: 		.word 4
matrix:	 .word 1,2,3,4
 		.word 5,6,7,8
 		.word 9,10,11,12
 		.word 13,14,15,16
resul: 	.word 0  

.text
.global main

main: 	ldr r0,=matrix 
		ldr r1,=resul 
		ldr r2,=N 
		ldr r2,[r2]
		mov r4, #0
		mov r5,#4
		

buc1: 	cmp r2,#0
		beq fbuc1
		mov r3,r2

buc2: 	cmp r3,#0
		beq fbuc2
		ldr  r6,[r0],#4
		add  r4, r4, r6
		sub r3,r3,#1
		b buc2

fbuc2: 	add r0, r0, r5
		add r5,r5,#4
		sub r2,r2,#1
		b buc1 

fbuc1:  	str r4, [r1]
	 	bx lr
