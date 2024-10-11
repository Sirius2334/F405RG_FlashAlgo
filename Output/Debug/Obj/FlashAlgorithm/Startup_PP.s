# 0 "D:\\Software\\STM32\\F405RG\\FlashAlgo\\Src\\Startup.s"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "D:\\Software\\STM32\\F405RG\\FlashAlgo\\Src\\Startup.s"
# 15 "D:\\Software\\STM32\\F405RG\\FlashAlgo\\Src\\Startup.s"
.macro ISR_HANDLER name=
  .section .vectors, "ax"
  .word \name
  .section .init, "ax"
  .thumb_func
  .weak \name
\name:
1: b 1b
.endm

.macro ISR_RESERVED
  .section .vectors, "ax"
  .word 0
.endm

  .syntax unified
  .global reset_handler
  .extern main

  .section .vectors, "ax"
  .code 16
  .global _vectors

.macro DEFAULT_ISR_HANDLER name=
  .thumb_func
  .weak \name
\name:
1: b 1b
.endm



_vectors:
  .word __stack_end__
  .word reset_handler
ISR_HANDLER NMI_Handler
ISR_HANDLER HardFault_Handler
ISR_RESERVED
ISR_RESERVED
ISR_RESERVED
ISR_RESERVED
ISR_RESERVED
ISR_RESERVED
ISR_RESERVED
ISR_HANDLER SVC_Handler
ISR_RESERVED
ISR_RESERVED
ISR_HANDLER PendSV_Handler
ISR_HANDLER SysTick_Handler
  .section .vectors, "ax"
_vectors_end:

  .section .init, "ax"
  .thumb_func

reset_handler:



  ldr r1, =__stack_end__
  mov sp, r1
  ldr r1, =__stack_process_end__
  msr psp, r1



  movs r0, #0
  mov lr, r0
  mov r12, sp



  movs r0, #0
  movs r1, #0
  ldr r2, =main
  blx r2




  .section .stack, "wa", %nobits
  .section .stack_process, "wa", %nobits
  .section .heap, "wa", %nobits
