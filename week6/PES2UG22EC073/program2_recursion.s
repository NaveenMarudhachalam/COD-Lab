.data
number: .word 5                     # Example number for factorial calculation (you can change this)
result: .word 0                      # Storage for the result

.text
.globl main
main:
    lw x10, number                   # Load the input number into x10
    jal ra, factorial                 # Call the recursive factorial function
    la x11, result                   # Load address of result
    sw x10, 0(x11)                   # Store the result in memory

    # Exit program
    li a7, 10                         # Syscall for exit
    ecall

# Recursive function to calculate factorial
factorial:
    addi sp, sp, -8                   # Create space on stack for return address and saved register
    sw ra, 4(sp)                      # Save return address
    sw x10, 0(sp)                     # Save the original value of n

    # Base case: if n == 0, return 1
    li x11, 1                         # Load 1 into x11 for comparison
    beq x10, zero, base_case          # If n == 0, jump to base_case

    addi x10, x10, -1                 # n = n - 1
    jal ra, factorial                  # Recursive call: factorial(n - 1)

    lw x12, 0(sp)                     # Load original n from stack
    mul x10, x10, x12                 # n * factorial(n - 1)

    j end_factorial                   # Jump to end

base_case:
    mv x10, x11                       # Return 1 for factorial(0)

end_factorial:
    lw ra, 4(sp)                      # Restore return address
    lw x12, 0(sp)                     # Restore original n if needed (not strictly necessary)
    addi sp, sp, 8                    # Restore stack (remove saved register and return address)
    jalr x0,ra, 0                        # Return to caller