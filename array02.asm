# Escreva um programa que leia 10 números e mostre-os na ordem inversa a que foram lidos.
.data
newArray:	.word	0:19 	# array de words que armazenará valores coletados
size:		.word	19	# tamanho do array

.text
main:
# carregue o endereço do array
lui	$at, 0x1001
add	$s0, $zero, $at

# carregue o endereço do tamanho variável
lui	$at, 0x1001
addi	$s5, $at, 0x4c	

lw	$s5, 0($s5) 		#carregue o tamanho do array
	
add	$s1, $zero, $s5		# $s1 recebe valor para controle do loop

# loop que insere valores na memória
loopAdd:
	# syscall coleta dados do usuário
	addi	$v0, $zero, 5
	syscall
	add	$s2, $zero, $v0
	
	sw	$s2, 0($s0) 	# armazena valor coletado na memória
	addi	$s0, $s0, 4	# soma mais quatro ao valor do endereço da memória para realizar o salto
	
	addi	$s1, $s1, -1	# contador do loop
	bgtz	$s1, loopAdd	# se maior que zero vá para label definida
	
############################======================================
# Os números são computados e armazenados no array

lui	$at, 0x1001
add	$a0, $zero, $at

add	$a1, $zero, $s5
j	print

############################=====================================

# Sub-rotina para imprimir os números em linha
.data
space:	.asciiz " "
head:	.asciiz  "Sequência digitada invertida:\n"
.text
print:	
	add 	$t0, $zero, $a0
	addi	$t0, $t0, 0x48
	add	$t1, $zero, $a1
	
	lui	$at, 0x1001
	addi	$a0, $at, 0x52

	addi	$v0, $zero, 4
	syscall
	
out:
	lw	$a0, 0($t0)

	addi	$v0, $zero, 1
	syscall
	

	lui	$at, 0x1001
	addi	$a0, $at, 0x50
	

	addi	$v0, $zero, 4
	syscall
	
	addi	$t0, $t0, -4
	addi	$t1, $t1, -1
	bgtz	$t1, out
	
fim:
	addi	$v0, $zero, 10
	syscall
