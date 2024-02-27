# Software Developer Plan

# Create a variable to hold a new string

# Print the string "Please enter a number: "
# Read and store the user input
## 	Store the result of the user input in a register

# Store the last two results in two registers
# Create the function that will be called recursively 
# Store result of adding the two previous results in the a new register
# Load the result into an argument register
# Print out the result

# Create a function named fibonacci
## 	Base Cases
### 		i = 0 
###		i = 1
##	add the previous two registers into a third temporary register


# Exit the program by loading 10 into
## 	Load immediately 10 into a system call register


.data

	# Set the iteration message
	inputMessage:
		.asciiz "Please enter a number: "
		
	# Newline character for formatting
	newline:
		.asciiz "\n"
		
	# Newline character for formatting
	test:
		.asciiz "Hits the base case"
		

.text
	# Set iteration variable to 0
	li $t0, 0
	li $t2, 0 # Base case i = 0
	li $t3, 1 # Base case i = 1
	li $t4, 0 # Fibonacci prev
	li $t5, 1 # Fibonacci curr
	li $t6, 1 # Fibonacci temp
	
	# Print the input message
	li $v0, 4
	la $a0, inputMessage
	syscall 

	# Read in the user input
	li $v0, 5 
	syscall 
	
	# Check if it's non-negative
	
	# Set user input to $t1
	move $t1, $v0
	
	# Loop through the number of iterations
	fib:
		beq $t0, $t1, exit # If number of iterations == size of user input, then exit loop
		
			# Base Case i = 0
			beq  $t0, $t2, base_zero
			# Base Case i = 1
			beq  $t0, $t3, base_one
			
			# Body of the Fibonacci	
				add $t6, $t5, $zero
				add $t5, $t5, $t4
				move $t4, $t6
				li $v0, 1 
				la $a0, ($t5)
				syscall
		
				# Print newline for formatting
				li $v0, 4
				la $a0, newline
				syscall 
		
				# Iterate the counter by one
				add $t0, $t0, 1
		
				# Jump to the top of fibonacci
				j fib

	# Base Case for 0
	base_zero:
		li $v0, 1
		la $a0, ($t4)
		syscall
				
		li $v0, 4
		la $a0, newline
		syscall 
		add $t0, $t0, 1
		j fib
		
	# Base Case for 1
	base_one:
		
		li $v0, 1
		la $a0, ($t5)
		syscall
				
		li $v0, 4
		la $a0, newline
		syscall 
		add $t0, $t0, 1
		j fib
	
	# Terminate the program
	exit:
		li $v0, 10 # Syscode for program termination
		syscall 
	
	
