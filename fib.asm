# Assignment Non Leaf Fibonacci
# Task 1
## print_arry function
### Loop through the array 
### Print each element
### Print a space
### Print a newline at the very end
#### Use $a0 for the base address of the array
#### Use $a1 for the size of the array
# Task 2
# Task 3
# Task 4


.data
	array1: .word 10, 2, 4, 3, 6,100, 51, 9
	size1: .word 8
	
	array2: .word 2, 5, 3, 11, 23, 27, 101, 23, 34, 100212, 57
	size2: .word 11
	
	space: .asciiz " "
	newline: .asciiz "\n"
	
	test: .asciiz "Hello World"
	
	
.text

main:
	li $t0, 0 #  i = 0 for iteration counter
	
	la $a1, array1
	lw $a2, size1
	jal print_array
	

	
	la $a1, array2
	lw $a2, size2
	jal print_array
	
	j exit
	
	# Loop through the array and print each element separated by a space and a newline at the end
	print_array: 
	
		beq $a2, $t0, end_print_array # If the size of the array is equal to the iterator, jump to end_print_array label
		
		lw $t2, ($a1)
		
		li, $v0, 1
		la $a0, ($t2)
		syscall
		
		li, $v0, 4
		la $a0, space
		syscall
		
		# Increment the address
		la $a1, 4($a1)
		
		add, $t0, $t0, 1 # i++
		
		j print_array
		
	# After the function has finished printing out the array, print a newline and jump back to the return address
	end_print_array:	
	
		li, $t0, 0 # Reset increment 
	
		# Print a newline
		li $v0, 4
		la $a0, newline
		syscall
		
		# Jump back to the return address
		jr $ra

	exit:
		li $v0, 10		# Syscode for program termination
		syscall
		
		
		
		
		
		
		
		
		
		
		
		
		
		