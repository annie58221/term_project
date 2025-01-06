.data
buffer: .space 21               # String buffer for the converted number
newline: .asciz "\n"            # Newline character

.text
.global _start
_start:
int_to_string:
    addi sp, sp, -16            # Save stack frame
    sw ra, 12(sp)               # Save return address
    sw t0, 8(sp)                # Save t0
    sw t1, 4(sp)                # Save t1

    mv t0, a0                   # Copy input number (a0) to t0
    addi t1, a1, 16             # Point to the end of the buffer
    li a0, 0                    # Initialize the length counter

loop:
    li t3, 10                   # Load divisor (10)
    rem t2, t0, t3              # t2 = t0 % 10 (remainder)
    addi t2, t2, '0'            # Convert the remainder to ASCII character
    addi t1, t1, -1             # Move the buffer pointer back
    sb t2, 0(t1)                # Store the character in the buffer
    div t0, t0, t3              # t0 = t0 / 10 (integer division)
    addi a0, a0, 1              # Increment the length counter
    bnez t0, loop               # Repeat if t0 != 0

    mv a1, t1                   # Return the string starting address in a1
    lw ra, 12(sp)               # Restore return address
    lw t0, 8(sp)                # Restore t0
    lw t1, 4(sp)                # Restore t1
    addi sp, sp, 16             # Restore stack frame
    ret                         # Return to caller
