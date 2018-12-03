; Find the integer log base 2 of number in memory
; Author:  R. Detmer
; Date:    6/2013

.586
.MODEL FLAT
.STACK  4096

.DATA
number  DWORD   750

.CODE
main        PROC        
            mov   ecx, 0      ; x := 0
            mov   eax, 1      ; twoToX := 1
whileLE:    cmp   eax, number ; twoToX <= number?
            jnle  endWhileLE  ; exit if not
body:       add   eax, eax    ; multiply twoToX by 2
            inc   ecx         ; add 1 to x
            jmp   whileLE     ; go check condition again
endWhileLE:
            dec   ecx         ; subtract 1 from x
        
            mov   eax, 0      ; exit with return code 0
            ret
main        ENDP
END
