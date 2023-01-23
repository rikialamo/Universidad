.data
num:	.word		4
		
resultado:	.word	     	1


.text
.global main

main:		ldr	r0, =num
		ldr	r5, =resultado
		ldr	r3, [r0]
		ldr	r6, [r0]
		mov	r2, #1
		
		
bucle:		subs	r3, r3, #1
		mul	r6, r3, r6
		cmp	r3, r2
		bne	bucle
		str	r6, [r5]
		
fin:		bx	lr


		
		

