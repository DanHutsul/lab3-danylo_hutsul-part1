format pe64 console

include 'win64axp.inc' 
entry start

arr dd 1, 5, 10, 3
arr_sz dw 4

section '.sort' executable
start:
        mov rsp, 0 ;First iterator
        mov rax, 0 ;Second iterator
        jmp compare

compare:
        mov eax, [arr + rax*4]
        mov edx, [arr + rax*4 + 4]
        cmp eax, edx

        jle next
        jnl swap

swap:
        mov [arr + rax*4], edx
        mov [arr + rax*4+4], eax
        jmp next

next:
        inc rax
        mov rcx, arr_sz
        sub rcx, rsp
        dec rcx

        inc rax
        cmp rax, rcx
        jle compare
        jnl loop_increase

loop_increase:
        inc rsp
        mov rax, 0
        cmp rsp, 3
        jle compare
        jnl exit_all

exit_all:
        call [exit]


section '.import' import data readable

library msvcrt,'msvcrt.dll'    ;; C-Run time from MS. This is always on every windows machine

import msvcrt,\
          printf,'printf',\ 
                  exit,'exit'