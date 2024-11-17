        .data
a:      .half 0x1234, 0x5678, 0x9abc, 0xdef0, 0x1357, 0x2468, 0x369a, 0x47bc, 0x58de, 0x6af0, 0x7b12
b:      .half 0x1234, 0x5678, 0x9abc, 0xdef0, 0x1357, 0x2468, 0x369a, 0x47bc, 0x58de, 0x6af0, 0x7b12
c:      .half 0x1234, 0x5678, 0x9abc, 0xdef0, 0x1357, 0x2468, 0x369a, 0x47bc, 0x58de, 0x6af0, 0x7b12

        .text
        .globl _start

_start:
        li      t0, 0                  # Initialize i = 0 (index counter)
        la      t1, a                  # Load address of array a into t1
        la      t2, b                  # Load address of array b into t2
        la      t3, c                  # Load address of array c into t3
        li      x12,10
loop:
        bge     t0, x12, end_loop       # If i >= 10, end loop

        lh      t4, 0(t1)              # Load a[i] (16-bit) into t4
        lh      t5, 0(t2)              # Load b[i] (16-bit) into t5
        mul     t6, t4, t5             # Multiply a[i] * b[i], store in t6

        beq     t0, zero, first_iter   # If i == 0, skip c[i-1] addition

        lh      x10, -2(t3)             # Load c[i-1] (previous value) into t7
        add     t6, t6, x10             # c[i] = a[i] * b[i] + c[i-1]

first_iter:
        sh      x9, 0(t3)              # Store result in c[i]

        addi    t0, t0, 1              # i++
        addi    t1, t1, 2              # Move to the next element in a
        addi    t2, t2, 2              # Move to the next element in b
        addi    t3, t3, 2              # Move to the next element in c
        j       loop                   # Repeat loop

end_loop: nop
        # Program ends here.
        # The result is stored in array c.
