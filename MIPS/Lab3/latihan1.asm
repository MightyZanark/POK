.data
inputMsg: .asciiz "Masukkan string berukuran 10: "
outputMsg: .asciiz "\nHasil: "

# array untuk char yang memenuhi kriteria
resultArray: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
.globl main
main:
	# load address of resultArray to $s0
	la $s0, resultArray
	
	# syscall 4 to print inputMsg
	li $v0, 4
	la $a0, inputMsg
	syscall
	
	# initialize iterator
	and $t0, $t0, $zero
	
	# initialize pointer offset
	and $t1, $t1, $zero

# loop for first 5 char
loopUpper:
	# syscall 12 to read input char
	li $v0, 12
	syscall
	
	# increment iterator
	addi $t0, $t0, 1
	
	# checks if current char is within the uppercase alphabet ASCII range
	# check if current char >= 65
	blt $v0, 65, checkIteratorUpper
	
	# check if current char <= 90
	bgt $v0, 90, checkIteratorUpper

	# put character inside of charArrayUpper
	sb $v0, 0($s0)
	
	# move charArrayUpper's pointer up
	addi $s0, $s0, 1
	
	# increment pointer offset
	addi $t1, $t1, 1

checkIteratorUpper:
	# loop while iterator != 5
	bne $t0, 5, loopUpper

# loop for last 5 char
loopLower:
	# syscall 12 to read input char
	li $v0, 12
	syscall

	# decrement iterator
	subi $t0, $t0, 1

	# checks if current char is within the lowercase alphabet ASCII range
	# check if current char >= 97
	blt $v0, 97, checkIteratorLower
	
	# check if current char <= 122
	bgt $v0, 122, checkIteratorLower
	
	# put character inside of charArrayUpper
	sb $v0, 0($s0)

	# move charArrayUpper's pointer up
	addi $s0, $s0, 1
	
	# increment pointer offset
	addi $t1, $t1, 1
		
checkIteratorLower:
	# loop while iterator != 0
	bne $t0, 0, loopLower

setupBeforePrint:
	# reset array pointer to first index
	sub $s0, $s0, $t1
	subi $s1, $s1, 5

	# syscall 4 to print outputMsg
	li $v0, 4
	la $a0, outputMsg
	syscall
	
	# initialize iterator
	and $t0, $t0, $zero

loopPrint:
	# syscall 11 to print char on current index
	li $v0, 11
	lb $a0, 0($s0)
	syscall
	
	# move charArrayUpper's pointer up
	addi $s0, $s0, 1
	
	# increment iterator
	addi $t0, $t0, 1
	
	# loop as long as input is not 0
	bne $a0, $zero, loopPrint
	
	# or number of times looped is not 10
	bne $t0, 10, loopPrint

exit:
	li $v0, 10
	syscall
	
