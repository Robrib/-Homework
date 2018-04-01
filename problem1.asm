	.data

# char array for uppercase letter to string
u_word:       .asciiz 
	      "Alpha ","Bravo ","China ","Delta ","Echo ","Foxtrot ", "Golf ","Hotel ","India ",
	      "Juliet ","Kilo ","Lima ","Mary ","November ","Oscar ","Paper ","Quebec ",
	      "Research ", "Sierra ","Tango ","Uniform ","Victor ","Whisky ","X-ray ","Yankee ","Zulu "
	
# int array for uppercase letter's offset
u_offset:     .word
              0,7,14,21,28,34,43,49,56,63,71,77,83,89,99,
              106,113,121,131,139,146,155,163,171,178,186 
              
# char array for lowercase letter to string
l_word:       .asciiz 
              "alpha ","bravo ","china ","delta ","echo ","foxtrot ","golf ","hotel ","india ",
              "juliet ","kilo ","lima ","mary ","november ","oscar ","paper ","quebec ",
              "research ","sierra ","tango ","uniform ","victor ","whisky ","x-ray ","yankee ","zulu " 
              
# int array for lowercase letter's offset
l_offset:     .word
              0,7,14,21,28,34,43,49,56,63,71,77,83,89,99,
              106,113,121,131,139,146,155,163,171,178,186 	       

# char array for number to string
number:       .asciiz 
	      "zero ", "First ", "Second ", "Third ", "Fourth ",
	      "Fifth ", "Sixth ", "Seventh ","Eighth ","Ninth "  
	      
# int array for number's offset  
n_offset:     .word
              0,6,13,21,28,36,43,50,59,67 

endMessege:   .asciiz "\nExit the program.\n" 

newLine:      .ascii "\n"



                      
	.text
        .globl main
main:

	# read a character
	li $v0, 12
	syscall
	
	add $a1, $v0, $zero
		
	# is '?'?
	beq $a1, 63, exit
	
	# is number?
	sgt $t1, $a1, 47
	slti $t2, $a1, 58
	and $s1, $t1, $t2
	beq $s1, 1, get_num
	
	# is uppercase letter?
	sgt $t1, $a1, 64
	slti $t2, $a1, 91
	and $s1, $t1, $t2
	beq $s1, 1, get_up
	
	# is lowercase letter?
	sgt $t1, $a1, 96
	slti $t2, $a1, 123
	and $s1, $t1, $t2
	beq $s1, 1, get_low
	
	j others
	
get_num:
	# a new line
	li $v0, 4
	la $a0, newLine
	syscall
	
	sub $t1, $a1, 48
	sll $t1, $t1, 2
	la $s0, n_offset
	add $s0, $s0, $t1
	lw $s1, ($s0)
	la $a0, number
	add $a0, $a0, $s1
	li $v0, 4
	syscall
	
	# a new line
	li $v0, 4
	la $a0, newLine
	syscall
	j main 
	
get_up:
	li $v0, 4
	la $a0, newLine
	syscall
	sub $t1, $a1, 65
	sll $t1, $t1, 2
	la $s0, u_offset
	add $s0, $s0, $t1
	lw $s1, ($s0)
	la $a0, u_word
	add $a0, $a0, $s1
	li $v0, 4
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	j main 
	
	
get_low:
	# a new line
	li $v0, 4
	la $a0, newLine
	syscall
	
	sub $t1, $a1, 97
	sll $t1, $t1, 2
	la $s0, l_offset
	add $s0, $s0, $t1
	lw $s1, ($s0)
	la $a0, l_word
	add $a0, $a0, $s1
	li $v0, 4
	syscall
	
	# a new line
	li $v0, 4
	la $a0, newLine
	syscall
	j main 

others:
	# a new line
	li $v0, 4
	la $a0, newLine
	syscall
	
	# output '*'
	add $a0, $zero, 42
	li, $v0 11
	syscall
	
	# a new line
	li $v0, 4
	la $a0, newLine
	syscall
	j main
	
exit:
	li $v0, 4
	la $a0, endMessege
	syscall
	
	li $v0, 10
	syscall
	
          
