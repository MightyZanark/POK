.data
openingMsg1: .asciiz "Selamat datang pada awal perjalananmu, petualang!\n"
openingMsg2: .asciiz "Sebelum memulai petualanganmu, silahkan memperkenalkan dirimu terlebih dahulu\n"

askNpm: .asciiz "Masukkan NPM Kamu: "
askSks: .asciiz "Masukkan jumlah SKS yang kamu ambil: "

greetMsg1: .asciiz "Halo petualang dengan NPM "
greetMsg2: .asciiz ". Semoga dengan mengambil "
greetMsg3: .asciiz " SKS anda bisa menyelesaikan petualangan ini dengan baik!"

.text
.globl main
main:
    # loads syscall 4 to print string openingMsg1
    li $v0, 4
    la $a0, openingMsg1
    syscall

    # loads syscall 4 to print string openingMsg2
    li $v0, 4
    la $a0, openingMsg2
    syscall

    # loads syscall 4 to print string askNpm
    li $v0, 4
    la $a0, askNpm
    syscall
    
    # loads syscall 5 to read integer input (npm)
    li $v0, 5
    syscall
    add $t0, $v0, $zero # store inputted npm at $t0
    
    # loads syscall 4 to print string askSks
    li $v0, 4
    la $a0, askSks
    syscall
    
    # loads syscall 5 to read integer input (sks)
    li $v0, 5
    syscall
    add $t1, $v0, $zero # store inputted sks at $t1
    
    # loads syscall 4 to print string greetMsg1
    li $v0, 4
    la $a0, greetMsg1
    syscall
    
    # loads syscall 1 to print integer npm
    li $v0, 1
    add $a0, $t0, $zero # loads npm at $t0 to $a0
    syscall
    
    # loads syscall 4 to print string greetMsg2
    li $v0, 4
    la $a0, greetMsg2
    syscall
    
    # loads syscall 1 to print integer sks
    li $v0, 1
    add $a0, $t1, $zero # loads sks at $t1 to $a0
    syscall
    
    # loads syscall 4 to print greetMsg3
    li $v0, 4
    la $a0, greetMsg3
    syscall
    
    # loads syscall 10 to exit the program
    li $v0, 10
    syscall