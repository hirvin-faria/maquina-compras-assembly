.data
msg1:	.asciiz "Insira o valor na maquina: "
msg7:   .asciiz "\nTecle 0 para encerrar ou Insira um Valor:"
msg2:	.asciiz "\nO valor inserido foi de: R$ "
msg3:	.asciiz "\n Inform o produto a ser comprado.\n Código: \n 1. Agua - PRECO: R$2,00. \n 2. Refrigerante - PRECO: R$5,00. \n"
msg4:	.asciiz "O produto selecionado foi a Agua - PRECO: R$2,00. \n"
msg5:	.asciiz "O produto selecionado foi o Refrigerante - PRECO: R$5,00.\n"
msg6:   .asciiz "\n Seu troco será de: "


msg8:   .asciiz "\n Quantidade de Notas de 20: "
msg9:   .asciiz "\n Quantidade de Notas de 10: "
msg10:  .asciiz "\n Quantidade de Notas de 5: "
msg11:  .asciiz "\n Quantidade de Notas de 2: "


.text
	.globl main

# RECEBE VALOR E INFORMA A QUANTIA
# t0 = Total Inserido
# t1 = Valor Inserido
main:

    li		$v0, 4 		# Informa a saída do tipo String na tela
    la		$a0, msg1   # Informa a String que sera exibida
    syscall             # Exibe a mensagem

    li      $v0, 5      # Informa a inserção de um valor Inteiro
	syscall	            # Leitura do valor
	move    $t0, $v0	# Armazena numero intiro inserido em $v0 para $t0



# LOOP PARA INSERCAO DE MAIS NOTAS
enquantovalor:
    li      $v0, 4      # Informa a exibição na tela do Tipo String     
    la		$a0, msg2   # Informa a String a ser exibida
    syscall             # Imprime a mensagem do valor que foi inserido

    li $v0, 1           # Intorma a impressão de um valor Inteiro
	move $a0, $t0       # Informa a impressão do valor inserido para exibição. Esse valor foi armazenado no registrados $t0
    syscall             # Imprime o valor Inteiro Inserido



    li		$v0, 4 		# Informa a saída do tipo String na tela
    la		$a0, msg7   # Informa a String que sera exibida
    syscall             # Exibe a mensagem de inserir mais valor ou finalizar

    li      $v0, 5      # Informa a inserção de dado
	syscall	            # Leitura do dado
	move    $t1, $v0	# Armazena numero lido em $v0 para $t1 para verificação



    beq	    $t1, $0, fimenquantovalor	    # if $t1 == 0 executa fimenquantovalor
    add		$t0, $t0, $t1		            # $t0 = $01 + 1t2 - Soma o valor da nota inserida
    j       enquantovalor                   # salta para o inicio do loop 
fimenquantovalor:                           # encerra o loop





# RECEBE O NUMERO DO PRODUTO E INFORMA SEU PREÇO
    li		$v0, 4 		        # Informa a exibição na tela
    la		$a0, msg3           # Informa oque sera exibido
    syscall                     # Exibe a mensagem para inserir dinheiro

    li      $v0, 5              # Informa a inserção de dado
	syscall	                    # Leitura do dado
	move    $t1, $v0	        # Armazena numero lido em $v0 para $t1





# VERIFIA QUAL FOI O PRODUTO ESCOLHIDO E INFORMA
    beq	    $t1, 1, se	        # if $t0 == $t1 executa bloco se-codProduto
    j		senao		        # executa o bloco senao
    
se:
    # EXIBE MENSAGEM
    li      $v0, 4              # Informa a exibição na tela        
    la		$a0, msg4           # Informa a mensagem de seleção do produto agua
    syscall                     # Imprime a mensagem

    # SETA O VALOR DO PRODUTO
    li      $t1, 2              # Define o preço da agua para 2.

    j       fimse               # Executa bloco do fim se para finalizar o instrucao se
    
senao:
    li      $v0, 4              # Informa a exibição na tela        
    la		$a0, msg5           # Informa mensagem de seleção do produto refrigerante
    syscall                     # Imprime a mensagem

    # SETA O VALOR DO PRODUTO
    li      $t1, 5              # Define o preço do Refrigerante para 5.

fimse:





# CALCULA O TROCO E INFORMA SEU VALOR

    sub		$t2, $t0, $t1       # $t2 (TROCO) = $t0 (VALOR INSERIDO) -  $t1 (PREÇO) 


    li		$v0, 4 		        # Informa que sera exibido uma String
    la		$a0, msg6           # Informa qual String será exibida (msg6 - Mensagem de Trooo) 
    syscall                     # Exibe a mensagem de Troco

    li      $v0, 1              # Informa que sera exibido um Inteiro
    move    $a0, $t2            # Informa o valor Inteiro que sera exibido
    syscall                     # Exibe o Valor Intero, correspondente ao Troco





# CALCULA QUANTIDADE DE NOTAS
# Set do valor das notas
    li      $s0, 20             # Notas de 20
    li      $s1, 10             # Notas de 10
    li      $s2, 5              # Notas de 5
    li      $s3, 2              # Notas de 2



