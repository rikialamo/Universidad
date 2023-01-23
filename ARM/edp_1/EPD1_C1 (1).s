.data
var2:	.word		128, 32, 100, -30, 124
		.equ	     	N, 5     /* size of the vector */
resul:	.word	     	0

.text
.global main

main:		ldr	r1, =var2
		movs	r0, #N		/* r0 = N */
		mov	r2, #0		/* r2 = 0 */
		ldr	r4, =resul		
		
bucle:	ldr	r3, [r1], #4    /* r3 <-- *r1 ; r1 += 4; */
		add	r2, r2, r3      /* r2 <-- r2+r3 */
		subs	r0, r0, #1	     /* r0 <-- r0-1 */
		bne	bucle
		str	r2, [r4]		/* r2 --> [r4]*/

fin:		bx	lr


		
		

