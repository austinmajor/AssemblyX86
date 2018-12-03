; Input x and y, call procedure to evaluate 3*x+7*y, display result
; Author:  R. Detmer
; Date:    6/2013
.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA
number1 DWORD   ?
number2 DWORD   ?
prompt1 BYTE    "Enter first number x", 0
prompt2 BYTE    "Enter second number y", 0
string  BYTE    20 DUP (?)
resultLbl BYTE  "3*x+7*y", 0
result  BYTE    11 DUP (?), 0

.CODE
_MainProc PROC
        input   prompt1, string, 20      ; read ASCII characters
        atod    string          ; convert to integer
        mov     number1, eax    ; store in memory

        input   prompt2, string, 20      ; repeat for second number
        atod    string
        mov     number2, eax
        
        push    number2         ; 2nd parameter
        push    number1         ; 1st parameter
        call    fctn1           ; fctn1(number1, number2)
        add     esp, 8          ; remove parameters from stack
        
        dtoa    result, eax     ; convert to ASCII characters
        output  resultLbl, result  ; output label and result

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP

; int fctn1(int x, int y)
; returns 3*x+7*y
fctn1   PROC
        push    ebp             ; save base pointer
        mov     ebp, esp        ; establish stack frame
        push    ebx             ; save EBX
        
        mov     eax, [ebp+8]    ; x
        imul    eax, 3          ; 3*x
        mov     ebx, [ebp+12]   ; y
        imul    ebx, 7          ; 7*y
        add     eax, ebx        ; 3*x + 7*y
        
        pop     ebx             ; restore EBX
        pop     ebp             ; restore EBP
        ret                     ; return      
fctn1   ENDP

END