# Calculo das notas de 20
setroco20:
    blt		$t2, $s0, elsetroco20	# if TROCO < NOTA 20 salta para ELSETROCO20

    div		$t2, $s0			    # divide $t2 (TROCO) por 20
    mflo	$t3					    # Armazena o quociente da divisão em $t3        (REPRESENTA A QUANTIDADE DE NOTAS DE 20 A SER DISTRIBUIDA)
    mfhi	$t4					    # Armazena o resto da divisao em $t4            (RESTANTE DO VALOR A SER PROCESSADO PARA O TROCO)

    move    $s0, $t3                # Armazena a quantidade de notas de 20 para o troco

    j       fimsetroco20            # Encerra a verificação do calculo.

elsetroco20:                        # Tratamento ELSE caso TROCO seja MENOR que 20
    move    $s0, $0                 # Seta quantidade de notas para 0.


fimsetroco20:



# Calculo das notas de 10
setroco10:
    blt		$t4, $s1, elsetroco10	# if TROCO < NOTA 10 salta para ELSETROCO10

    div		$t4, $s1			    # divide $t4 (TROCO RESTANTE) por 10
    mflo	$t3					    # Armazena o quociente da divisão em $t3        (REPRESENTA A QUANTIDADE DE NOTAS DE 10 A SER DISTRIBUIDA)
    mfhi	$t4					    # Armazena o resto da divisao em $t4            (RESTANTE DO VALOR A SER PROCESSADO PARA O TROCO)

    move    $s1, $t3                # Armazena a quantidade de notas de 10 para o troco

    j       fimsetroco10            # Encerra a verificação do calculo.

elsetroco10:                        # Tratamento ELSE caso TROCO seja MENOR que 10
    move    $s1, $0                 # Seta quantidade de notas para 0.


fimsetroco10:



# Calculo das notas de 5
setroco5:
    blt		$t4, $s2, elsetroco5	# if TROCO < NOTA 5 salta para ELSETROCO5

    div		$t4, $s2			    # divide $t4 (TROCO RESTANTE) por 5
    mflo	$t3					    # Armazena o quociente da divisão em $t3        (REPRESENTA A QUANTIDADE DE NOTAS DE 5 A SER DISTRIBUIDA)
    mfhi	$t4					    # Armazena o resto da divisao em $t4            (RESTANTE DO VALOR A SER PROCESSADO PARA O TROCO)

    move    $s2, $t3                # Armazena a quantidade de notas de 5 para o troco

    j       fimsetroco5            # Encerra a verificação do calculo.

elsetroco5:                        # Tratamento ELSE caso TROCO seja MENOR que 5
    move    $s2, $0                 # Seta quantidade de notas para 0.


fimsetroco5:



# Calculo das notas de 2
setroco2:
    blt		$t4, $s3, elsetroco2	# if TROCO < NOTA 2 salta para ELSETROCO2

    div		$t4, $s3			    # divide $t4 (TROCO RESTANTE) por 2
    mflo	$t3					    # Armazena o quociente da divisão em $t3        (REPRESENTA A QUANTIDADE DE NOTAS DE 2 A SER DISTRIBUIDA)
    mfhi	$t4					    # Armazena o resto da divisao em $t4            (RESTANTE DO VALOR A SER PROCESSADO PARA O TROCO)

    move    $s3, $t3                # Armazena a quantidade de notas de 2 para o troco

    j       fimsetroco2            # Encerra a verificação do calculo.

elsetroco2:                        # Tratamento ELSE caso TROCO seja MENOR que 2
    move    $s3, $0                 # Seta quantidade de notas para 0.


fimsetroco2:






# MENSAGENS DE QUANTIDADE DE TROCO

    li		$v0, 4 		        # Informa que sera exibido uma String.
    la		$a0, msg8           # Informa qual Strig será impressa. 
    syscall                     # Exibe a mensagem para quantidade de notas de 20 do troco.

    li      $v0, 1              
    move    $a0, $s0            
    syscall                     # Exibe a quantidade de notas de 20 do troco.



    li		$v0, 4 		       
    la		$a0, msg9
    syscall                     # Exibe a mensagem para quantidade de notas de 10 do troco.

    li      $v0, 1              
    move    $a0, $s1            
    syscall                     # Exibe a quantidade de notas de 10 do troco.



    li		$v0, 4 		        
    la		$a0, msg10          
    syscall                     # Exibe a mensagem para quantidade de notas de 5 do troco.

    li      $v0, 1              
    move    $a0, $s2          
    syscall                     # Exibe a quantidade de notas de 5 do troco.



    li		$v0, 4 		        
    la		$a0, msg11          
    syscall                     # Exibe a mensagem para quantidade de notas de 2 do troco.

    li      $v0, 1              
    move    $a0, $s3          
    syscall                     # Exibe a quantidade de notas de 2 do troco.






# SISTEMA DE NOTAS

# Set o valor inicial das notas inseridas

# notasinseridas:
#     li      $s0, 0              # Notas de 20
#     li      $s1, 0              # Notas de 10
#     li      $s2, 0              # Notas de 5
#     li      $s3, 0              # Notas de 2
#     li      $s4, 0              # Moedas de 1
#     li      $s5, 0              # Moedas de 50
#     li      $s6, 0              # Moedas de 25
#     li      $s7, 0              # Moedas de 10
#     li      $t9, 0              # Valor do Produto

