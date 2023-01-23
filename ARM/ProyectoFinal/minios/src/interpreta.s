.include "src/defs.s"

// Funcion que interpreta un comando
// In: r0 --> cadena a interpretar
// Devuelve: r0 == 0 --> comando ok
//  ERR_NON_VALID error en la instruccion
//  ERR_PARSE error en el parseo de una expresion
.global interpreta
interpreta:
        stmdb sp!, {r4-r10, lr}           // Para poder modificar registros --> salvaguardamos todos!
        sub sp,sp, #TAM_STRING            // Reservamos espacio en la pila para una variable auxilar tipo cadena de tamaño TAM_STRING 
        mov r10, #0          // r10 tiene el codigo de error. Antes de salir de la función lo copiaremos a r0 para retornar dicho valor

        bl ignora_espacios        
        mov r4, r0     		// r4 tiene el comando a interpretar sin espacios al principio

        bl strlen
        cmp r0,#0
        beq f_interpr // Si la cadena está vacía, retornamos

        // Para facilitar interpretacion de evaluacion de registros --> guardamos el puntero a los registros en una var global
comprueba_help:


        // Comparamos con los comandos llamando a starts_with o strcmp (ver utils.s y auxiliar.c, respectivamente)

        // Ejemplo strcmp
        mov r0, r4
        ldr r1, =cmd_help	//primero vemos si es help
        bl strcmp
        cmp r0, #0		// r0=0 es que las cadenas son identicas
        beq ej_help        
        
		
comprueba_list_reg:
        mov r0,r4
        ldr r1,=cmd_list_reg
        bl strcmp
        cmp r0,#0
        beq ej_list_reg

comprueba_list_int:
        mov r0,r4
        ldr r1,=cmd_list_int
        bl strcmp
        cmp r0,#0
        beq ej_list_int

comprueba_set_r:
        mov r0,r4
        ldr r1,=cmd_set_r
        bl starts_with
        cmp r0,#1
        beq ej_set_r

comprueba_set_int:
        mov r0,r4
        ldr r1,=cmd_set_int
        bl starts_with
        cmp r0,#1
        beq ej_set_int

comprueba_print:
        mov r0,r4
        ldr r1,=cmd_print
        bl starts_with
        cmp r0,#1
        beq ej_print

comprueba_input:
        mov r0,r4
        ldr r1,=cmd_input
        bl starts_with
        cmp r0,#1
        beq ej_input

comprueba_pause:
        mov r0,r4
        ldr r1,=cmd_pause
        bl strcmp
        cmp r0,#0
        beq ej_pause

comprueba_if:
        mov r0,r4
        ldr r1,=cmd_if
        bl starts_with
        cmp r0,#1
        beq ej_if
        

        b error_cmd   // Si no hemos podido interpretar el comando --> devolvemos código de error

ej_help:                        //Imprime help.
        ldr r0, =mensaje_ayuda
        bl printString
        b f_interpr


