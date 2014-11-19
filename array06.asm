# Escreva um programa que leia 10 números,
# armazenando-os em um array e mostre o maior
# número e em que índice se encontra.


.data 
newArray:	.word 	0:10	# array de words que armazenará valores coletados
size:		.word 	10	# tamanho do array
espaco:		.asciiz	" "

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

######### verificação do maior número

add 	$t0, $zero, $a0
add	$t1, $zero, $a1
addi	$t7, $zero, 1

out:
	lw	$a0, 0($t0)
	add	$t6, $zero, $a0
	slt	$t5, $t6, $t7
	bne	$t5, $zero, saltaSoma
	
	add	$t7, $zero, $t6	# recebe maior número
	add	$t9, $zero, $t0 # recebe endereço do maior número
	
	
	saltaSoma:
	addi	$t0, $t0, 4
	addi	$t1, $t1, -1
	bgtz	$t1, out

#########------------------------------- IMPRESSÃO

print:
	# imprime numero maior
	add	$a0, $zero, $t7 
	addi	$v0, $zero, 1
	syscall
	
	#la	$a0, head
	lui	$at, 0x1001
	addi	$a0, $at, 0x2c
	
	#li	$v0, 4
	addi	$v0, $zero, 4
	syscall
		
	# imprima endereço do maior número
	add	$a0, $zero, $t9 
	addi	$v0, $zero, 1
	syscall
