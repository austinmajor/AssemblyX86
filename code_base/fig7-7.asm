; hex to ASCII procedure and test driver
; author:  R. Detmer
; revised:  6/2013

.586
.MODEL FLAT
.STACK  4096

; test driver for hexToAscii procedure
.DATA
source      DWORD   0b70589a4h
dest        BYTE    8 DUP (?)
.CODE
main        PROC
            lea     eax, dest   ; destination address
            push    eax         ; second operand
            push    source      ; source (1st operand)
            call    hexToAscii  ; hexToAscii(source, dest)
            add     esp, 8      ; discard parameters        
quit:       mov     eax, 0      ; exit with return code 0
            ret
main        ENDP            
        
hexToAscii  PROC
; Convert doubleword to string of eight ASCII codes
; Parameters:
; (1) doubleword containing source value
; (2) doubleword containing destination address of 8 byte long area
            push    ebp             ; establish stack frame
            mov     ebp, esp
            push    eax             ; save registers
            push    ebx
            push    ecx
            push    edx
            mov     eax, [ebp+8]    ; source value to EAX
            mov     edx, [ebp+12]   ; destination address to EDX
            mov     ecx, 8          ; loop count
forIndex:   mov     ebx, eax        ; copy value
            and     ebx, 0000000fh  ; mask off all but last 4 bits
ifDigit:    cmp     bl, 9           ; digit <= 9?
            jnle    elseHex         ; skip if not
            or      bl, 30h         ; convert digit to ASCII
            jmp     endIfDigit      ; exit if
elseHex:    add     bl, 'A'-10      ; convert letter to ASCII
endIfDigit:
            mov     [edx+ecx-1], bl ; store in memory
            shr     eax, 4          ; shift next digit to right
            loop    forIndex        ; iterate loop

            pop     edx             ; restore registers
            pop     ecx
            pop     ebx
            pop     eax
            pop     ebp             ; restore base pointer
            ret                     ; return
hexToAscii  ENDP
END