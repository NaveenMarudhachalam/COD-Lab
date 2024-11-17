    .data
num: .byte 0xa2           # Input byte (8-bit value to encode)

    .text
    .globl _start
_start:
    la x1, num             # Load address of num into x1
    lb x2, 0(x1)           # Load the 8-bit value into x2

    # Calculate parity bit C0
    mv x3, x2              # Copy the input byte to x3
    srli x4, x3, 1         # Shift right by 1 bit (d1)
    srli x5, x3, 2         # Shift right by 2 bits (d2)
    srli x6, x3, 3         # Shift right by 3 bits (d3)
    srli x7, x3, 4         # Shift right by 4 bits (d4)
    srli x8, x3, 5         # Shift right by 5 bits (d5)
    srli x9, x3, 6         # Shift right by 6 bits (d6)
    xor x3, x3, x4         # XOR all shifted bits to get parity for C0
    xor x3, x3, x5
    xor x3, x3, x6
    xor x3, x3, x7
    xor x3, x3, x8
    xor x3, x3, x9
    andi x10, x3, 1        # Mask to get the parity bit (C0)

    # Calculate parity bit C1
    mv x3, x2              # Reset x3 to the input byte
    srli x4, x3, 0         # No shift (d0)
    srli x5, x3, 2         # Shift right by 2 bits (d2)
    srli x6, x3, 3         # Shift right by 3 bits (d3)
    srli x7, x3, 5         # Shift right by 5 bits (d5)
    srli x8, x3, 6         # Shift right by 6 bits (d6)
    xor x3, x4, x5         # XOR selected bits to get parity for C1
    xor x3, x3, x6
    xor x3, x3, x7
    xor x3, x3, x8
    andi x11, x3, 1        # Mask to get the parity bit (C1)

    # Calculate parity bit C2
    mv x3, x2              # Reset x3 to the input byte
    srli x4, x3, 0         # No shift (d0)
    srli x5, x3, 1         # Shift right by 1 bit (d1)
    srli x6, x3, 3         # Shift right by 3 bits (d3)
    srli x7, x3, 4         # Shift right by 4 bits (d4)
    srl x8, x3, x7        # Shift right by 6 bits (d6)
    xor x3, x4, x5         # XOR selected bits to get parity for C2
    xor x3, x3, x6
    xor x3, x3, x7
    xor x3, x3, x8
    andi x12, x3, 1        # Mask to get the parity bit (C2)

    # Calculate parity bit C3
    mv x3, x2              # Reset x3 to the input byte
    srli x4, x3, 4         # Shift right by 4 bits (d4)
    srli x5, x3, 5         # Shift right by 5 bits (d5)
    srli x6, x3, 6         # Shift right by 6 bits (d6)
    srli x7, x3, 7         # Shift right by 7 bits (d7)
    xor x3, x4, x5         # XOR selected bits to get parity for C3
    xor x3, x3, x6
    xor x3, x3, x7
    andi x13, x3, 1        # Mask to get the parity bit (C3)

    # At this point:
    # x10 holds C0
    # x11 holds C1
    # x12 holds C2
    # x13 holds C3
