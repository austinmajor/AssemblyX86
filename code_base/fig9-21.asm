; input coefficients, solve quadratic eqn, display roots
; Author: R. Detmer
; Date: 7/2013

.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096
EXTERN ftoaproc:PROC, atofproc:PROC

.DATA
prompt1 BYTE    "Coefficient of x^2?", 0
prompt2 BYTE    "Coefficient of x?", 0
prompt3 BYTE    "Constant term?", 0
string  BYTE    40 DUP (?)
rootsLbl BYTE   "The roots are", 0
root1   BYTE    12 DUP (?), 0dh, 0ah
root2   BYTE    12 DUP (?)
aa      REAL4   ?
bb      REAL4   ?
cc      REAL4   ?
discr   REAL4   ?
x1      REAL4   ?
x2      REAL4   ?
four    DWORD   4
two     DWORD   2

.CODE
_MainProc PROC
        input   prompt1, string, 40 ; first coefficient
        lea     ebx, string     ; parameter for ftoaproc
        push    ebx
        call    atofproc  ; ftoaproc(string)
        add     esp, 4  ; remove parameter
        fstp    aa      ; store x*x coefficient

        input   prompt2, string, 40 ; second coefficient
        push    ebx     ; source address parameter
        call    atofproc  ; ftoaproc(string)
        add     esp, 4  ; remove parameter
        fstp    bb      ; store x coefficient
        
        input   prompt3, string, 40  ; third coefficient
        push    ebx     ; source address parameter
        call    atofproc  ; ftoaproc(string)
        add     esp, 4  ; remove parameter
        fstp    cc      ; store constant
        
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
        fsub    bb      ; -b -sqrt(b*b-4*a*c)
        fdiv    aa      ; (-b + sqrt(b*b-4*a*c))/a
        fidiv   two     ; (-b + sqrt(b*b-4*a*c))/(2*a)
        fstp    x2      ; save and pop stack
endGE:
        lea     ebx, root1   ; address for first root
        push    ebx     ; 2nd parameter
        push    x1      ; 1st parameter, fp source
        call    ftoaproc  ; ftoaproc(x1, root1)
        add     esp, 8  ; remove parameters
        lea     ebx, root2   ; address for second root
        push    ebx     ; 2nd parameter
        push    x2      ; 1st parameter, fp source
        call    ftoaproc  ; ftoaproc(x1, root1)
        add     esp, 8  ; remove parameters
        output  rootsLbl, root1

        mov     eax, 0  ; exit 
        ret
_MainProc ENDP
END