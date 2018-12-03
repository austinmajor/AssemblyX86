; program to evaluate the expression - (x + y - 2z + 1) for
; doubleword values stored in memory, leaving the result in EAX
; author:  R. Detmer
; date:  revised 6/2013

.586
.MODEL FLAT
.STACK  4096

.DATA
x           DWORD  35
y           DWORD  47
z           DWORD  26

.CODE
main    PROC
            mov    eax, x       ; result := x
            add    eax, y       ; result := x + y
            mov    ebx, z       ; temp := z
            add    ebx, ebx     ; temp := 2*z
            sub    eax, ebx     ; result := x + y - 2z
            inc    eax          ; result := x + y - 2*z + 1
            neg    eax          ; result := - (x + y - 2*z + 1)

            mov    eax, 0       ; exit with return code 0
            ret

main    ENDP
END