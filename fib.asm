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
	# 4 arrays and sizes for testing
	array1: .word 10, 2, 4, 3, 6,100, 51, 9
	size1: .word 8
	
	array2: .word 2, 5, 3, 11, 23, 27, 101, 23, 34, 100212, 57
	size2: .word 11
	
	array3: .word 1
	size3: .word 1
	
	array4: .word 10, 14, 223, 2403, 22, 24, 54, 101, 103
	size4: .word 9
	
	# Prompt for users
	prompt: .asciiz "'Please enter how many fibonacci numbers you would like: "
	
	# Formatting
	space: .asciiz " "
	newline: .asciiz "\n"
	
	# Testing
	test: .asciiz "Hello World"
	
	# Make empty array for 
	# This is in bytes
	.align 4
	arrayN: .space 32 # .align 4
	
	
.text

	# Print array 1
	##la $a0, array1
	##lw $a1, size1
	##jal print_array
	
	# Print array 2
	##la $a0, array2
	##lw $a1, size2
	##jal print_array
	
	# Print array 3
	##la $a0, array3
	##lw $a1, size3
	##jal print_array
	
	
	# Print array 4
	##la $a0, array4
	##lw $a1, size4
	##jal print_array
	
	#Print main function functionality
	jal main_func
	
	j exit
	
	# Loop through the array and print each element separated by a space and a newline at the end
	print_array: 
	
		li $t0, 0 #  i = 0 for iteration counter
		
		loop:
			beq $a1, $t0, end_print_array # If the size of the array is equal to the iterator, jump to end_print_array label
		
			# Load address into temp register
			la $t1, ($a0)
		
			# Print array[i]
			li, $v0, 1
			lw $a0, ($t1)
			syscall
		
			# Print Space
			li, $v0, 4
			la $a0, space
			syscall
		
			# Increment the address
			la $a0, 4($t1)
		
			add, $t0, $t0, 1 # i++
		
			j loop
		
	# After the function has finished printing out the array, print a newline and jump back to the return address
	end_print_array:	
	
		# Print a newline
		li $v0, 4
		la $a0, newline
		syscall
		
		# Jump back to the return address
		jr $ra
	
	main_func:
		
		# Print user prompt for integer
		li $v0, 4
		la $a0, prompt
		syscall
		
		# Get user integer
		li $v0, 5
		syscall
		
		# Move user input to a register input
		# User input is n, which denotes 'n' numbers
		move $s0, $v0 # $s0 is user input
		
		# $s1 is the incrementor
		li, $s1, 0 # Setting increment to 0
		
		# Load array address in
		la $s2, arrayN # Will be used to put the current iterator in
		la $s3, arrayN # Holding base array address

		
		main_loop:
		
			beq $s0, $s1, main_func_end # If iterator and size are the same
			
			sw $s1, 0($s2) # Store value at array[i]
			# Add one to the iteration variable
			add $s1, $s1, 1
			
			move $a1, $s1
			la $a0, ($s3)
			jal print_array
			

			
			addi $s2, $s2, 4
			
			j main_loop
			
		main_func_end:
			j exit

	# Terminate the program
	exit:
		li $v0, 10		
		syscall
		


		
		
		
		
		
		
		
		
		
		
		
		
