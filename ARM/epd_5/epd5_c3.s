/* EPD5, C3: programa que suma dos matrices obtenidas desde fichero y almacena su suma en un tercer fichero */
.equ SWI_PrChr, 0x00	@ Write an ASCII char to Stdout
.equ SWI_PrStr, 0x02	@ Write a null-ending string
.equ SWI_OpenFile, 0x66	@ Open a text file
.equ SWI_CloseFile, 0x68	@ Close a text file
.equ SWI_PrInt, 0x6b	@ Write an Integer
.equ SWI_RdInt, 0x6c	@ Read an Integer
.equ SWI_WrStr, 0x69	@ Write a string to file

@ Standard file handles
.equ Stdout, 1  
.equ Stdin, 0
.equ Stderr, 2

.equ SWI_Exit, 0x11 @ Stop execution
 
.global _main
.text
_main:
  /* prints loading message */
  ldr r0, =Message1 /* load address of Message1 */
  swi SWI_PrStr /* display message to Stdout */
  ldr r0, =First /* Load the first filename */
  swi SWI_PrStr
  ldr r0, =EOL /* end of line */
  swi SWI_PrStr
  /* Calls to load matrix */
  ldr r0, =First
  ldr r1, =matrix1
  bl load_matrix
  blt show_first_error
  mov r4, r0 /* r4 is the size of matrix 1 */

  /* Carga de la segunda matriz */
  ldr r0, =Message1 /* load address of Message1 */
  swi SWI_PrStr /* display message to Stdout */
  ldr r0, =Second /* Load the first filename */
  swi SWI_PrStr
  ldr r0, =EOL /* end of line */
  swi SWI_PrStr
  /* Calls to load matrix */
  ldr r0, =Second
  ldr r1, =matrix2
  bl load_matrix
  blt show_second_error
  /* End of removal*/
  
  /* Comparamos para ver si tienen la misma dimension */
  cmp r0, r4 
  bne show_diff_size_error

  /* Call to subroutine for adding two matrices */
  mov r0,r4 
  ldr r1, =matrix1
  ldr r2, =matrix2
  ldr r3, =matrixsum
  bl add_matrix
  
  /* Call to subroutine for saving a matrix */
  ldr r0, =SumFile
  ldr r1, =matrixsum
  mov r2, r4
  bl save_matrix
  blt show_third_error
  b end
  
show_first_error:
  ldr r0, =Error_msg1
  swi SWI_PrStr
  b end
show_second_error:
  ldr r0, =Error_msg2
  swi SWI_PrStr
  b end  
show_third_error:
  ldr r0, =Error_msg3
  swi SWI_PrStr
  b end  
show_diff_size_error:
  ldr r0, =Error_msg_diff_size
  swi SWI_PrStr
  b end
  
end:
  swi SWI_Exit @ stop executing: end of program
  
/* Opens a file and reads a matrix from file */
/* Inputs: r0 = filename; r1 = pointer to matrix */
/* Output: r0 = Size of the matrix. A negative value if an error occurred */
load_matrix:
  stmdb sp!, {r4-r6}
  mov r6, r1 /*Matrix pointer to r6 */
  /* Open file */
  mov r1, #0 /* Open for read */
  swi SWI_OpenFile
  cmp r0,#0
  blt lm_error
  mov r4, r0 /* Store the file handle */
  swi SWI_RdInt 
  bcs lm_error_and_close
  mov r5,r0   /*save the size in r5*/
  mov r1,#0   /* r1 will be the row counter */

lm_row_loop:
  cmp r5,r1
  moveq r0,#0
  beq lm_close_end

  mov r2,#0 /* Column counter */
lm_column_loop:
  cmp r5,r2
  beq lm_end_column
  
  /* Get the number */
  mov r0, r4 /* File handle to r0*/
  swi SWI_RdInt 
  bcs lm_error_and_close
  str r0, [r6], #4 /* Store the number and actualize pointer */

  add r2,r2, #1	/* Actualize col counter */
  b lm_column_loop
lm_end_column:
  add r1,r1,#1
  b lm_row_loop

lm_error:
  mov r0,#-1
  b lm_end
  
lm_error_and_close:
  mov r0,r4
  swi SWI_CloseFile
  mov r0,#-1
  b lm_end

lm_close_end:
  mov r0,r4
  swi SWI_CloseFile
  bcs lm_error
  mov r0,r5
  
lm_end:
  ldmia sp!, {r4-r6}
  bx lr

/* Completad las funciones save matrix y add matrix */
  
  
/* Opens a file and writes the matrix to file */
/* Inputs: r0 = filename; r1 = pointer to matrix r2 = tam */
/* Output: r0 = Size of the matrix. A negative value if an error occurred */
save_matrix: stmdb sp!,{r4-r7}
		mov r4,r1		/* Se guarda el pointer de matrixsum en r4 */
		mov r1,#1
		swi SWI_OpenFile	/* Abre la file en modo write */
		bcs show_third_error
		mov r5,r0		/* Guardar FH */
		mov r1,r2		/* tam -> r1 */
		swi SWI_PrInt		/* Escribir tam en file */
		ldr r1,=EOL
		swi SWI_WrStr		/* EOL */
		mov r6,#0		/* r6 va a ser contador del loop de fila */

sm_loop_fila:	cmp r6,r2
		beq sm_close
		mov r7,#0		/* r7 va a ser contador del loop de columna */

sm_loop_col:	cmp r7,r2
		beq sm_fin_col
		mov r0,r5		/* FH */
		ldr r1,[r4],#4		/* Número de la matriz -> r1, actualiza el pointer */
		swi SWI_PrInt
		ldr r1,=Blank
		swi SWI_WrStr		/* Espacio entre números */
		add r7,r7,#1
		b sm_loop_col

sm_fin_col:	add r6,r6,#1
		ldr r1,=EOL
		swi SWI_WrStr		/* EOL entre filas de la matriz */
		b sm_loop_fila

sm_error:	mov r0,#-1
		b show_third_error

sm_close:	mov r0,r5
		swi SWI_CloseFile
		bcs sm_error

sm_end:	ldmia sp!,{r4-r7}
		bx lr
  
/* Sums two matrices and stores the result in another */
/* Inputs r0: tam; r1 = Matrix 1; r2 Matrix 2; r3 Matrix 3 */
/* Outputs: none */
add_matrix:	stmdb sp!,{r4-r8}
		mul r5,r0,r0		/* r5 = (r0)^2, r5 = número de elementos en la matriz */
		mov r4,#0		/* r4 va a ser contador del loop */
am_loop:	cmp r4,r5
		beq am_end
		ldr r7,[r1],#4		
		ldr r8,[r2],#4
		add r6,r7,r8	
		str r6,[r3],#4
		add r4,r4,#1
		b am_loop

am_end:	ldmia sp!,{r4,r6}
	bx lr

/* Parte de datos. Aqui se incluyen los nombres de los archivos, mensajes y espacio para matrices */
.data
First: .asciz "Matrix1.txt"
Second:    .asciz "Matrix2.txt"
SumFile:   .asciz "MatrixSum.txt"
Message1: .asciz "Opening file: "
EOL:
 .asciz "\n"
Blank:
 .asciz " "
Error_msg1: .asciz "Error while reading Matrix 1\n"
Error_msg2: .asciz "Error while reading Matrix 2\n"
Error_msg3: .asciz "Error while writing Matrix\n"
Error_msg_diff_size: .asciz "Error: matrices have different size\n"

.align
matrix1: .space 400
matrix2: .space 400
matrixsum: .space 400

.end
