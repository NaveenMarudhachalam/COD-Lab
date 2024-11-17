.data
number_iter: .word 5                 # Example number for factorial calculation (you can change this)
result_iter: .word 0                  # Storage for the result

.text
.globl main_iter
main_iter:
    lw x10, number_iter               # Load the input number into x10
    li x11, 1                         # Initialize result (factorial) to 1
    beq x10, zero, store_result_iter  # If number is 0, skip to storing result

factorial_iter:
    mul x11, x11, x10                 # result *= n
    addi x10, x10, -1                 # n -= 1
    bgtz x10, factorial_iter          # Repeat until n > 0

store_result_iter:
    la x12, result_iter               # Load address of result_iter
    sw x11, 0(x12)                    # Store the result in memory

    # Exit program
    li a7, 10                         # Syscall for exit
    ecall