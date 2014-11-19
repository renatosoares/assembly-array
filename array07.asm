# Escreva um programa que leia 10 números, armazenando-os
# em um array e mostre o maior e o menor número
# e em que índice do array ele se encontram.

.data 
newArray:	.word 	0:10	# array de words que armazenará valores coletados
size:		.word 	10	# tamanho do array
espaco:		.asciiz	" "
quebra:		.asciiz	"\n"

.text
main:
#la	$s0, newArray	# carregue endereço do array
lui	$at, 0x1001
add	$s0, $zero, $at

#la	$s5, size	# carregue endereço do tamanho variável
lui	$at, 0x1001
addi 	$s5, $at, 0x28


lw	$s5, 0($s5)	# carregue tamanho do array

add 	$s1, $zero, $s5

	#loop que insere valores na memória
	loopAdd:
		addi	$v0, $zero, 5
		syscall
		add	$s2, $zero, $v0

		sw	$s2, 0($s0)
		addi	$s0, $s0, 4

		addi	$s1, $s1, -1
		bgtz	$s1, loopAdd	# Se maior que zero vá para repetição
###################================================
# armazenando uma posição da memória
lui	$at, 0x1001
add	$a0, $zero, $at

add	$a1, $zero, $s5	# valor a ser decrementado

######### valores para controle

add 	$t0, $zero, $a0	# endereço da memória
add	$t1, $zero, $a1 # valor a ser decrementado na memória que será usada na função encontraMaior
addi	$t7, $zero, 1
addi	$s7, $zero, 4

add	$t2, $zero, $a0	# endereço da memória
add	$t3, $zero, $a1 # valor a ser decrementado na memória que será usada na função encontraMenor
addi	$t4, $zero, 1

#########------------------------------- encontra o maior
encontraMaior:
	lw	$a0, 0($t0)
	add	$t6, $zero, $a0
	slt	$t5, $t6, $t7
	
	bne	$t5, $zero, saltaContMaior
	
	add	$t7, $zero, $t6		# recebe maior número
	# refinando o endereço do array
	addi	$t8, $t0, -268500992
	div	$t8, $s7
	mflo	$t9			# recebe endereço do maior número
	
	
	
	saltaContMaior:
	#addi	$t8, $t8, 1
	addi	$t0, $t0, 4
	addi	$t1, $t1, -1
	bgtz	$t1, encontraMaior
	


#########------------------------------- encontra o menor
add	$t4, $zero, $t7
add	$t8, $zero, $zero

encontraMenor:
	lw	$a0, 0($t2)
	add	$t6, $zero, $a0
	slt	$t5, $t6, $t4
	
	beq	$t5, $zero, saltaContMenor
	
	add	$t4, $zero, $t6	# recebe menor número
	# refinando o endereço do array
	addi	$t8, $t2, -268500992
	div	$t8, $s7
	mflo	$t0			# recebe endereço do maior número
	
	
	saltaContMenor:
	addi	$t2, $t2, 4
	addi	$t3, $t3, -1
	bgtz	$t3, encontraMenor
	


#########------------------------------- IMPRESSÃO

printMaior:
	# imprime numero maior
	add	$a0, $zero, $t7 
	addi	$v0, $zero, 1
	syscall
	
	# espaço
	lui	$at, 0x1001
	addi	$a0, $at, 0x2c
	addi	$v0, $zero, 4
	syscall
		
	# imprima endereço do maior número
	add	$a0, $zero, $t9 
	addi	$v0, $zero, 1
	syscall


printMenor:
	# quebra de linha
	lui	$at, 0x1001
	addi	$a0, $at, 0x2e
	addi	$v0, $zero, 4
	syscall


	# imprime numero menor
	add	$a0, $zero, $t4 
	addi	$v0, $zero, 1
	syscall
	
	# espaço
	lui	$at, 0x1001
	addi	$a0, $at, 0x2c
	addi	$v0, $zero, 4
	syscall
		
	# imprima endereço do menor número
	add	$a0, $zero, $t0 
	addi	$v0, $zero, 1
	syscall
