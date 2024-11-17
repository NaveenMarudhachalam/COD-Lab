.data
array:      .word 10, 20, 30, 40, 50  # Example array
N:          .word 5                   # Number of elements in the array
target:     .word 30                  # Number to search for
result:     .word -1                  # Storage for the result (index or -1 if not found)

.text
.globl main
main:
    # Load the number of elements in the array
    lw x5, N                         # Load N into x5
    la x6, array                     # Load address of the array into x6
    lw x7, target                    # Load the target number into x7
    li x8, 0                         # Initialize index to 0

search_loop:
    bge x8, x5, not_found            # If index >= N, jump to not_found

    lw x9, 0(x6)                     # Load current element from array
    beq x9, x7, found                # If element == target, jump to found

    addi x6, x6, 4                   # Move to the next element (4 bytes)
    addi x8, x8, 1                   # Increment index
    j search_loop                    # Repeat loop

found:
    la x10, result                   # Load address of result
    sw x8, 0(x10)                    # Store the index of the found element
    j end_program                    # Jump to end

not_found:
    li x8, -1                        # Set index to -1 (not found)
    la x10, result                   # Load address of result
    sw x8, 0(x10)                    # Store -1 in result

end_program:
    # Exit program
    li a7, 10                        # Load syscall for exit
    ecall