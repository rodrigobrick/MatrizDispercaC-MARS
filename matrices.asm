.data
txt1:.asciiz " ******** MENU ********\n\n 1.- Ingresar Matriz.\n\n Ingrese Opcion: "
txt2:.asciiz " \nOpcion Ingresada Invalida!\n\n "
txt3:.asciiz "\n Ingrese Valor: "
txt4:.asciiz " "
txt5:.asciiz "\n"
txt6:.asciiz " Matriz\n\n"
txt7:.asciiz " \n\n Matriz Comprimida\n\n"
txt8:.asciiz " Fila     "
txt9:.asciiz "\n Columna  "
txt10:.asciiz "\n Valor    "

M:  .align 2
    .space 80

C:  .align 2
    .space 80
  
.text
.globl menu
menu:
	add $t1, $zero, $zero      # indice
	add $t2, $zero, $zero      # contador de numeros mayores a 0
	la $a0, txt1		# carga txt1
	li $v0, 4		# muestra mensaje
	syscall
	li $v0, 5	        # lee valores
	syscall
	move $a0,$v0
	beq $a0, 1, ingresar
	#beq $a0 2,generar
	b salir
	
reiniciar_cont:
	add $t1, $zero, $zero      # indice
	la $a0, txt5		  # carga txt5 nueva linea
	li $v0, 4
	syscall
	la $a0, txt6		  # carga Matriz
	li $v0, 4
	syscall
	j mostrar

ingresar:
	beq $t1, 80, reiniciar_cont
	la $a0, txt3		  # carga txt3
	li $v0, 4
	syscall
	li $v0, 5	        # lee valores
	syscall
	move $t3, $v0
	sw $t3, M($t1)           # guarda lo leido en el arreglo
	add $t1, $t1, 4          # aumenta el indice ("suma 1")
	j ingresar
	
	
posicion:
	
	sw $t7, C($t2)
	addi $t2, $t2, 4
	sw $t6, C($t2)
	
	lw $t4, M($t1)
	addi $t2, $t2, 4
	sw $t4, C($t2)
	
lbl3:
	addi $t2, $t2, 4      # contador de numeros mayores a 0
	j lbl2
	
salto:
	addi $t7, $t7, 1             # t7 = i
	add $t6, $zero, $zero        # t6 = j
	la $a0, txt5		  # carga txt5 nueva linea
	li $v0, 4
	syscall
	j lbl

mostrar:

	beq $t1, 80, salto2
	
	beq $t1, 20, salto
	beq $t1, 40, salto
	beq $t1, 60, salto

lbl:
	la $a0 txt4
	li $v0 4           # imprime espacio
	syscall
	lw $a0, M($t1)
	bgt $a0, 0, posicion
	
lbl2:
	li $v0, 1
	syscall
	
	addi $t6, $t6, 1
	addi $t1, $t1, 4
	j mostrar
	
salto2:
	la $a0 txt7
	li $v0 4           # imprime espacio
	syscall
	la $a0 txt8
	li $v0 4           # imprime fila
	syscall
	j mostrar_comprimir1
	
mostrar_comprimir1:	
	beq $t5, 72, salto3
	
	la $a0 txt4
	li $v0 4           # imprime espacio
	syscall
	
	lw $a0, C($t5)
	li $v0, 1
	syscall
	addi $t5, $t5, 12
	j mostrar_comprimir1
	
salto3:
	add $t5, $zero, $zero
	addi $t5, $t5, 4
	la $a0 txt9
	li $v0 4           # imprime columna
	syscall
	j mostrar_comprimir2
	
mostrar_comprimir2:	
	beq $t5, 76, salto4
	
	la $a0 txt4
	li $v0 4           # imprime espacio
	syscall
	
	lw $a0, C($t5)
	li $v0, 1
	syscall
	addi $t5, $t5, 12
	j mostrar_comprimir2
	
salto4:
	add $t5, $zero, $zero
	addi $t5, $t5, 8
	la $a0 txt10
	li $v0 4           # imprime columna
	syscall
	j mostrar_comprimir3
	
mostrar_comprimir3:	
	beq $t5, 80, salir
	
	la $a0 txt4
	li $v0 4           # imprime espacio
	syscall
	
	lw $a0, C($t5)
	li $v0, 1
	syscall
	addi $t5, $t5, 12
	j mostrar_comprimir3


		
salir:
	la $a0, txt5		  # carga txt5 nueva linea
	li $v0, 4
	syscall
	li $v0 10
	syscall	
