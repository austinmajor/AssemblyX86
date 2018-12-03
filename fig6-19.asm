; and test driver for minMax
; author:  R. Detmer
; date:  6/2013

.586
.MODEL FLAT
.STACK  4096

.DATA
minimum     DWORD   ?
maximum     DWORD   ?
nbrArray    DWORD   25, 47, 95, 50, 16, 84 DUP (?)

EXTERN minMax:PROC

.CODE
main    PROC
        lea   eax, maximum  ; 4th parameter
        push  eax
        lea   eax, minimum  ; 3rd parameter
        push  eax
        pushd 5             ; 2nd parameter (number of elements)
        lea   eax, nbrArray ; 1st parameter
        push  eax            
        call  minMax        ; minMax(nbrArray, 5, minimum, maximum)
        add   esp, 16       ; remove parameters from stack

quit:   mov   eax, 0        ; exit with return code 0
        ret
main    ENDP
END
