.data
letra: 		.byte 'i'
cadena:	.asciz "universidad"
N:	.word	12
resul: 	.word 0  

.text
.global main

main: 	ldr r0,=cadena 		/* Dirección de cadena -> r0 */
		ldr r1,=letra	
		ldrb r1,[r1]	/* Valor de letra -> r1 */
		ldr r2,=N 
		ldr r2,[r2]	/* Valor de N -> r2 */
		ldr r3,=resul	/* Dirección de resul -> r3 */
		mov r4, #0	/* Inicializo r4=0 */
		

buc1: 	cmp r2,#0		/* r2 como contador del bucle */
		beq fin
		sub r2,r2,#1	/* Disminuye r2 */
		ldrb r5,[r0],#1	/* Valor en la dirección en r0 -> r5 */
		cmp r1,r5	/* Comprueba si las letras son iguales */
		beq igual
		b buc1		

igual:	add r4,r4,#1		/* Las letras son iguales, aumenta el contador r4 */
		b buc1


fin:  	str r4, [r3]		/* Guarda el valor de r4 en resul */
	 	bx lr