ej_set_r:
        ldrb r0,[r4,#5]!
        sub r0,r0,#48
        mov r1,#4
        mul r0,r1,r0
        ldr r5,=registros_virtuales
        add r5,r5,r0
        add r4,r4,#2
        mov r0,r4
        bl atoi
        str r0,[r5]
        b f_interpr

ej_set_int:
        ldrb r0,[r4,#5]!        //Carga la primera letra del nombre de la variable en r0.
        mov r9,#11
        mov r8,#0
        ldr r1,=buffer_nom_var  //Se guardará temporalmente el nombre de la variable en buffer_nom_var.
        b lee_nom_var

buffer_nom_var:
.space TAM_STRING
.align

lee_nom_var:
        cmp r8,r9               //Contador con el máximo de carácteres para el nombre de la variable.
        beq error_nom
        cmp r0,#'='
        beq fleer_nom
        strb r0,[r1],#1
        ldrb r0,[r4,#1]!
        add r8,r8,#1
        b lee_nom_var

fleer_nom:
        mov r0,#0
        strb r0,[r1]    //Fin del nombre de la variable.
        bl cmp_nom_var  //Subrutina que comprueba si una variable con ese nombre ya existe.
        add r0,r4,#1
        bl atoi
        str r0,[r9]     //La subrutina devuelve la dirección donde guardar el valor de la variable en r9.
        b f_interpr
        

cmp_nom_var:
//Subrutina que comprueba si una variable con ese nombre ya existe.
        stmdb sp!,{lr}
        ldr r6,=buffer_nom_var
        mov r5,#0
        ldr r7,=n_vars_int
        ldr r7,[r7]
        mov r9,#0
        b buc_cmp
buc_cmp:
        cmp r9,r7
        beq fcmp_no
        mov r0,r6
        ldr r1,=buffer_int
        add r1,r5,r1
        bl strcmp
        cmp r0,#0
        beq fcmp_si
        add r9,r9,#1
        add r5,r5,#16
        b buc_cmp

fcmp_si:        //Existe una variable con ese nombre:
        ldr r9,=buffer_int
        add r9,r5,r9
        add r9,r9,#12   //r9 apunta a la dirección donde va el valor de la variable con ese nombre, para actualizarlo.
        ldmia sp!,{lr}
        bx lr

fcmp_no:        //Si no existe una variable con ese nombre, se crea una nueva.
        //Se copia el nombre de la variable en un espacio vacío en buffer_int.
        ldr r0,=buffer_int
        add r0,r5,r0
        ldr r1,=buffer_nom_var
        mov r2,#12
        bl strncpy

        ldr r9,=buffer_int
        add r9,r5,r9
        add r9,r9,#12   //r9 apunta a la dirección donde guardar el valor de la nueva variable.
        ldr r0,=n_vars_int
        ldr r2,[r0]
        add r2,r2,#1
        str r2,[r0]     //Se actualiza el valor de n_vars_int
        ldmia sp!,{lr}
        bx lr
        
//Fin de la subrutina que comprueba si una variable con ese nombre ya existe.

error_nom:
        ldr r0,=error_var_nom
        bl printString
        b f_interpr

//Fin de set %var.---------------------------------------------------------------------------
ej_print: 
        ldrb r0,[r4,#6]!
        cmp r0,#34
        beq ej_print_cad
        cmp r0,#'r'
        beq ej_print_reg
        cmp r0,#'%'
        beq ej_print_var
        b error_cmd

ej_print_cad:
        mov r0,r4
        bl strlen
        sub r6,r0,#1
        mov r2,r6
        mov r1,r4
        ldr r0,=buffer_string
        bl strncpy
        ldr r0,=buffer_string
        bl reverse
        mov r1,r0
        ldr r0,=buffer_string
        sub r2,r6,#1
        bl strncpy
        bl reverse
        bl printString
        mov r0,#'\n'
        bl write_uart
        b f_interpr


ej_print_reg:
        ldrb r0,[r4,#1]!
        //Imprime "rx: " (x lo introduce el usuario).
        sub r6,r0,#48
	mov r0,#'r'
	bl write_uart
	mov r0,r6
	bl printInt
	mov r0,#':'
	bl write_uart
	mov r0,#' '
	bl write_uart
        //Imprime el valor de rx
        mov r0,r6
        mov r1,#4
        mul r0,r1,r0
        ldr r5,=registros_virtuales
        add r5,r5,r0
        ldr r0,[r5]
        bl printInt
        mov r0,#'\n'
        bl write_uart
        b f_interpr 

ej_print_var:
        add r4,r4,#1
        mov r5,#0
        ldr r6,=n_vars_int
        ldr r6,[r6]
        mov r7,#0

buc_find_var:
        cmp r5,r6
        beq no_find
        mov r0,r4
        ldr r1,=buffer_int
        add r1,r7,r1
        bl strcmp
        cmp r0,#0
        beq si_find
        add r5,r5,#1
        add r7,r7,#16
        b buc_find_var

si_find:
        ldr r4,=buffer_int
        add r4,r7,r4
        mov r0,r4
        bl printString
        mov r0,#':'
        bl write_uart
        mov r0,#' '
        bl write_uart
        ldr r0,=buffer_int
        add r0,r7,r0
        add r0,r0,#12
        ldr r0,[r0]
        bl printInt
        mov r0,#'\n'
        bl write_uart
        b f_interpr

no_find:
        ldr r0,=error_noFind
        bl printString
        b f_interpr

//Fin print %var.--------------------------------------------------------------------------------
        
ej_input: 
        ldrb r1,[r4,#6]!
        cmp r1,#'r'
        beq ej_input_r
        cmp r1,#'%'
        beq ej_input_var
        b error_cmd
ej_input_r:
        ldrb r1,[r4,#1]!
        sub r1,r1,#48
        mov r2,#4
        mul r5,r1,r2
        mov r0,#'\n'
        bl write_uart
        bl leer_input
        mov r0,r9
        bl atoi
        ldr r2,=registros_virtuales
        add r2,r2,r5
        str r0,[r2]
        mov r0,#'\n'
        bl write_uart
        b f_interpr

ej_input_var:
        add r4,r4,#1
        ldr r5,=n_vars_int
        ldr r5,[r5]
        mov r6,#0
        mov r7,#0
        b buc_input_var

buc_input_var:
        cmp r5,r6
        beq error_noFind        //Da error si no se encuentra la variable.
        ldr r1,=buffer_int
        add r1,r7,r1
        mov r0,r4
        bl strcmp
        cmp r0,#0
        beq fbuc_input
        add r6,r6,#1
        add r7,r7,#16
        b buc_input_var

fbuc_input:
        mov r0,#'\n'
        bl write_uart
        bl leer_input
        mov r0,r9
        bl atoi
        ldr r2,=buffer_int
        add r2,r2,r7
        add r2,r2,#12
        str r0,[r2]

        mov r0,#'\n'
        bl write_uart
        b f_interpr

leer_input:
        stmdb sp!,{r4,r5,lr}
        ldr r4,=buffer_comando
        mov r5,#0
buc_leer:
        bl read_uart
	cmp r0, #'\n'
        beq fbuc_leer
	cmp r0, #'\r'
        beq fbuc_leer
        cmp r0,#' '
        beq fbuc_leer
	strb r0, [r4,r5]
	bl write_uart
	add r5,r5,#1
        b buc_leer

fbuc_leer:
        mov r0,#0
        strb r0, [r4,r5]
        mov r9,r4
        ldmia sp!,{r4,r5,lr}
        bx lr

//Fin comando input.---------------------------------------------------------------
ej_list_reg:
        mov r5,#0
        ldr r4,=registros_virtuales

buc_list:       cmp r5,#10
                beq f_interpr
                //Imprime "rx: "
	        mov r0,#'r'
	        bl write_uart
	        mov r0,r5
	        bl printInt
	        mov r0,#':'
	        bl write_uart
	        mov r0,#' '
	        bl write_uart
                //Imprime el valor de rx.
                ldr r0,[r4],#4
                add r5,r5,#1
                bl printInt
                mov r0,#'\n'
                bl write_uart
                b buc_list
//Fin list_reg.----------------------------------------------------------------------

ej_list_int:
        mov r5,#0
        ldr r4,=buffer_int
        ldr r6,=n_vars_int
        ldr r6,[r6]

buc_list_int:
        cmp r5,r6
        beq f_interpr
        //Imprime "%var: "
        mov r0,r4
        bl printString
	mov r0,#':'
	bl write_uart
	mov r0,#' '
	bl write_uart
        //Imprime el valor de la variable.
        ldr r0,[r4,#12]!
        bl printInt
        mov r0,#'\n'
        bl write_uart
        add r5,r5,#1
        add r4,r4,#4
        b buc_list_int

ej_pause:
        ldr r0,=mensaje_pausa
        bl printString
        bl read_uart
        mov r0,#'\n'
        bl write_uart
        b f_interpr

ej_if:
        ldrb r5,[r4,#5]         //Se carga en r5 el operador que introduce el usuario.
        cmp r5,#61
        beq if_igual
        cmp r5,#60
        beq if_men
        cmp r5,#62
        beq if_may
        cmp r5,#33
        beq if_desigual
        b error_cmd

if_igual:
        ldrb r0,[r4,#4]         //Se carga el número del primer registro que introduce el usuario.
        sub r0,r0,#48
        mov r2,#4
        mul r7,r2,r0
        ldr r1,=registros_virtuales
        ldr r0,[r1,r7]          //Se carga el valor del primer registro que pide el usuario.
        ldrb r3,[r4,#7]
        sub r3,r3,#48
        mul r7,r2,r3
        ldr r3,[r1,r7]          //Se carga el valor del segundo registro que pide el usuario.
        cmp r0,r3
        addeq r4,r4,#9          //Carga la orden de después del if.
        beq comprueba_help      //Comprueba de qué orden se trata y la ejecuta si se cumple la condición.
        b ifnot

if_men:
        ldrb r5,[r4,#6]         //Se comprueba si después del menor que, hay un igual, indicando una desigualdad no estricta.
        cmp r5,#61
        beq if_menigual
        ldrb r0,[r4,#4]         //Se carga el número del primer registro que introduce el usuario.
        sub r0,r0,#48
        mov r2,#4
        mul r7,r2,r0
        ldr r1,=registros_virtuales
        ldr r0,[r1,r7]          //Se carga el valor del primer registro que pide el usuario.
        ldrb r3,[r4,#7]
        sub r3,r3,#48
        mul r7,r2,r3
        ldr r3,[r1,r7]          //Se carga el valor del segundo registro que pide el usuario.
        cmp r0,r3
        addlt r4,r4,#9
        blt comprueba_help      //Comprueba de qué orden se trata y la ejecuta si se cumple la condición.
        b ifnot

if_may:
        ldrb r5,[r4,#6]         //Se comprueba si después del mayor que, hay un igual, indicando una desigualdad no estricta.
        cmp r5,#61
        beq if_mayigual
        ldrb r0,[r4,#4]         //Se carga el número del primer registro que introduce el usuario.
        sub r0,r0,#48
        mov r2,#4
        mul r7,r2,r0
        ldr r1,=registros_virtuales
        ldr r0,[r1,r7]          //Se carga el valor del primer registro que pide el usuario.
        ldrb r3,[r4,#7]
        sub r3,r3,#48
        mul r7,r2,r3
        ldr r3,[r1,r7]          //Se carga el valor del segundo registro que pide el usuario.
        cmp r0,r3
        addgt r4,r4,#9
        bgt comprueba_help      //Comprueba de qué orden se trata y la ejecuta si se cumple la condición.
        b ifnot

if_menigual:
        ldrb r0,[r4,#4]         //Se carga el número del primer registro que introduce el usuario.
        sub r0,r0,#48
        mov r2,#4
        mul r7,r2,r0
        ldr r1,=registros_virtuales
        ldr r0,[r1,r7]          //Se carga el valor del primer registro que pide el usuario.
        ldrb r3,[r4,#8]
        sub r3,r3,#48
        mul r7,r2,r3
        ldr r3,[r1,r7]          //Se carga el valor del segundo registro que pide el usuario.
        cmp r0,r3
        addle r4,r4,#10
        ble comprueba_help      //Comprueba de qué orden se trata y la ejecuta si se cumple la condición.
        b ifnot

if_mayigual:
        ldrb r0,[r4,#4]         //Se carga el número del primer registro que introduce el usuario.
        sub r0,r0,#48
        mov r2,#4
        mul r7,r2,r0
        ldr r1,=registros_virtuales
        ldr r0,[r1,r7]          //Se carga el valor del primer registro que pide el usuario.
        ldrb r3,[r4,#8]
        sub r3,r3,#48
        mul r7,r2,r3
        ldr r3,[r1,r7]          //Se carga el valor del segundo registro que pide el usuario.
        cmp r0,r3
        addge r4,r4,#10
        bge comprueba_help      //Comprueba de qué orden se trata y la ejecuta si se cumple la condición.
        b ifnot

if_desigual:
        ldrb r0,[r4,#4]         //Se carga el número del primer registro que introduce el usuario.
        sub r0,r0,#48
        mov r2,#4
        mul r7,r2,r0
        ldr r1,=registros_virtuales
        ldr r0,[r1,r7]          //Se carga el valor del primer registro que pide el usuario.
        ldrb r3,[r4,#8]
        sub r3,r3,#48
        mul r7,r2,r3
        ldr r3,[r1,r7]          //Se carga el valor del segundo registro que pide el usuario.
        cmp r0,r3
        addne r4,r4,#10
        bne comprueba_help      //Comprueba de qué orden se trata y la ejecuta si se cumple la condición.
        b ifnot 

ifnot:
        ldr r0,=error_ifnot
        bl printString
        b f_interpr

//Fin de if.----------------------------------------------------------------------------------------------
error_cmd:
        mov r10, #ERR_NON_VALID
        b f_interpr
        
f_interpr:
        mov r0, r10                  // Copiamos el codigo de error en r0, que guarda el valor de retorno
        add sp, #TAM_STRING         // Liberamos la variable auxiliar
        ldmia sp!, {r4-r10, pc}

.end
