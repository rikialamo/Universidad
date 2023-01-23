
.globl _start
_start:     		ldr pc,reset_handler_d		// Exception vector
					ldr pc,undefined_handler_d
					ldr pc,swi_handler_d
					ldr pc,prefetch_handler_d
					ldr pc,data_handler_d
					ldr pc,unused_handler_d
					ldr pc,irq_handler_d
					ldr pc,fiq_handler_d

reset_handler_d:    .word reset_handler
undefined_handler_d:.word hang
swi_handler_d:      .word swi_handler
prefetch_handler_d: .word hang
data_handler_d:     .word hang
unused_handler_d:   .word hang
irq_handler_d:      .word hang
fiq_handler_d:      .word hang

UARTDR:				.word 0x101f1000			// UART data register address
UARTFR:				.word 0x101f1018			// UART flag register address

reset_handler:		mov r0,#0x10000				// Copy exception vector
					mov r1,#0x00000
					ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
					stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
					ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
					stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
					msr cpsr_c,#0xD1			// FIQ 110 10001
					mov sp,#0x100000
					msr cpsr_c,#0xD2			// IRQ 110 10010
					mov sp,#0x200000
					msr cpsr_c,#0xD3			// SVC 110 10011
					mov sp,#0x300000
					msr cpsr_c,#0xD7			// ABT 110 10111
					mov sp,#0x400000
					msr cpsr_c,#0xDB			// UND 110 11011
					mov sp,#0x500000
					msr cpsr_c,#0xDF			// SYS 110 11111
					mov sp,#0x600000
					msr cpsr_c,#0xD0			// USER 110 10000
					mov sp,#0x700000
					b main						// start main
    
hang:				b hang				

.globl swi_handler
swi_handler: 		stmfd sp!,{r0,r1,r5,lr}		// SWI handler routine
					stmdb sp!,{r5}
					ldr r5,[lr,#-4]
					bic r5,r5,#0xff000000
					cmp r5,#0
					beq regc
					cmp r5,#1
					beq regu
					cmp r5,#2
					beq regd
					cmp r5,#3
					beq regt
					cmp r5,#4
					beq regcu
					cmp r5,#5
					beq regci
					cmp r5,#6
					beq regs
					cmp r5,#7
					beq regsi
					cmp r5,#8
					beq rego
					cmp r5,#9
					beq regn
					b regerr

regc:				mov r1,r0
					ldr r0,=str_regc
					bl printString
					mov r0,r1
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^

regu:				ldr r0,=str_regu
					bl printString
					mov r0,r1
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^
regd:				ldr r0,=str_regd
					bl printString
					mov r0,r2
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^
regt:				ldr r0,=str_regt
					bl printString
					mov r0,r3
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^
regcu:				ldr r0,=str_regcu
					bl printString
					mov r0,r4
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^
regci:				ldr r0,=str_regci
					bl printString
					ldmia sp!,{r5}
					mov r0,r5
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmfd sp!,{r0,r1,r5,pc}^
regs:				ldr r0,=str_regs
					bl printString
					mov r0,r6
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^
regsi:				ldr r0,=str_regsi
					bl printString
					mov r0,r7
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^
rego:				ldr r0,=str_rego
					bl printString
					mov r0,r8
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^
regn:				ldr r0,=str_regn
					bl printString
					mov r0,r9
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^

regerr:				ldr r0,=str_regerr
					bl printString
					mov r0,#'\n'
					bl write_uart
					ldmia sp!,{r5}
					ldmfd sp!,{r0,r1,r5,pc}^
					
str_regc:			.asciz "r0: "
					.align
					
str_regu:			.asciz "r1: "
					.align
str_regd:			.asciz "r2: "
					.align
str_regt:			.asciz "r3: "
					.align
str_regcu:			.asciz "r4: "
					.align
str_regci:			.asciz "r5: "
					.align
str_regs:			.asciz "r6: "
					.align
str_regsi:			.asciz "r7: "
					.align
str_rego:			.asciz "r8: "
					.align
str_regn:			.asciz "r9: "
					.align
str_regerr:			.asciz "Parametro desconocido."
					.align

.globl write_uart
write_uart:			stmdb sp!,{r4}
					ldr r4,UARTDR
					strb r0,[r4]
					ldmia sp!,{r4}
					bx lr			

.globl read_uart
read_uart:			stmdb sp!,{r4,r5}
					ldr r4,UARTFR
wait_data:			ldr r5,[r4]
 	 				and r5,r5,#0x00000040
 	 				cmp r5,#0
 					beq wait_data
					ldr r4,UARTDR
					ldrb r0,[r4]
					ldmia sp!,{r4,r5}
					bx lr
    
.globl main
main:				swi #0
					swi #1
					swi #2
					swi #3
					swi #4
					swi #5
					swi #6
					swi #7
					swi #8
					swi #9
					swi #100
loop_for_ever:		b loop_for_ever
					
	
	
	
	
	
