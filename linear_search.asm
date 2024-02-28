# Software Development Plan
# 
#
# Define array with 10 integers
##	-- name: array
# Define the length of the array
##	-- name: size
##	-- value: 10
# Define all prompts and messages 
##	-- "Enter the value you are looking for (-1 to quit): "
##	-- "The index of your element is: "
# Define location variable
##	-- name: index
##	-- original value: -1
# 
# User Input
##	main loop: Break condition: if the user input is not -1
##		Ask them what value they would like to search for in the list
##		Allocate a temporary register to hold the user input
##			-- $t0
##		Check if the user input is -1
##			-- exit if -1
##		
##
##		Allocate register $t1 for an iteration variable
##			-- Load 0 $t1
##
##		Inner Loop: Break condition: results: if iteration counter is equal to the size of te array
##			Traverse the array looking for the user input
##				-- This done using the size of the array: denoted size
##				-- If eqaul: break to found_item
##
##		results:
##			-- Load 1 into the value register
##			-- Load the inde of the matched/unmatched number into the argument register
##				-- register: $a0
##			-- syscall
##

.data
	array:
		.word 5, 10, 15, 20, 25, 30, 35, 40, 45, 50
	size:
		.word 10
	negative_one:
		.word -1
	prompt:
		.asciiz "Enter the value you are looking for (-1 to quit): "
	result_message:
		.asciiz "The index of your element is: "
	newline:
		.asciiz "\n"

.text
	main: 
		# Set Up
		li $t0, -1 # terminating value
		lw $t1, size # Size of the array
		li $t2, 0 # i = 0 --iteration variable
		
		# Print the prompt message
		li $v0, 4
		la $a0, prompt
		syscall 
		
		# Read in the user input
		li $v0, 5 
		syscall
		
		# Check for newline and empty string input
		beq $t3, '\n', main
		
		# Move user input to a register input
		move $t3, $v0
		
		# If the user input is not -1
		beq $t3, $t0, exit
		
		# Load array address into $t6
		la $t6, array
		lw $t4, ($t6) # $t4 = array[i]
		
		linear_search:
			# Check if the the iteration variable is equal to the size of the array
			beq $t1, $t2, result
			
			# Check if the current array value is equal to the user input
			bne $t3, $t4, increment
			
			# Move the matched input to the terminal register
			move $t0, $t2
			
			 # Jump to result  
			j result
		
		increment:
			lw $t4, 4($t6) # array[i] = array[i+1]
			la $t6, 4($t6) # Increment the address by 4
				
			# Add one to the iteration variable
			add $t2, $t2, 1
			j linear_search
		
		# When the inner loop terminates, i.e. iteration variable is the same as the size
		result:
			# Print the result message
			li $v0, 4
			la $a0, result_message
			syscall
			
			# Print the result
			li $v0, 1
			la $a0, ($t0)
			syscall
			
			# Print newline for formatting
			li $v0, 4
			la $a0, newline
			syscall
			
			# Print newline for formatting
			li $v0, 4
			la $a0, newline
			syscall
			
			j main # Jump back up to the main loop
		
		# Terminate the program
		exit:	
			li $v0, 10 # Syscode for program termination
			syscall 
		
		
		
		
		
		
		
		
		
		
		
