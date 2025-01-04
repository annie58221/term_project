.data
msg: .asciz "Correct!\n"

.text
.global _start

_start:
    li a0, 16
    jal ra, logint
    li t0, 4
    bne a0, t0, end
    li a7, 64          # syscall number for write
    li a0, 1           # file descriptor (stdout)
    la a1, msg         # address of the message
    li a2, 10          # length of the message
    ecall
    
end:
    li a7, 93
    li a0,0
    ecall

logint:
    addi sp, sp, -4
    sw t0, 0(sp)

    add t0, a0, zero# k = N
    add a0, zero, zero# i = 0

logloop:
    beq t0, zero, logloop_end # Exit if k == 0
    srai t0, t0, 1 # k >>= 1
    addi a0, a0, 1 # i++
    j logloop

logloop_end:
    addi a0, a0, -1 # Return i - 1
    lw t0, 0(sp)
    addi sp, sp, 4
    jr ra
