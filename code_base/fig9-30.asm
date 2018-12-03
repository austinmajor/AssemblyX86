; compute roots of quadratic equation
; author: R. Detmer
; date: 7/2013

.DATA
four    REAL4   4.0
two     REAL4   2.0
zero    REAL4   0.0

.CODE
; void roots(float a, float b, float c, float* x1, float* x2)
roots   PROC
        movss   xmm3, xmm1  ; copy b
        mulss   xmm3, xmm3  ; b*b
        movss   xmm4, four  ; 4.0
        mulss   xmm4, xmm0  ; 4*a
        mulss   xmm4, xmm2  ; 4*a*c
        subss   xmm3, xmm4  ; b*b-4*a*c
        comiss  xmm3, zero  ; b*b-4*a*c >= 0?
        jnae    endGE       ; skip if not
        sqrtss  xmm3, xmm3  ; sqrt(b*b-4*a*c)
        movss   xmm4, zero  ; 0
        subss   xmm4, xmm1  ; -b
        addss   xmm4, xmm3  ; -b + sqrt(b*b-4*a*c)
        divss   xmm4, xmm0  ; (-b + sqrt(b*b-4*a*c))/a
        divss   xmm4, two   ; (-b + sqrt(b*b-4*a*c))/(2*a)
        movss   REAL4 PTR [r9], xmm4   ; store root1
        movss   xmm4, zero  ; 0
        subss   xmm4, xmm1  ; -b
        subss   xmm4, xmm3  ; -b - sqrt(b*b-4*a*c)
        divss   xmm4, xmm0  ; (-b - sqrt(b*b-4*a*c))/a
        divss   xmm4, two   ; (-b - sqrt(b*b-4*a*c))/(2*a)
        mov     r9, [rsp+40] ; addr of root2
        movss   REAL4 PTR [r9], xmm4   ; store root2
endGE:        
        ret
roots   ENDP 
END               
        
        
        