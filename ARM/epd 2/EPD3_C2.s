.data
N: 		.byte 4
matrix:	 .byte 1,2,3,4
 		.byte 5,6,7,8
 		.byte 9,10,11,12
 		.byte 13,14,15,16
resul: 	.byte 0  

.text
.global main

main: 	ldr r0,=matrix 
		ldr r1,=resul 
		ldr r2,=N 
		ldrb r2,[r2]
		mov r4, #0
		mov r5,#3
		mov r7,#3
		mov r8,r2
		

buc1: 	cmp r2,#0
		beq fbuc1
		mov r3,r8
		sub r3,r3,r7

buc2: 	cmp r3,#0
		beq fbuc2
		ldrb  r6,[r0],#1
		add  r4, r4, r6
		sub r3,r3,#1
		b buc2

fbuc2: 	add r0, r0, r5
		sub r5,r5,#1
		sub r7,r7,#1
		sub r2,r2,#1
		b buc1 

fbuc1:  	strb r4, [r1]
	 	bx lr
