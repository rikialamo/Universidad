.data
	
cadena1:	.asciz "prueba"
cadena2:	.asciz "FC no es tan dificil"
cadena3:	.asciz "Me encanta el ensamblador"

	.equ nul,0

.align

resul1:	.word -1
resul2:	.word -1
resul3:	.word -1

.text
.global main

main:	ldr r0,=cadena1			
		ldr r1,=resul1
		stmdb sp!,{r0-r1}	/* Carga la dirección de cadena1 y resul1 en la pila */
		bl subrut
		ldr r0,=cadena2
		ldr r1,=resul2
		stmdb sp!,{r0-r1}	/* Carga la dirección de cadena2 y resul2 en la pila */
		bl subrut
		ldr r0,=cadena3
		ldr r1,=resul3
		stmdb sp!,{r0-r1}	/* Carga la dirección de cadena3 y resul3 en la pila */
		bl subrut
		mov lr,#0
		bx lr
		

subrut:	ldmia sp!,{r0-r1}		/* Desapila las direcciones */
buc:   ldrb  r2, [r0], #1     
       	add   r3, r3, #1        	/* Contador de elementos de la cadena */
    	cmp   r2, #nul          	/* Comprueba si se ha acabado la cadena */
        bne   buc              
       	sub   r3, r3, #1        	/* Decrementa el contador si el último elemento que se ha cargado es nulo */
	str   r3,[r1]			/* Guarda el contador en la dirección en r1 */
	bx lr
		