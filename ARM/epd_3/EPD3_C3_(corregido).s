.data
nums:	.word	32,45,78,91,12
resul:	.word	-1

.text
.global main
main:
	
	ldr r5,=nums
	ldmia r5,{r0-r4}
	stmdb sp!,{r0-r4}	/* Apila los parámetro de entrada */
	bl subrut
	ldr r6,=resul
	ldm sp,{r0}		/* Desapila el parámetro de salida */
	str r0,[r6]		/* Guarda el parámetro de salida en resul */
	mov lr,#0
	bx lr			/* Fin */
	

subrut:
	ldmia sp!,{r0-r4}	/* Desapila los parámetros de entrada */
	cmp r0,r1		
	movlt r0, r1		/* Si r0<r1, r1->r0 */
	cmp r0,r2
	movlt r0, r2		/* Si r0<r2, r2->r0 */
	cmp r0,r3
	movlt r0, r3		/* Si r0<r3, r3->r0 */
	cmp r0,r4
	movlt r0,r4		/* Si r0<r4, r4->r0 */
	stmdb sp!,{r0}		/* Apila el parámetro de salida */
	bx lr