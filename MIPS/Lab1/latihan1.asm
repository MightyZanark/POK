.data
welcomeMsg1: .asciiz "Selamat Datang di Restoran Peokra!\n"
welcomeMsg2: .asciiz "Masukkan banyak kategori pesanan: "

menuMsg: .asciiz "Total menu yang dipesan pada kategori "
semicolon: .asciiz ": "

totalMsg: .asciiz "Total Harga Pesanan: "

errorMsg: .asciiz "Minimal pesan satu makanan!"

.text
.globl main
main:
	# loads syscall 4 to print string welcomeMsg1
	li $v0, 4
	la $a0, welcomeMsg1
	syscall
	
	# loads syscall 4 to print string welcomeMsg2
	li $v0, 4
	la $a0, welcomeMsg2
	syscall
	
	# loads syscall 5 to read integer input (banyak kategori pesanan)
	li $v0, 5
	syscall
	
	# checks if banyak kategori pesanan < 1
	blt $v0, 1, error
	# if kategori pesanan >= 1, store to $s0; else go to exit
	add $s0, $v0, $zero
	
	# initialize iterator
	addi $t0, $zero, 1
	
	# initialize sum
	and $t1, $t1, $zero
	
loop:
	# loads syscall 4 to print string menuMsg
	li $v0, 4
	la $a0, menuMsg
	syscall
	
	# loads syscall 1 to print current kategori num
	li $v0, 1
	add $a0, $t0, $zero
	syscall
	
	# loads syscall 4 to print string semicolon
	li $v0, 4
	la $a0, semicolon
	syscall
	
	# loads syscall 5 to read integer input (banyak menu kategori x)
	li $v0, 5
	syscall
	
	# checks if banyak makanan < 1
	blt $v0, 1, error
	# if banyak makanan >= 1, store to $t2; else go to exit
	add $t2, $v0, $zero
	
	# initialize price for current kategori
	mul $t3, $t0, 5000
	
	# store current total price of menu ordered * current price
	mul $t4, $t2, $t3
	add $t1, $t1, $t4

	# reset $t2 and $t3
	and $t2, $t2, $zero
	and $t3, $t3, $zero
	
	# +1 to iterator and check if its still <= banyak kategori
	addi $t0, $t0, 1
	ble $t0, $s0, loop

end:
	# loads syscall 4 to print string totalMsg
	li $v0, 4
	la $a0, totalMsg
	syscall
	
	# loads syscall 1 to print integer jumlah harga makanan (sum)
	li $v0, 1
	add $a0, $t1, $zero
	syscall
	
	# loads syscall 10 to exit the program
	li $v0, 10
	syscall
	
error:
	# loads syscall 4 to print string errorMsg
	li $v0, 4
	la $a0, errorMsg
	syscall

	# loads syscall 10 to exit the program
	li $v0, 10
	syscall 
	