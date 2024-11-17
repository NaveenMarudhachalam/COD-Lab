.data
a:  .byte 0b00010001, 0b00010001, 0b00001101  # Example input array
b:  .byte 0b0,0b0,0b0 # Result array, same size as 'a'

.text
    la x10, a       # Load address of array a into x10
    la x11, b       # Load address of result array b into x11
    addi x12,x0, 3       # Load the size of the array (3 elements in this case)

loop:
    beq x12, x0, end_loop  # Exit loop when all elements are processed

    lbu x5, 0(x10)         # Load byte from array 'a' into x5
    jal x1, check_2_out_of_5  # Call subroutine to check if it's 2 out of 5
    sb x20, 0(x11)         # Store result in array 'b'

    addi x10, x10, 1       # Increment array 'a' pointer
    addi x11, x11, 1       # Increment array 'b' pointer
    addi x12, x12, -1      # Decrease the loop counter
    jal x0, loop           # Jump back to loop



check_2_out_of_5:
    addi x25,x0,0
    andi x7,x5,0xE0
    bne x6,x0,exit
    addi x13,x0,5

back:
    andi x6,x5,0x01
    beq x6,x0,next
    addi x25,x25,01
next:
    srli x5,x5,1
    addi x13,x13,-1
    bne x13,x0,back
    addi x26,x0,2
    bne x25,x26,exit
    addi x20,x0,0x01  # Set result to 1 if 2 out of 5

    beq x0,x0,exit2
    
exit:
    addi x20,x0,0x00  # Set result to 0 if not 2 out of 5

exit2:
    jalr x0,x1,0    # Return to caller

end_loop:
nop 
