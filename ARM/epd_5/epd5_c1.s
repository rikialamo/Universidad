/* EPD5 C1 Muestra cadenas, enteros y caracteres por Stdout */
.equ SWI_PrChr, 0x00 @ Write an ASCII char to Stdout
.equ SWI_PrStr, 0x02 @ Write a null-ending string to Stdout
.equ SWI_PrInt, 0x6b @ Write an Integer to a File Handle
.equ Stdout, 1 @ Handle of Stdout
.equ SWI_Exit, 0x11 @ Stop execution

.global _main
.text
_main:
	@ print a string to Stdout
	ldr R0, =Message1 @ load address of Message1
	swi SWI_PrStr @ display message to Stdout
	ldr r0, =EOL @ end of line
	swi SWI_PrStr @ print a character to the screen
	mov R0, #'A @ R0 = char to print
	swi SWI_PrChr 
	/* Prints EOL */
	ldr r0,=EOL
	swi SWI_PrStr

	/* Prints message 2*/
	ldr r0,=Message2
	swi SWI_PrStr
	/* Prints integer */
	mov r0,#0
	mov r1,#34
	swi SWI_PrInt

	/* End with a EOL*/
	ldr r0,=EOL
	swi SWI_PrStr

	swi SWI_Exit @ stop executing: end of program

.data
Message1: .asciz "Hello World!"
Message2: .asciz "EPD5 rules"
EOL:
 .asciz "\n"
NewL:
 .ascii "\n"
Blank:
 .ascii " "
.end

