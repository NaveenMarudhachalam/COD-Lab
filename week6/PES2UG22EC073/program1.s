    .data
array:  .word 10, 5, 8, 20, 3, 15    # Example array
n:      .word 6                      # Number of elements in array

    .text

    la t0, array     # Load address of array in t0
    la t1, n         # Load address of n in t1
    lw t1, 0(t1)     # Load the number of elements in t1 (size of array)

bubble_sort:
    addi t2, t1, -1    # Outer loop counter i = n-1

outer_loop:
    addi t3, zero, 0   # Inner loop counter j = 0
    addi t4, t2, 0     # t4 = i

inner_loop:
    slli t5, t3, 2     # t5 = j * 4 (since each word is 4 bytes)
    add t6, t0, t5     # t6 points to array[j]

    lw x20, 0(t6)      # Load array[j]
    lw x21, 4(t6)       # Load array[j+1]

    ble x20, x21, skip   # If array[j] <= array[j+1], skip the swap

    # Swap array[j] and array[j+1]
    sw x21, 0(t6)       # array[j] = array[j+1]
    sw x20, 4(t6)       # array[j+1] = array[j]

skip:
    addi t3, t3, 1     # j++
    bne t3, t4, inner_loop   # If j != i, repeat inner loop

    addi t2, t2, -1    # i--
    bnez t2, outer_loop   # If i > 0, repeat outer loop


