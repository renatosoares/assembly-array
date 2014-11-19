# Escreva um programa que leia 20 números e diga quantos são pares e quais são.

.data 
newArray:	.word 	0:19	# array de words que armazenará valores coletados
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
j	print
###################================================

# Sub-rotina para imprimir os números em linha
.data
space:		.asciiz 	" "
head:		.asciiz  	"Sequência digitada:\n"
numpar:		.asciiz		"par"
frase:		.asciiz		"Quantidade de pares \n"
#numimp:		.asciiz		"impar"
.text
print:	
	add 	$t0, $zero, $a0
	add	$t3, $zero, $a0
	add	$t1, $zero, $a1
	add	$t2, $zero, $a1
	
	#imprimir string
	#la	$a0, head
	lui	$at, 0x1001
	addi	$a0, $at, 0x52
	#li	$v0, 4
	addi	$v0, $zero, 4
	syscall
	
	procuraPar:
		lw	$t9, 0($t0)
		addi	$t0, $t0, 4	# Soma mais quatro, para que a memória salte uma casa
		#li	$v0, 1
		addi	$t8, $zero, 2
		div	$t9, $t8
		mfhi	$t7
		
		addi	$t2, $t2, -1	# contador 
		bne	$t7, $zero, procuraPar
	
	
		addi 	$s7, $s7, 1	# soma a quantidade de numeros pares no array
	
		bgtz	$t2, procuraPar
		addi	$s7, $s7, -1	# parece mas não é uma gambiarra
		add	$t1, $zero, $s7
		
		# imprime a quantidade de pares
		add	$a0, $zero, $s7
		addi	$v0, $zero, 1
		syscall
		
		# imprime uma estring com salto
		#imprimir string
		la	$a0, frase
		#lui	$at, 0x1001
		#addi	$a0, $at, 0x52
		#li	$v0, 4
		addi	$v0, $zero, 4
		syscall
		
		
	# imprime números pares
	
	procuraParImprime:
		lw	$t9, 0($t3)
		addi	$t3, $t3, 4	# Soma mais quatro, para que a memória salte uma casa
		#li	$v0, 1
		addi	$t8, $zero, 2
		div	$t9, $t8
		mfhi	$t7
		
		bne	$t7, $zero, procuraParImprime
		
		#imprime numeros pares
		# imprime string
		##la	$a0, numpar
		lui	$at, 0x1001
		addi	$a0, $at, 0x67
		addi	$v0, $zero, 4
		syscall
			
		#imprime valor númerico par
		add	$a0, $zero, $t9
		addi	$v0, $zero, 1
		syscall
	
		# imprime espaço
		#la	$a0, space
		lui	$at, 0x1001
		addi	$a0, $at, 0x50
		#li	$v0, 4
		addi	$v0, $zero, 4
		syscall
	
		# decrementa o contador e verifica se $t1 é menor do que zero
		addi	$t1, $t1, -1
		bgtz	$t1, procuraParImprime
#########################################abaixo será alterado
	
fim:
	addi	$v0, $zero, 10
	syscall
