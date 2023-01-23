/* EPD5 C4 Muestra una cadena cada segundo por Stdout */
.equ SWI_PrChr, 0x00 @ Write an ASCII char to Stdout
.equ SWI_PrStr, 0x02 @ Write a null-ending string to Stdout
.equ SWI_PrInt, 0x6b @ Write an Integer to a File Handle
.equ Stdout, 1 @ Handle of Stdout
.equ SWI_Exit, 0x11 @ Stop execution
.equ SWI_GetTicks, 0x6d @ Get current time

.data

puntos:	.ascii

EOL: 	.asciz "\n"
.align

.global _main
.text
_main:	mov r5,#0		/* r5 contador de minutos */
	mov r6,#0		/* r6 contador de segundos */

restart_counter:
	cmp r6,#60		/* Si segundos = 60 -> Va a "min" */
	bleq min
	mov r0,#1
	mov r1,r5		/* Minutos -> r1 */
	swi SWI_PrInt		/* Imprime minutos */
	mov r0,#':
	swi SWI_PrChr		/* Imprime ':' */
	mov r0,#1
	mov r1,r6		/* Segundos -> r1 */
	swi SWI_PrInt		/* Imprime segundos */
	ldr r0,=EOL
	swi SWI_PrStr

	swi #SWI_GetTicks
  	mov r4, r0            @ R4 guarda los tics
buc:  swi #SWI_GetTicks
	sub r0, r0, r4
	cmp r0, #1000
	addgt r6,r6,#1
	bgt restart_counter
	b buc
    
min:	mov r6,#0
	add r5,r5,#1
	bx lr

end:
  swi SWI_Exit @ stop executing: end of program
  
.end
