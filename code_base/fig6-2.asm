; stack usage example
; Author:  R. Detmer
; Date:    6/2013

.586
.MODEL FLAT

.STACK  4096            ; reserve 4096-byte stack

.DATA
.CODE
main    PROC
        mov  eax, 83b547a2h
        push eax
        pushd -240

        add   esp, 8
	mov   eax, 0
        ret
main    ENDP

END
