  .section ".text.init","ax",@progbits
  .globl _start
  .align 2
_start:

  # mhcr
  # li t0, 0x1070
  li t0, 0x0070 # Disable the L0BTB
  csrw 0x7C1, t0
  # mcor
  li t0, 0x3
  slli t0, t0, 16
  csrw 0x7C2, t0

  .rept 30
    nop
  .endr

  # Make a simple for loop that decreases i from 5 to 0
  li t0, 10
  li t1, 0
loop:
  addi t1, t1, 1
  bne t1, t0, loop

  .rept 30
    nop
  .endr

  sw zero, 8(zero)
  fence
  .rept 1000
    nop
  .endr

# # Loop 10 times
#   li t0, 10
#   li t1, 0
# loop10:
#   addi t1, t1, 1
#   bne t1, t0, loop10

  .rept 20
    nop
  .endr

  # Infinite loop
infiniteloop:
  j infiniteloop
