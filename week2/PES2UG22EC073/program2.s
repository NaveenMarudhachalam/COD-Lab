.data
y: .word 10       # Example value for y
m: .word 5        # Example value for m
L: .word 20       # Example value for L
D: .word 3        # Example value for D
Z: .word 15       # Example value for Z
C: .word 2        # Example value for C
x: .word 0        # Storage for the result x

.text
.globl main
main:
    # Load values from memory into registers
    lw x1, y           # Load y into x1
    lw x2, m           # Load m into x2
    lw x3, L           # Load L into x3
    lw x4, D           # Load D into x4
    lw x5, Z           # Load Z into x5
    lw x6, C           # Load C into x6
    la x20,x
    lw x12,0(x12)
    # Calculate (y + m)
    add x7, x1, x2     # x7 = y + m

    # Calculate (L - D)
    sub x8, x3, x4     # x8 = L - D

    # Calculate (y + m) - (L - D)
    sub x9, x7, x8     # x9 = (y + m) - (L - D)

    # Calculate (Z + C)
    add x10, x5, x6    # x10 = Z + C

    # Calculate (y + m) - (L - D) + (Z + C)
    add x11, x9, x10   # x11 = ((y + m) - (L - D)) + (Z + C)

    # Calculate (y + m) - (L - D) + (Z + C) - D
    sub x12, x11, x4   # x12 = (((y + m) - (L - D)) + (Z + C)) - D

    # Store the result in memory
    sw x12, 0(x20)          # Store the result x in memory

    # Exit program (if required for the environment)
    li a7, 10          # Load exit syscall number
    ecall              # Make the syscall to exit
