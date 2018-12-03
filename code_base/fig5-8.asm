; program to determine how many days it takes to earn $1,000,000
; starting with 1 cent on day 1, 2 cents on day 2, 4 cents on day 3, etc.
; Author:  R. Detmer
; Date:    6/2013

.586
.MODEL FLAT
.STACK  4096

.DATA
.CODE
main        PROC        
            mov   ebx, 1      ; nextDaysWage := 1
            mov   eax, 0      ; totalEarnings := 0
            mov   ecx, 0      ; day := 0
whilePoor:  cmp   eax, 100000000 ; totalEarnings < 100,000,000 cents?
            jnl   endLoop     ; exit if not
            add   eax, ebx    ; add nextDaysWage to totalEarnings
            add   ebx, ebx    ; multiply nextDaysWage by 2
            inc   ecx         ; add 1 to day
            jmp   whilePoor   ; repeat
endLoop:
            mov   eax, 0      ; exit with return code 0
            ret
main        ENDP
END
