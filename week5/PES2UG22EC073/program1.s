    .data
array:      .word 18, 27, 34, 45, 56       # Array of numbers to check
array_size: .word 5                        # Number of elements in the array
results:    .word 0,0,0,0,0                   # Space to store results (1 or 0 for each element)

    .text
    .globl _start
_start:
    la x1, array           # Load address of array into x1
    lw x2, array_size      # Load size of array into x2
    la x3, results         # Load address of results array into x3
    li x4, 0               # Initialize index register to 0
    li x9,9
loop:
    beq x4, x2, end        # If index == array_size, exit the loop

    lw x5, 0(x1)           # Load current element of the array into x5
    rem x6, x5, x9          # Calculate x5 % 9, store result in x6

    beq x6, zero, is_divisible # If remainder is 0, number is divisible by 9

    # Number is not divisible by 9
    sw zero, 0(x3)         # Store 0 in results array
    j next

is_divisible:
    li x7, 1               # Load 1 to indicate divisibility
    sw x7, 0(x3)           # Store 1 in results array

next:
    addi x1, x1, 4         # Move to next element in array
    addi x3, x3, 4         # Move to next element in results array
    addi x4, x4, 1         # Increment index
    j loop                 # Repeat loop

end:nop
    # Program ends here. The results array now contains 1 for divisible by 9, 0 otherwise.
    # x3 points to the start of results array, which can be checked for output if necessary.
