; program to find sum 1+2+...+n for n=1, 2, ...
; author:  R. Detmer
; revised:  6/2013

.586
.MODEL FLAT
.STACK  4096

.DATA

.CODE
main     PROC
         mov    ebx,0            ; number := 0
         mov    eax,0            ; sum := 0

forever: inc    ebx              ; add 1 to number
         add    eax, ebx         ; add number to sum
         jmp    forever          ; repeat

main     ENDP
END
