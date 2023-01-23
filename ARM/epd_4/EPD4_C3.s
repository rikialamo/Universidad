.data
	
N:	.word 3
RES:	.word -1

.text
.global main

main:	ldr r0,=N
		ldr r0,[r0]
		ldr r1,=RES
		bl subrut
		str r0,[r1]
		mov lr,#0
		bx lr

subrut:	stmdb sp!,{r2,lr}	/* Apila los valores de r2 y lr para hacer la recursividad */
		mov r2,r0		/* r2 = r0 */
		cmp r2,#0		
		beq cero		/* Si r2=0, va a "cero" */
		sub r0,r2,#1		/* Si r2 no es 0, r0 = r2-1 */
		bl recursiv
		mov r3,#5		/* Inicializa r3 = 5 */
		mul r0,r0,r3		/* r0 = r0*r5 */
		add r0,r0,r2		/* r0 = r0+r2 */
		b finrecur
cero:	mov r0,#0
finrecur:	ldmia sp!,{r2,lr}	/* Desapila r2 y lr */
		bx lr