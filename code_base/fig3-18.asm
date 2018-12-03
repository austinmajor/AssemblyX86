; Example assembly language program
; adds 158 to number in memory
; Author:  R. Detmer
; Date:    6/2013

.DATA
number  QWORD   -105
sum     QWORD   ?

.CODE
main    PROC
        mov     rax, number     ; first number to EAX
        add     rax, 158        ; add 158
        mov     sum, rax        ; sum to memory

        mov     rax, 0          ; return code
        ret                     ; exit to operating system
        
main    ENDP

END
