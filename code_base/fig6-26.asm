; procedure add5 to add five parameters
; 64-bit version
; author: R. Detmer
; date: 6/2013

.CODE

; void add5(int x1, int x2, int x3, int x4, int x5);
; returns sum of arguments
add5    PROC
        mov  eax, ecx   ; x1
        add  eax, edx   ; x2
        add  eax, r8d   ; x3
        add  eax, r9d   ; x4
        add  eax, DWORD PTR [rsp+40]    ; x5
        ret             ; return
add5    ENDP
END
