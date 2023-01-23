.data
	
cadena1:	.asciz "Salvaguardar"
cadena2:	.asciz " es necesario"
cadena3:	.space 30

	.equ nul,0

.align

tam:	.word 29
resul:	.word -1

.text
.global main

main:	ldr r0,=tam	
		ldr r1,=cadena1
		ldr r2,=cadena2
		ldr r3,=cadena3
		stmdb sp!,{r0-r3}	/* Apila los parámetros de entrada */
		bl subrut
		ldmia sp!,{r0}		/* Desapila el parámetro de salida */
		ldr r9,=resul
		str r0,[r9]		/* Guarda el resultado en resul */
		mov lr,#0
		bx lr			/* Fin */
		

subrut:	ldmia sp!,{r0-r1}		/* Desapila los parámetros de entrada*/
		mov r4,#0
buc:	cmp r4,r0			/* Comprueba que no se haya sobrepasado el número máximo de elementos de cadena3 */
		beq fin
		ldrb r5,[r1],#1
		add r4,r4, #1        	/* Contador de elementos de la cadena */
		cmp r5,#nul          	/* Comprueba si se ha acabado la cadena */
		beq buc2
		strb r5,[r3],#1		/* Guarda un elemento de cadena1 en cadena3 y actualiza la dirección de cadena3 */
		b buc
buc2:	cmp r4,r0			/* Comprueba que no se haya sobrepasado el número máximo de elementos de cadena3 */
		beq fin
		ldrb r5,[r1],#1
		add r4,r4,#1		/* Contador de elementos de la cadena */
		cmp r5,#nul		/* Comprueba si se ha acabado la cadena */
		beq fin
		strb r5,[r3],#1		/* Guarda un elemento de cadena1 en cadena3 y actualiza la dirección de cadena3 */
		b buc2

fin:		mov r0,r4		/* Guarda el tamaño final de la cadena3 en r0 */
		stmdb sp!,{r0}		/* Apila los parámetros de salida */
		bx lr