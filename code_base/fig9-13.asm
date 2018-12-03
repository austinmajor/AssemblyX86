; compute roots of quadratic equation
; author: R. Detmer
; date: 7/2013

.586
.MODEL FLAT
.STACK 4096

.DATA
aa      REAL4   2.0
bb      REAL4   -1.0
cc      REAL4  -15.0
discr   REAL4   ?
x1      REAL4   ?
x2      REAL4   ?
four    DWORD   4
two     DWORD   2

.CODE
main    PROC
        finit           ; initialize FPU
        fld     bb      ; b in ST
        fmul    bb      ; b*b
        fild    four    ; 4.0 in ST
        fmul    aa      ; 4*a
        fmul    cc      ; 4*a*c
        fsub            ; b*b-4*a*c
        fldz            ; 0.0 in ST
        fxch            ; b*b-4*a*c in ST; 0.0 in ST(1)
        fcom    st(1)   ; b*b-4*a*c >= 0 ?
        fstsw   ax      ; copy condition code bits to AX
        sahf            ; shift condition code bits to flags
        jnae    endGE   ; skip if not
        fsqrt           ; sqrt(b*b-4*a*c) in ST
        fst     st(1)   ; copy to ST(1)
        fsub    bb      ; -b + sqrt(b*b-4*a*c)
        fdiv    aa      ; (-b + sqrt(b*b-4*a*c))/a
        fidiv   two     ; (-b + sqrt(b*b-4*a*c))/(2*a)
        fstp    x1      ; save and pop stack
        fchs            ; -sqrt(b*b-4*a*c)
        fsub    bb      ; -b - sqrt(b*b-4*a*c)
        fdiv    aa      ; (-b - sqrt(b*b-4*a*c))/a
        fidiv   two     ; (-b - sqrt(b*b-4*a*c))/(2*a)
        fstp    x2      ; save and pop stack
endGE:
        mov     eax, 0  ; exit
        ret
main    ENDP 
END               
        
        
        