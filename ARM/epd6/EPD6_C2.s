
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

str_swi:			.asciz "swi "
					.align
swi_handler: 		stmfd sp!,{r0,r1,r5,lr}		// SWI handler routine
					ldr r5,[lr,#-4]
					bic r5,r5,#0xff000000
					ldr r0,=str_swi
					bl printString
					mov r0,r5
					bl printInt
					mov r0,#'\n'
					bl write_uart
					ldmfd sp!,{r0,r1,r5,pc}^

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
main:				mov r0,#'>'
					bl write_uart
					bl read_uart
					mov r2,r0
					mov r0,#'\n'
					bl write_uart
					mov r0,r2
					bl write_uart
					mov r0,#'\n'
					bl write_uart
					b main

loop_for_ever:		b loop_for_ever
					
	
	
	
	
	
