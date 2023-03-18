.data
inputMsg: .asciiz "Masukkan input 10 digit: "
totalMobilMsg: .asciiz "Total penjualan mobil : "
totalMotorMsg: .asciiz "\nTotal penjualan motor : "

arrayMobil: .word 0, 0, 0, 0, 0
arrayMotor: .word 0, 0, 0, 0, 0

.text
.globl main
main:
	# load arrayMobil to $s0
	la $s0, arrayMobil
	
	# load arrayMotor to $s1
	la $s1, arrayMotor
	
	# syscall 4 to print string inputMsg
	li $v0, 4
	la $a0, inputMsg
	syscall
	
	# syscall 5 to read integer input from user
	li $v0, 5
	syscall
	
	# save input to $t0
	add $t0, $v0, $zero
	
	# initialize iterator for loop
	and $t1, $t1, $zero
	
loop:
	# divide input by 100
	div $t0, $t0, 100
	mflo $t0 # store quotient at $t0
	mfhi $t2 # store remainder at $t2 (2 digits)
	
	# divide remainder by 10
	div $t2, $t2, 10
	mflo $t2 # store quotient at $t2
	mfhi $t3 # store remainder at $t3
	
	# store quotient from $t2 to $s1 (arrayMotor)
	sw $t2, 0($s1)
	
	# store remainder from $t3 to $s0 (arrayMobil)
	sw $t3, 0($s0)
	
	# move arrayMotor ($s1) and arrayMobil's ($s0) pointer to the next index
	addi $s1, $s1, 4
	addi $s0, $s0, 4
	
	# increment iterator
	addi $t1, $t1, 1
	
	# loop if number of times != 5
	bne $t1, 5, loop

	# initialize counter for motor ($t2) and mobil ($t3)
	and $t2, $t2, $zero
	and $t3, $t3, $zero
	
add_array_element:
	# move arrayMotor ($s1) and arrayMotor's ($s0) pointer backwards (from last to first)
	subi $s1, $s1, 4
	subi $s0, $s0, 4

	# get element of arrayMotor at current index and add it to counter
	lw $t4, 0($s1)
	add $t2, $t2, $t4
	
	# get element of arrayMobil at current index and add it to counter
	lw $t4, 0($s0)
	add $t3, $t3, $t4
	
	# decrement iterator
	subi $t1, $t1, 1
	
	# loop if number of times != 5
	bne $t1, 0, add_array_element

exit:
	# syscall 4 to print string totalMobilMsg
	li $v0, 4
	la $a0, totalMobilMsg
	syscall
	
	# syscall 1 to print integer total penjualan mobil ($t4)
	li $v0, 1
	add $a0, $t3, $zero
	syscall
	
	# syscall 4 to print string totalMotorMsg
	li $v0, 4
	la $a0, totalMotorMsg
	syscall
	
	# syscall 1 to print integer total penjualan motor ($t3)
	li $v0, 1
	add $a0, $t2, $zero
	syscall
	
	# syscall 10 to exit
	li $v0, 10
	syscall