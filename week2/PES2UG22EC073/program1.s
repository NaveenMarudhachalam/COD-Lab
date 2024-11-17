.data
# Number of elements to add
N_words:     .word 5                     # Number of words to add
N_half:      .word 5                     # Number of half-words to add
N_bytes:     .word 5                     # Number of bytes to add

# Values for addition
values_words: .word 1, 2, 3, 4, 5         # Example values for words
values_half:  .half 1, 2, 3, 4, 5         # Example values for half-words
values_bytes: .byte 1, 2, 3, 4, 5          # Example values for bytes

# Storage for results
result_words: .word 0                     # Storage for the result of words addition
result_half:  .word 0                     # Storage for the result of half-words addition
result_bytes: .word 0                     # Storage for the result of bytes addition

.text
.globl main
main:
    # Addition of N Words
    lw x5, N_words                     # Load the number of words into x5
    la x6, values_words                # Load address of values array into x6
    li x7, 0                           # Initialize sum to 0
    li x8, 0                           # Initialize index to 0

loop_add_words:
    bge x8, x5, store_result_words      # If index >= N, finish addition
    lw x9, 0(x6)                       # Load word from values
    add x7, x7, x9                      # Add to the sum
    addi x6, x6, 4                      # Move to the next word (4 bytes)
    addi x8, x8, 1                      # Increment index
    j loop_add_words                    # Repeat loop

store_result_words:
    la x10, result_words                # Load address of result_words
    sw x7, 0(x10)                       # Store the result in memory

    # Addition of N Half-Words
    lw x5, N_half                      # Load the number of half-words into x5
    la x6, values_half                 # Load address of half-values array into x6
    li x7, 0                           # Initialize sum to 0
    li x8, 0                           # Initialize index to 0

loop_add_half:
    bge x8, x5, store_result_half       # If index >= N, finish addition
    lh x9, 0(x6)                       # Load half-word from values
    add x7, x7, x9                      # Add to the sum
    addi x6, x6, 2                      # Move to the next half-word (2 bytes)
    addi x8, x8, 1                      # Increment index
    j loop_add_half                     # Repeat loop

store_result_half:
    la x10, result_half                 # Load address of result_half
    sw x7, 0(x10)                       # Store the result in memory

    # Addition of N Bytes
    lw x5, N_bytes                      # Load the number of bytes into x5
    la x6, values_bytes                 # Load address of byte values array into x6
    li x7, 0                           # Initialize sum to 0
    li x8, 0                           # Initialize index to 0

loop_add_bytes:
    bge x8, x5, store_result_bytes       # If index >= N, finish addition
    lb x9, 0(x6)                       # Load byte from values
    add x7, x7, x9                      # Add to the sum
    addi x6, x6, 1                      # Move to the next byte (1 byte)
    addi x8, x8, 1                      # Increment index
    j loop_add_bytes                    # Repeat loop

store_result_bytes:
    la x10, result_bytes                # Load address of result_bytes
    sw x7, 0(x10)                       # Store the result in memory

    # Exit program
    li a7, 10                           # Load syscall for exit
    ecall