	.data
successMessege:      .asciiz "\nSuccess! Location: "
failMessege:         .asciiz "\nFail!"
inputStringMessege:  .asciiz "Please input a string: "
inputCharMessege:    .asciiz "\nPlease input a char: "
endMessege:          .asciiz "\nExit"
newLine:             .asciiz "\n"
string:              .space 100
 
	.text
	.globl main

main:
	li $v0, 4
	la $a0, inputStringMessege
	syscall
	
	la $a0, string
	li $a1, 100
	li $v0, 8
	syscall
	
inputchar:
	li $v0, 4
	la $a0, inputCharMessege
	syscall
	
	li $v0 12
	syscall
	beq $v0, 63, exit
	
	add $t1, $v0, $zero
	addi $t0, $zero, 1
	la  $s1, string
	
loop:
	lb $s0, ($s1)
	beq $s0, $t1, success
	beq $s0, 0, fail
	addi $s1, $s1, 1
	addi $t0, $t0, 1
	j loop

success:
	li $v0, 4
	la $a0, successMessege
	syscall
	
	li $v0, 1
	add $a0, $t0, $zero
	syscall
	
	j inputchar

fail:
	li $v0, 4
	la $a0, failMessege
	syscall
	j inputchar
exit:
	li $v0, 4
	la $a0, endMessege
	syscall
	
	li $v0, 10
	syscall
	
	
