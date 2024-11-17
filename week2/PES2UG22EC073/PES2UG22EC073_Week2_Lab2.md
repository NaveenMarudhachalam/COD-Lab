Program 2:
Statement:
The provided RISC-V assembly code calculates the expression x = (y + m) - (L - D) + (Z + C) - D using predefined integer values loaded from memory. It performs a series of arithmetic operations to compute the result and stores it in memory. Finally, the program exits gracefully with a syscall.

Name of file:
Enter the name of the file

Observation - Explanation
Arithmetic Operations: The code calculates the expression using loaded integer values.

Memory Storage: Results are stored back into memory.

Program Exit: The program exits gracefully with a syscall.



Observation - Single Cycle
Cycles: Enter the info from RIPES

Frequency: Enter the info from RIPES

CPI: Enter the info from RIPES

IPC: Enter the info from RIPES



Observation - 5 Stage
Cycles: Enter the info from RIPES

Frequency: Enter the info from RIPES

CPI: Enter the info from RIPES

IPC: Enter the info from RIPES



Memory Mapping

0x10000000: 0x0000000a

0x10000004: 0x00000005

0x10000008: 0x00000014

0x1000000c: 0x00000003

0x10000010: 0x0000000f

0x10000014: 0x00000002

0x10000018: 0x0000000c




Register Mapping

x0: 0x00000000

x1: 0x0000000a

x2: 0x00000005

x3: 0x00000014

x4: 0x00000003

x5: 0x0000000f

x6: 0x00000002

x7: 0x0000000f

x8: 0x00000011

x9: 0xfffffffe

x10: 0x00000111

x11: 0x00000011

x12: 0x0000000c

x17: 0x0000000a

x20: 0x10000018



Program 1:
Statement:
The RISC-V assembly code performs the addition of three different types of data: words, half-words, and bytes, each defined in memory. It iterates through the respective arrays, accumulating the sums for each type and storing the results in designated memory locations. Finally, the program exits gracefully using a syscall.

Name of file:
Enter the name of the file

Observation - Explanation
Data Type Addition: The code adds words, half-words, and bytes from memory.

Accumulation of Sums: It accumulates sums for each data type and stores the results in memory.

Program Exit: The program exits gracefully using a syscall.

Observation - Single Cycle
Cycles: Enter the info from RIPES

Frequency: Enter the info from RIPES

CPI: Enter the info from RIPES

IPC: Enter the info from RIPES

Observation - 5 Stage
Cycles: Enter the info from RIPES

Frequency: Enter the info from RIPES

CPI: Enter the info from RIPES

IPC: Enter the info from RIPES

Memory Mapping
0x10000000: 0x00000005

0x10000004: 0x00000005

0x10000008: 0x00000005

0x1000000c: 0x00000001

0x10000010: 0x00000002

0x10000014: 0x00000003

0x10000018: 0x00000004

0x1000001c: 0x00000001

0x10000020: 0x00000001

0x10000024: 0x00040003

0x10000028: 0x02010005

0x1000002c: 0xf050403

0x10000030: 0xf050403

0x10000034: 0x00000000

0x10000038: 0x00000000

0x1000003c: 0x00000000

Register Mapping
x0: 0x00000000

x1: 0x00000000

x2: 0x7ffffff0

x3: 0x10000000

x4: 0x00000000

x5: 0x00000005

x6: 0x1000000f

x7: 0x0000000f

x8: 0x00000005

x9: 0x00000005

x10: 0x10000037

x11: 0x00000000

x12: 0x00000000

x13: 0x00000000

x14: 0x00000000

x15: 0x00000000

x16: 0x00000000

x17: 0x0000000a

x18: 0x00000000
