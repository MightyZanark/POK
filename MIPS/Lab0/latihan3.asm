.data
openingMsg1: .asciiz "Selamat datang pada awal perjalananmu, petualang!\n"
openingMsg2: .asciiz "Sebelum memulai petualanganmu, silahkan memperkenalkan dirimu terlebih dahulu\n"

askNpm: .asciiz "Masukkan NPM Kamu: "
askNumOfCourses: .asciiz "Masukkan jumlah mata kuliah yang kamu ambil: "

askSksEachCourse: .asciiz "Masukkan SKS mata pelajaran "
colonChar: .asciiz ": "

greetMsg1: .asciiz "Halo petualang dengan NPM "
greetMsg2: .asciiz ". Hebat! Anda mengambil "
greetMsg3: .asciiz " mata kuliah dengan total "
greetMsg4: .asciiz " SKS."

.text
.globl main
main:
askIdentity:
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
    
    # loads syscall 4 to print string askNumOfCourses
    li $v0, 4
    la $a0, askNumOfCourses
    syscall
    
    # loads syscall 5 to read integer input (courses taken)
    li $v0, 5
    syscall
    add $t1, $v0, $zero # store inputted courses taken at $t1

    # load $t2 with 1 for iteration
    addi $t2, $zero, 1

loopCourses:
    # loads syscall 4 to print string askSksEachCourse
    li $v0, 4
    la $a0, askSksEachCourse
    syscall
    
    # loads syscall 1 to print integer current course num
    li $v0, 1
    add $a0, $t2, $zero
    syscall
    
    # loads syscall 4 to print string colonChar
    li $v0, 4
    la $a0, colonChar
    syscall
    
    # loads syscall 5 to read integer input (sks for course num $t2)
    li $v0, 5
    syscall
    add $t3, $t3, $v0 # store inputted sks to $t3
    
    # add 1 to $t2 to progress in iteration
    addi $t2, $t2, 1
    
    # check if current iteration is still lower or equal to num of courses taken
    ble $t2, $t1, loopCourses

greet:
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
    
    # loads syscall 1 to print integer num of courses taken
    li $v0, 1
    add $a0, $t1, $zero # loads num of courses taken at $t1 to $a0
    syscall
    
    # loads syscall 4 to print greetMsg3
    li $v0, 4
    la $a0, greetMsg3
    syscall
    
    # loads syscall 1 to print integer total sks
    li $v0, 1
    add $a0, $t3, $zero # loads total sks at $t3 to $a0
    syscall
    
    # loads syscall 4 to print greetMsg4
    li $v0, 4
    la $a0, greetMsg4
    syscall
    
    # loads syscall 10 to exit the program
    li $v0, 10
    syscall