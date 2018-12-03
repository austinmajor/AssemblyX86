; program to convert Celsius temperature in memory at cTemp
; to Fahrenheit equivalent in memory at fTemp
; author:  R. Detmer
; date:  revised 6/2013

.586
.MODEL FLAT
.STACK  4096

.DATA
cTemp   DWORD  35    ; Celsius temperature
fTemp   DWORD  ?     ; Fahrenheit temperature

.CODE
main    PROC
        mov    eax, cTemp       ; start with Celsius temperature
        imul   eax,9            ; C*9
        add    eax,2            ; rounding factor for division
        mov    ebx,5            ; divisor
        cdq                     ; prepare for division
        idiv   ebx              ; C*9/5
        add    eax,32           ; C*9/5 + 32
        mov    fTemp, eax       ; save result
        mov    eax, 0           ; exit with return code 0
        ret

main    ENDP
END