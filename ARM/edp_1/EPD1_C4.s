.data
var2:	.word		8, -2, 2, -5, 2, -2
		.equ	     	N, 6     /* size of the vector */
cont:	.word	     	0
num:	.word		6

.text
.global main

main:		ldr	r1, =var2
		movs	r0, #N		
		ldr	r5, =num
		mov	r2, #0		
		ldr	r4, =cont
		ldr	r9, [r5]		
		

bucle:		ldr	r3, [r1], #4    
		subs	r0, r0, #1	     	
		cmp	r3, r9
		bne	comprobar
		b	entonces


entonces:	add	r2, r2, #1		
		b	comprobar

comprobar:	cmp	r0, #0
		beq	cambio
		b 	bucle

cambio:		str	r2, [r4]
		b	fin

fin:		bx	lr


		
		

