.data
num:	.byte		8
		
resultado:	.byte	     	1


.text
.global main

main:		ldr	r0, =num
		ldr	r5, =resultado
		mov	r2, #0
		mov	r1, #1
		ldrb	r3, [r0]
		
bucle:		subs	r3, r3, #2
		cmp	r3, r1
		beq	impar
sino:		cmp	r3, r2
		beq	par
sino2:		b	bucle
par:		strb	r2, [r5]
		b	fin
impar:		strb	r1, [r5]
		b	fin

fin:		bx	lr


		
		

