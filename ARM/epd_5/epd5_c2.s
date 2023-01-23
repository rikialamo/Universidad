/* EPD5, C2: carga un fichero de texto linea a linea y lo
             muestra por pantalla */
.equ SWI_PrChr, 0x00
.equ SWI_PrStr, 0x02
 @ Write an ASCII char to Stdout
.equ SWI_OpenFile, 0x66 @ Open a text file
.equ SWI_CloseFile, 0x68 @ Close a text file
.equ SWI_RdStr, 0x6a @ Read a String from File
.equ SWI_WrStr, 0x69 @ Write a Sting
 .equ Stdout, 1  @ Set output mode to be Output View
 .equ Stdin, 0
 .equ SWI_Exit, 0x11 @ Stop execution

.data
Line:	.space 400 @ Buffer para leer la linea
 .asciz "\n"
NewL:	.ascii "\n"
EOL:	.asciz "\n"
Blank:	.ascii " "
Error_msg: .asciz "Error while reading the file\n"
File:  .asciz "textoc1.txt"

.align

.text
.global main
main:	ldr r0,=File
	mov r1,#0
	swi SWI_OpenFile
	cmp r0,#-1
	beq show_error
	mov r7,r0
leer:	mov r0,r7
	ldr r1,=Line
	mov r2,#100
	swi SWI_RdStr
	ldrb r4,[r1]
	cmp r4,#'*'
	beq end
	mov r0,#1
	swi SWI_WrStr
	ldr r1,=NewL
	mov r0,#1
	swi SWI_WrStr
	b leer

end:
  swi SWI_Exit @ stop executing: end of program

show_error:
  /* Print message 2*/
  ldr r0,=Error_msg
  swi #SWI_PrStr
  b end
  

.end

