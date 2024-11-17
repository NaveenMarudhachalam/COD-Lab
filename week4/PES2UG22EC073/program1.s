.data
numbers: .word 1221, 12321, 1234, 44544  # Array of numbers to check
N:       .word 4                         # Number of elements in the array
results: .word 0,0,0,0                       # Space for results (4 bytes for each number)

.text
.globl _start

_start:
    la t0, numbers          # Load address of numbers into t0
    lw t1, N                # Load number of elements into t1
    la t2, results          # Load address of results into t2
    li t3, 0                # Initialize index to 0
    li x20,10
check_loop:
    bge t3, t1, end         # If index >= N, end
    lw t4, 0(t0)            # Load the current number into t4
    jal ra, is_palindrome   # Call is_palindrome subroutine
    sw a0, 0(t2)            # Store result in results array
    addi t0, t0, 4          # Move to the next number (4 bytes)
    addi t2, t2, 4          # Move to the next result space
    addi t3, t3, 1          # Increment index
    j check_loop            # Repeat for the next number

# Subroutine: is_palindrome
is_palindrome:
    mv t5, t4               # Copy the number into t5 for manipulation
    li a0, 1                # Assume it is a palindrome (default result)

    # Push digits onto the stack
    mv t6, sp               # Save the current stack pointer
push_digits:
    rem x21, t5, x20          # Get the last digit
    addi sp, sp, -4         # Adjust stack pointer for push
    sw x21, 0(sp)            # Push the digit onto the stack
    div t5, t5, x20          # Remove the last digit
    bnez t5, push_digits    # Repeat until all digits are pushed

    mv t5, t4               # Restore the original number to t5

# Compare digits using the stack
compare_digits:
    lw x21, 0(sp)            # Pop the top digit from the stack
    addi sp, sp, 4          # Adjust stack pointer for pop
    rem x22, t5, x20          # Get the last digit of the number
    div t5, t5, x20          # Remove the last digit
    bne x21, x22, not_palindrome # If digits don’t match, not a palindrome
    bnez t5, compare_digits # Continue if there are more digits to compare

    # If all digits matched, it’s a palindrome
    j end_palindrome

not_palindrome:
    li a0, 0                # Set result to 0 (not a palindrome)

end_palindrome:
    mv sp, t6               # Restore the stack pointer
    jalr x0, ra, 0          # Return to the caller

end:
    # Exit program
    li a7, 10               # Syscall for exit
    ecall
