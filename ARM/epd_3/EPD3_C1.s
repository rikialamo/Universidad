.data
vec:		.word		1,2,3,4,5
tam:		.word		5
resul:	.word		0

.text
.global	main
main:		ldr	r4,=resul    /* r4 puntero al resultado */

		ldr	r0,=vec      
		ldr	r1,=tam
		ldr	r1,[r1]
		bl	suma_vec     /* Llamada a la subrutina suma_vec */
		str	r0, [r4]	  /* r0 --> [r4] */
		mov	lr,#0      
		bx	lr
		
/* Subrutina que suma un vector de words */
/* Parametros de entrada: r0 (puntero) y r1 (tamaño)*/
/* Parametros de salida: r0  */
suma_vec:	mov r2,#0  /* Inicializamos el r2 para sumar */
suma_vec_bucle:                       
		subs	r1, r1, #1	             /* r1 <-- r1 - 1 */
		ldr	r3, [r0, r1, lsl #2]   /* r3 <-- *(r0 + r1*4) */
		add	r2, r2, r3             /* r2 <-- r2+r3 */
		bne	suma_vec_bucle 
		mov     r0, r2                 /* Copiamos el resultado a r2 para hacerlo conforme al estándar */
		bx	lr

