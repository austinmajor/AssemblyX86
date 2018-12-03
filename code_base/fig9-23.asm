; compute discriminant using SSE instructions
; author: R. Detmer
; date: 7/2013

.DATA
a       REAL4   2.0
b       REAL4   -1.0
c       REAL4   -15.0
discr   REAL4   ?
four    REAL4   4.0

.CODE
main    PROC
        movss   xmm0, b     ; copy b
        mulss   xmm0, xmm0  ; b*b
        movss   xmm1, four  ; 4.0
        mulss   xmm1, a     ; 4*a
        mulss   xmm1, c     ; 4*a*c
        subss   xmm0, xmm1  ; b*b-4*a*c
        sqrtss  xmm0, xmm0  ; sqrt(b*b-4*a*c)
        movss   discr, xmm0 ; store result

        mov     rax, 0       ; exit     
        ret
main    ENDP 
END               
        
        
        