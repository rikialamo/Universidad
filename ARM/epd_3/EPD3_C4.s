.data
vec:	.word	5,10,7,2,8
TAM:	.word	5
min:	.word	-1

.text
.global main
main:
	ldr r0,=vec
	ldr r1,=TAM
	ldr r1,[r1]
	stmdb sp!,{r0-r1}	/* Apila los parámetros de entrada */
	bl subrut
	ldmia sp!,{r3}
	ldr r4,=min
	str r3, [r4]
	mov lr,#0
	bx lr


subrut:	ldmia sp!,{r0-r1}	/* Desapila los parámetros de entrada */
	ldr r3,[r0]		/* Inicializa el valor de r3 */
buc:	cmp r1,#0		/* Contador del bucle */
	beq fbuc
	ldr r2,[r0],#4
	cmp r2,r3
	movlt r3,r2		/* Si el valor de vec cargado en r2 es menor que el que hay en r3, r2->r3 */
	sub r1,r1,#1		/* Decrementa el contador */
	b buc
fbuc:	stmdb sp!,{r3}		/* Apila el parámetro salida */
	bx lr