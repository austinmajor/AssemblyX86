; compute roots of quadratic equation
; author: R. Detmer
; date: 7/2013

.586
.MODEL FLAT

.DATA
four    DWORD   4
two     DWORD   2

.CODE
; void roots(float a, float b, float c, float* x1, float* x2)
_roots  PROC
        push   ebp      ; save base register
        mov    ebp, esp ; establish stack frame
        push   eax      ; save EAX

        finit           ; initialize FPU
        fld     REAL4 PTR [ebp+12]      ; b in ST
        fmul    REAL4 PTR [ebp+12]      ; b*b
        fild    four          ; 4.0 in ST
        fmul    REAL4 PTR [ebp+8]       ; 4*a
        fmul    REAL4 PTR [ebp+16]      ; 4*a*c
        fsub            ; b*b-4*a*c
        fldz            ; 0.0 in ST
        fxch            ; b*b-4*a*c in ST; 0.0 in ST(1)
        fcom    st(1)   ; b*b-4*a*c >= 0 ?
        fstsw   ax      ; copy condition code bits to AX
        sahf            ; shift condition code bits to AL
        jnae    endGE   ; skip if not
        fsqrt           ; sqrt(b*b-4*a*c) in ST
        fst     st(1)   ; copy to ST(1)
        fsub    REAL4 PTR [ebp+12]      ; -b + sqrt(b*b-4*a*c)
        fdiv    REAL4 PTR [ebp+8]       ; (-b + sqrt(b*b-4*a*c))/a
        fidiv   two     ; (-b + sqrt(b*b-4*a*c))/(2*a)
        mov     eax, [ebp+20]   ; address of x1
        fstp    REAL4 PTR [eax]      ; save and pop stack
        fchs            ; -sqrt(b*b-4*a*c)
        fsub    REAL4 PTR [ebp+12]      ; -b -sqrt(b*b-4*a*c)
        fdiv    REAL4 PTR [ebp+8]       ; (-b + sqrt(b*b-4*a*c))/a
        fidiv   two     ; (-b + sqrt(b*b-4*a*c))/(2*a)
        mov     eax, [ebp+24]   ; address of x2
        fstp    REAL4 PTR [eax]      ; save and pop stack
endGE:
        
        pop     eax     ; restore registers
        pop     ebp
        ret
_roots  ENDP 
END               
        
        
        