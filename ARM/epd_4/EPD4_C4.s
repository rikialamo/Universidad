.data

laberinto:	.word 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
		.word 1,0,0,0,0,0,0,0,0,0,0,0,0,0,1
		.word 1,0,1,1,1,0,1,1,1,0,1,0,0,0,1
		.word 1,0,1,0,1,0,0,0,1,0,1,0,0,0,1
		.word 1,0,1,0,1,0,0,0,1,0,1,0,0,0,1
		.word 1,0,1,0,1,0,0,0,1,0,1,0,0,0,1
		.word 1,0,1,0,1,1,1,0,0,0,1,1,1,1,1
		.word 1,0,1,0,0,1,0,0,1,0,0,0,0,0,2
		.word 1,0,1,0,0,1,0,0,1,0,1,1,1,1,1
		.word 1,0,1,0,1,1,1,0,1,0,0,1,0,0,1
		.word 1,0,1,0,1,0,0,0,1,0,0,1,0,0,1
		.word 1,0,1,0,0,0,0,0,1,0,0,1,0,0,1
		.word 1,0,1,0,0,0,0,0,1,0,0,1,0,0,1
		.word 1,0,1,1,1,1,0,0,0,0,0,1,0,0,1
		.word 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

xi:	.word 1 
yi:	.word 10 
xs:	.word -1 
ys:	.word -1

.text
.global main

main:	ldr r0,=xi
		ldr r0,[r0]
		ldr r1,=yi
		ldr r1,[r1]
		ldr r2,=laberinto
		bl sal_lab
		ldmia sp!,{r3,r4}
		ldr r5,=xs
		str r3,[r5]
		ldr r5,=ys
		str r4,[r5]
		mov lr,#0
		bx lr

sal_lab:	stmdb sp!,{r4-r5,r9,lr}
		mov r4,#4
		mov r5,#15
		mul r0,r0,r4
		mul r0,r0,r5
		add r2,r2,r0
		mul r1,r1,r4
		add r2,r2,r1
		mov r9,#300
buc_sal_lab:	cmp r9,#0
		beq fin_buc
		ldr r3,[r2,#4]
		cmp r3,#2
		beq dosder
		cmp r3,#1
		beq unoder
		ldr r3,[r2,#-4]
		cmp r3,#2
		beq dosizq
		cmp r3,#1
		beq unoizq
		ldr r3,[r2,#60]
		cmp r3,#2
		beq dosabj
		cmp r3,#1
		beq unoabj
		ldr r3,[r2,#-60]
		cmp r3,#2
		beq dosarr
		cmp r3,#1
		beq unoarr
		ldr r3,[r2,#-64]
		cmp r3,#1
		beq unoarr
		ldr r3,[r2,#64]
		cmp r3,#1
		beq unoabj
		ldr r3,[r2,#56]
		cmp r3,#1
		beq unoizq
		ldr r3,[r2,#-56]
		cmp r3,#1
		beq unoder
		b tocero

unoder:		ldr r3,[r2,#-60]
		cmp r3,#0
		beq buc_sal_lab
		sub r2,r2,#60
		sub r9,r9,#-1
		sub r1,r1,#1
		b buc_sal_lab

unoizq:		ldr r3,[r2,#60]
		cmp r3,#0
		beq buc_sal_lab
		add r2,r2,#60
		sub r9,r9,#-1
		add r1,r1,#1
		b buc_sal_lab

unoabj:		ldr r3,[r2,#4]
		cmp r3,#0
		beq buc_sal_lab
		add r2,r2,#4
		sub r9,r9,#-1
		add r0,r0,#1
		b buc_sal_lab

unoarr:		ldr r3,[r2,#-4]
		cmp r3,#0
		beq buc_sal_lab
		sub r2,r2,#4
		sub r9,r9,#-1
		sub r0,r0,#1
		b buc_sal_lab

dosder:		add r0,r0,#1
		b fin_buc

dosizq:		sub r0,r0,#1
		b fin_buc

dosarr:		add r1,r1,#1
		b fin_buc

dosabj:		sub r1,r1,#1
		b fin_buc

fin_buc:	mov r1,r2
		mov r1,r0
		mov r0,#1
		cmp r9,#0
		moveq r0,#0
		ldmia sp!,{r4-r5,r9,lr}
		stmdb sp!,{r1-r2}
		bx lr
		
