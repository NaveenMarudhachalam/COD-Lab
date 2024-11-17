.data
number: .word 12321               # Example number to check (you can change this)
result: .word 0                   # Storage for palindrome result (1 for palindrome, 0 for not)

.text
.globl main
main:
    lw x10, number                 # Load the number into x10
    li x11, 0                       # Initialize reversed number to 0
    li x12, 0                       # Initialize original number for comparison
    li x13, 10                      # Set divisor for digit extraction

# Save the original number
    mv x12, x10                    # Store original number in x12

reverse_loop:
    beq x10, zero, compare         # If x10 is 0, we are done reversing
    rem x14, x10, x13              # Get the last digit (x10 % 10)
    add x11, x11, x14              # Add the digit to the reversed number
    mul x11, x11, x13              # Shift left (multiply by 10)
    div x10, x10, x13              # Remove the last digit (x10 / 10)
    j reverse_loop                  # Repeat the loop

compare:
    # At this point, x11 contains the reversed number and x12 contains the original number
    beq x11, x12, is_palindrome     # If reversed number equals original, it's a palindrome
    li x14, 0                        # Not a palindrome
    j store_result                   # Jump to store result

is_palindrome:
    li x14, 1                        # It is a palindrome

store_result:
    la x21, result                  # Load address of the result variable
    sw x14, 0(x21)                  # Store result (1 or 0) in memory

exit:
    li a7, 10                        # Syscall for exit
    ecall