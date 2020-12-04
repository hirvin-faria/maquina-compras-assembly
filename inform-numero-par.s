.data
msg1:	.asciiz "Entre com um numero: "
msg2:	.asciiz "O numero eh par.\n"
msg3:	.asciiz "O numero eh impar.\n"

.text
	.globl main
main:	
	li $v0, 4
	la $a0, msg1
	syscall	# Mostra mensagem solicitando numero
	li $v0, 5
	syscall	# Le o numero
	move $t0, $v0	# Armazena numero lido em $t0
	li $t1, 2
	div $t0, $t1
	mfhi $t1	# $t1 recebe o resto da divisao de $t0 por 2
	beq $t1,$0,par	# Se $t1==0 salta para "par"
	li $v0, 4
	la $a0, msg3
	syscall	# Mostra mensagem que eh impar
	b fim_se	# Salta para o final do "se"
par:	li $v0, 4
	la $a0, msg2
	syscall	# Mostra mensagem que eh par
fim_se:	li $v0, 10
	syscall	# Termina execucao
