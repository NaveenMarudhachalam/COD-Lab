.data
N:      .word 2              # Size of the matrix (2x2)
A:      .word 1, 2          # Matrix A
         .word 3, 4
B:      .word 5, 6          # Matrix B
         .word 7, 8
C:      .word 0,0            # Result matrix C (2x2)
        .word 0,0
        
.text
.globl _start

_start:
        la      x10, A               # Load base address of A into x10
        la      x11, B               # Load base address of B into x11
        la      x12, C               # Load base address of C into x12
        lw      x13, N                # Load N (matrix size) into x13

        li      x14, 0                # Row index for C (i = 0)
row_loop:
        bge     x14, x13, end         # If i >= N, exit

        li      x15, 0                 # Column index for C (j = 0)
column_loop:
        bge     x15, x13, next_row     # If j >= N, go to the next row

        li      x16, 0                 # Initialize sum for C[i][j] (sum = 0)
        li      x17, 0                 # k = 0 (index for multiplication)
mul_loop:
        bge     x17, x13, store_c      # If k >= N, store the result in C

        # Load A[i][k]
        mul     x18, x14, x13           # x18 = i * N (row offset for A)
        add     x18, x18, x17            # x18 = i * N + k
        slli    x18, x18, 2              # x18 = (i * N + k) * 4 (byte offset)
        add     x18, x10,x18
        lw      x19, 0(x18)        # Load A[i][k] into x19

        # Load B[k][j]
        mul     x20, x17, x13           # x20 = k * N (row offset for B)
        add     x20, x20, x15            # x20 = k * N + j
        slli    x20, x20, 2              # x20 = (k * N + j) * 4 (byte offset)
        add     x20, x11,x20
        lw      x21, 0( x20)        # Load B[k][j] into x21

        # Multiply and add to sum
        mul     x22, x19, x21            # x22 = A[i][k] * B[k][j]
        add     x16, x16, x22            # sum += x22

        addi    x17, x17, 1              # k++
        j       mul_loop                 # Repeat for next k

store_c:
        # Store C[i][j] = sum
        mul     x18, x14, x13            # x18 = i * N
        add     x18, x18, x15            # x18 = i * N + j
        slli    x18, x18, 2               # x18 = (i * N + j) * 4 (byte offset)
        add     x18, x12,x18
        sw      x16, 0(x18)         # Store sum in C[i][j]

        addi    x15, x15, 1              # j++
        j       column_loop               # Repeat for next column

next_row:
        addi    x14, x14, 1              # i++
        j       row_loop                 # Repeat for next row

end:
        nop                              # End of program