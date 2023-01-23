.data
vec1:		.byte		1,2,3,4,5
vec2:           .byte           5,4,3,2,1
vec3:		.byte		-5,-4,-3,-2,-1	
tam:		.byte		5
resul:	        .byte		0, 0, 0 ,0 ,0

.text
.global	main
main:		ldr 	r4,=resul    /* r4 puntero al resultado */
		ldr 	r0,=tam
		ldrb 	r0,[r0]
		ldr 	r1,=vec1      
		ldr 	r2,=vec2
		ldr 	r3,=vec3
		stmdb 	sp!, {r4}      /* Pasamos el vector resultado por pila */
		bl 	suma_vec     /* Llamada a la subrutina suma_vec */
		ldmia 	sp!,{r4}      /* Quitamos el parámetro anterior */
		mov 	lr,#0      
		bx 	lr
/* Subrutina que suma tres vectores de bytes */
/* Parametros de entrada: r0 (tamaño), r1-r3 (punteros entrada ), por pila: puntero a vector suma*/
/* Parametros de salida: No existen */
/* Variables locales: r4 (puntero al resultado) */
/*                    r5 (sumas parciales) */
/*                    r6 (carga de datos) */
suma_vec:	
		stmdb	sp!,{r4,r5,r6}
		ldr r4,[sp,#12]
		
suma_vec_bucle:                       
		subs 	r0, r0, #1	             /* r1 <-- r1 - 1 */
		blt 	fin_bucle
		mov	r5,#0  /* Inicializamos el r2 para sumar */
		ldrb 	r6, [r1, r0]   /* r6 <-- *(r0 + r1) */
		add 	r5, r5, r6   /* r5 += r6 */
		ldrb 	r6, [r2, r0]   /* r6 <-- *(r2 + r0) */
		add 	r5, r5, r6   /* r5 += r6 */
		ldrb 	r6, [r3, r0]   /* r6 <-- *(r3 + r0) */
		add 	r5, r5, r6   /* r5 += r6 */
		strb 	r5, [r4, r0]             /* *(r4+r0) <-- r5 */
		b 	suma_vec_bucle
		
fin_bucle:	
		ldmia	sp!, {r4,r5, r6}    /* Recuperamos los valores guardados*/
		bx	lr

    