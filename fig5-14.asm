; given an array of doubleword integers, (1) find their average
; and (2) add 10 to each number smaller than average using indexed addressing
; author:  R. Detmer
; revised:  6/2013

.586
.MODEL FLAT
.STACK  4096

.DATA
nbrArray    DWORD    25, 47, 15, 50, 32, 95 DUP (?)
nbrElts     DWORD    5
.CODE
main        PROC
; find sum and average
            mov    eax,0            ; sum := 0
            mov    ecx,0            ; index := 0
for1:       cmp    ecx,nbrElts      ; index < nbrElts
            jnl    endFor1          ; exit if not
            add    eax,nbrArray[4*ecx]  ; add number to sum
            inc    ecx              ; increment index
            jmp    for1             ; repeat
endFor1:
            cdq                     ; extend sum to quadword
            idiv   nbrElts          ; calculate average

; add 10 to each array element below average
            mov    ecx,0            ; index := 0
for2:       cmp    ecx,nbrElts      ; index < nbrElts
            jnl    endFor2          ; exit if not
            cmp    nbrArray[4*ecx],eax  ; number < average ?
            jnl    endIfSmall       ; continue if not less
            add    DWORD PTR nbrArray[4*ecx], 10   ; add 10 to number
endIfSmall:
            inc    ecx              ; increment index
            jmp    for2             ; repeat
endFor2:            
quit:       mov   eax, 0      ; exit with return code 0
            ret

main        ENDP
END
