import copy

def main():
    # Defining the assembly file to read from
    filename = "task2-3.asm"

    # Read all lines from the assembly file, and store them in a list
    with open(filename, "r") as infile:
        lines = infile.readlines()

    # Step 1: Preprocess the lines to remove comments and whitespace
    lines = preprocess_lines(lines)
    

    # Step 2: Use the preprocessed program to build data table
    data_table, data_list, lines = build_data_table(lines)

    print(data_table)
    print(data_list)
    print(lines)

    # Step 3: Build a label table and strip out the labels from the code
    # label_table, lines = create_label_table(lines)

    # Step 4: Encode the program into a list of binary strings
    # encoded_program = encode_program(lines, label_table, data_table)

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
    # List of Instructions
    instructions = []

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

    # Section Variable
    section = '.other'

    # Iteration variable
    i = 0

    for line in lines:
        
        # Remove '.text' from the program
        if line == '.text':
            section = '.text'
            program.remove(line)
            continue
        
        # Remove '.text' from the program
        if line == '.data':
            section = '.data'
            program.remove(line)
            continue

        # # Breaks the values into the variable and the value
        if section != '.text' and section != '.other':
            var, value = line.split(':')
            data_table[var] = i
            data_list.append(value)
            i = i + 1
            program.remove(line)

        # If a new tag, set the section variable to other            
        if line.endswith(":"):
            section = '.other'
        
    return data_table, data_list, program

main()