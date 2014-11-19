# Escreva um programa que leia 19 números e mostre-os na ordem em que foram lidos.
.data 
newArray:	.word	0:19	# array de words que armazenará valores coletados
size:		.word 	19	# tamanho do array

.text
main:
#la	$s0, newArray	# carregue endereço do array
lui	$at, 0x1001 
add	$s0, $zero, $at

#la	$s5, size	# carregue endereço do tamanho variável
lui	$at, 0x1001
addi 	$s5, $at, 0x4c


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

# Os números são computados e armazenados no array
#la	$a0, fibs
lui	$at, 0x1001
add	$a0, $zero, $at

add	$a1, $zero, $s5
jal	print

	
# fializa o sistema retornando zero
	addi	$v0, $zero, 10
	syscall
###################================================

# Sub-rotina para imprimir os números em linha
.data
space:	.asciiz " "
head:	.asciiz  "Sequência digitada:\n"
.text
print:	
	add 	$t0, $zero, $a0
	add	$t1, $zero, $a1
	
	#la	$a0, head
	lui	$at, 0x1001
	addi	$a0, $at, 0x52
	
	#li	$v0, 4
	addi	$v0, $zero, 4
	syscall
	
out:
	lw	$a0, 0($t0)
	#li	$v0, 1
	addi	$v0, $zero, 1
	syscall
	
	#la	$a0, space
	lui	$at, 0x1001
	addi	$a0, $at, 0x50
	#li	$v0, 4
	addi	$v0, $zero, 4
	syscall
	
	addi	$t0, $t0, 4
	addi	$t1, $t1, -1
	bgtz	$t1, out

	
	jr   	$ra              # return from subroutine
