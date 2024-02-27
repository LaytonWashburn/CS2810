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
	errorMessage:
		.asciiz "Please Input a Non-negative Number"
		

.text

setUp:
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
	
 
	# Set user input to $t1
	move $t1, $v0
	
	# Check if it's non-negative
	blt $t1, 0, negative_end
		j fib
	negative_end:
		j setUp
	
	# Loop through the number of iterations
	fib:
		beq $t0, $t1, exit # If number of iterations == size of user input, then exit loop
		
			# Base Case i = 0
			beq  $t0, $t2, base_zero
			# Base Case i = 1
			beq  $t0, $t3, base_one
			
			# Body of the Fibonacci	
			
				# Handle values
				add $t6, $t5, $zero # Store old value of $t5 in temp register
				add $t5, $t5, $t4 # Calculate current fibonacci value 
				move $t4, $t6 # Store new value of $t4
				
				# Print out current value of $t5
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
		# Print value of 0
		li $v0, 1
		la $a0, ($t4)
		syscall
				
		# Print newline
		li $v0, 4
		la $a0, newline
		syscall 
		add $t0, $t0, 1
		j fib
		
	# Base Case for 1
	base_one:
		# Print value of 1
		li $v0, 1
		la $a0, ($t5)
		syscall
				
		# Print newline
		li $v0, 4
		la $a0, newline
		syscall 
		add $t0, $t0, 1
		j fib
	
	# Terminate the program
	exit:
		li $v0, 10 # Syscode for program termination
		syscall 