.data
# Matrix A (2x3)
num1_low:  .word 0x00000001         # Lower 32 bits of the first 64-bit number
num1_high: .word 0x00000002         # Upper 32 bits of the first 64-bit number
num2_low:  .word 0x00000003         # Lower 32 bits of the second 64-bit number
num2_high: .word 0x00000004         # Upper 32 bits of the second 64-bit number
result_low: .word 0                  # Lower 32 bits of the result
result_high: .word 0                 # Upper 32 bits of the result

.text
.globl main
main:
    # Load addresses of the numbers and result
    la x5, num1_low                  # Load address of num1_low into x5
    la x6, num1_high                 # Load address of num1_high into x6
    la x7, num2_low                  # Load address of num2_low into x7
    la x8, num2_high                 # Load address of num2_high into x8
    la x9, result_low                # Load address of result_low into x9
    la x10, result_high              # Load address of result_high into x10

    # Load the lower parts of the numbers
    lw x11, 0(x5)                    # Load lower part of num1 into x11
    lw x12, 0(x7)                    # Load lower part of num2 into x12

    # Perform addition of lower parts
    add x13, x11, x12                # x13 = num1_low + num2_low
    sw x13, 0(x9)                    # Store the result low part

    # Load the upper parts of the numbers
    lw x14, 0(x6)                    # Load upper part of num1 into x14
    lw x15, 0(x8)                    # Load upper part of num2 into x15

    # Perform addition of upper parts
    add x16, x14, x15                # x16 = num1_high + num2_high

    # Check for carry from the lower addition
    blt x13, x11, carry              # If result_low < num1_low, there was a carry

    # No carry, store the result high part
    sw x16, 0(x10)                   # Store the result high part
    j end_program                    # Jump to end

carry:
    # If there was a carry, increment the upper part
    addi x16, x16, 1                 # Increment the upper part by 1
    sw x16, 0(x10)                   # Store the result high part

end_program:
    # Exit program
    li a7, 10                         # Load syscall for exit
    ecall