import copy

def main():
    # Defining the assembly file to read from
    filename = "task4-1.asm"

    # Read all lines from the assembly file, and store them in a list
    with open(filename, "r") as infile:
        lines = infile.readlines()

    # Step 1: Preprocess the lines to remove comments and whitespace
    lines = preprocess_lines(lines)
    
    # Step 2: Use the preprocessed program to build data table
    data_table, data_list, lines = build_data_table(lines)
    print(f'Data Table: {data_table}')
    print(f'Data List: {data_list}')

    # Step 3: Build a label table and strip out the labels from the code
    label_table, lines = create_label_table(lines)
    print(f'Label Table: {label_table}')

    # Step 4: Encode the program into a list of binary strings
    encoded_program = encode_program(lines, label_table, data_table)
    print(f'Endcoded Program: {encoded_program}')
    print(f'The program is: {lines}')

    # Step 5: Convert the strings to hexadecimal and write them to a file
    # hex_program = post_process(encoded_program)
    # with open("output.hex", "w") as outfile:
    #     outfile.write("v3.0 hex words addressed\n00: ")
    #     outfile.writelines(hex_program)

    # Step 6: Convert the data list to hexadecimal and write it to a file
    # with open("data.hex", "w") as outfile:
    #     outfile.write("v3.0 hex words addressed\n00: ")
    #     outfile.writelines([f"{d:04x} " for d in data_list])


# Processes the lines of code
def preprocess_lines(lines:str):

    instructions = [] # List of Instructions

    # Remove comments from the code
    # Strip out any remaining whitespace from both the start and end of each line
    # Remove any lines containing only blank space
    # Return the preprocessed list of instructions. At this point, the list should only contain one string per instruction
    for line in lines:
        line = line.split('#')[0]
        line = line.strip()
        if(not line == ''):
            instructions.append(line)
    return instructions


def build_data_table(lines:list):
    data_table = {}
    data_list = []
    program = copy.deepcopy(lines)

    section = '.other' # Section Variable

    i = 0 # Iteration variable

    for line in lines:
        
        if line == '.text': # Remove '.text' from the program
            section = '.text'
            program.remove(line)
            continue
        
        if line == '.data': # Remove '.text' from the program
            section = '.data'
            program.remove(line)
            continue

        if section != '.text' and section != '.other':  # Breaks the values into the variable and the value
            var, value = line.split(':')
            data_table[var] = i
            data_list.append(value)
            i = i + 1
            program.remove(line)

        if line.endswith(":"): # If a new tag, set the section variable to other
            section = '.other'
        
    return data_table, data_list, program

# Creates the label table
def create_label_table(lines:list):

    label_table = {} # Label Table
    program = []

    i = 0 # Iteration variable

    for line in lines: # Iterate through the lines
        if line.endswith(':'): # If it's a label
            label_table[line.replace(':', '')] = i # Remove the semicolon from the label
        if not line.endswith(':'): # If it's not a label, iterate the line iterator
            program.append(line) # Take things that are not labels
            i = i + 1

    return label_table, program

# Encodes the program
def encode_program(lines:list, label_table:list, data_table:dict):
    print(f'This is the program coming in: {lines}')
    binary_encoded_instructions = [] # Empty instruction list

    line_num = 0 # Create line number iterator
    for line in lines: # Loop through the program lines
        instruction = encode_instruction(line_num, line, label_table, data_table) # Encode the instructions into binary
        line_num += 1 # Increment the number
        binary_encoded_instructions.append(instruction)
   
    return binary_encoded_instructions # Return list of encoded instruction


def encode_instruction(line_num:int, instruction:str, label_table:list, data_table:list):
    instructions_split = instruction.split(" ")
    instruction = instructions_split[0]

    if instruction == 'add':
        pass
    elif instruction == 'sub':
        pass
    elif instruction == 'and':
        pass
    elif instruction  == 'or':
        pass
    elif instruction == 'slt':
        pass
    elif instruction == 'addi':
        r2 = instructions_split[2].replace(',', '')
        r1 = instructions_split[1].replace(',', '')
        immediate = int(instructions_split[3])
        return '0101 ' + register_to_binary(r2) + ' ' + register_to_binary(r1) + ' ' + dec_to_bin(immediate, 6)
    elif instruction == 'beq':
        r2 = instructions_split[2].replace(',', '')
        r1 = instructions_split[1].replace(',', '')
        immediate = instructions_split[3]
        return '0011 ' + register_to_binary(r2) + ' ' + register_to_binary(r1) + ' ' + dec_to_bin(line_num, 6)
    elif instruction == 'bne':
        pass
    elif instruction == 'lw':
        pass
    elif instruction == 'sw':
        pass
    elif instruction == 'j':
        label = instructions_split[1]
        return'0100 ' + dec_to_bin(label_table[label], 12)
    elif instruction == 'jr':
        pass
    elif instruction == 'jal':
        pass
    else:
        return "Hello World"

   



def register_to_binary(reg:str):
    num = reg.replace('R', '')
    return bin(int(num))[2:].zfill(3)



def dec_to_bin(num:int, extended):
    if num < 0:
        res = f"{(1 << extended) + num:0{extended}b}"
        res = res.zfill(extended)
    else:
        res = bin(num)[2:].zfill(extended)

    return res


main()
