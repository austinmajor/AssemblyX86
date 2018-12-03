; ASCII to floating point code
; author:  R. Detmer
; revised:  7/2013
.586
.MODEL FLAT
.STACK  4096

.DATA
source    BYTE   "-78.375", 0
result    REAL4  ?

.CODE
main      PROC
          lea  eax, source    ; address parameter
          push eax            ; push parameter
          call atofproc       ; atof(source)
          add  esp, 4         ; remove parameter
          fstp result         ; get result from FPU
          mov  eax, 0         ; exit
          ret
main      ENDP

atofproc  PROC
; convert ASCII string to floating point number
; Parameter passed on the stack: address of ASCII source string
; After an optional leading minus sign, only digits 0-9 and a decimal
; point are accepted -- the scan terminates with any other character.
; The floating point value is returned in ST.
; Local variables are stored on the stack:
;   ten    [EBP-4]  -- always 10 after initial code
;   point  [EBP-8]  -- Boolean, -1 for true, 0 for false
;   minus  [EBP-12] -- Boolean, -1 for true, 0 for false
;   digit  [EBP-16] -- next digit as an integer

          push ebp                      ; establish stack frame
          mov  ebp, esp
          sub  esp, 16                  ; stack space for local variables
          push eax                      ; save registers
          push esi

          mov  DWORD PTR [ebp-4], 10    ; ten := 10
          fld1                          ; divisor := 1.0
          fldz                          ; value := 0.0
          mov  DWORD PTR [ebp-8], 0     ; point := false
          mov  DWORD PTR [ebp-12], 0    ; minus := false
          mov  esi, [ebp+8]             ; address of first source character
          cmp  BYTE PTR [esi], '-'      ; leading minus sign?
          jne  endifMinus               ; skip if not
          mov  DWORD PTR [ebp-12], -1   ; minus := true
          inc  esi                      ; point at next source character
endifMinus:
          
whileOK:  mov  al, [esi]                ; get next character
          cmp  al, '.'                  ; decimal point?
          jne  endifPoint               ; skip if not
          mov  DWORD PTR [ebp-8], -1    ; point := true
          jmp  nextChar
endifPoint:
          cmp  al, '0'                  ; character >= '0'
          jnge endwhileOK               ; exit if not
          cmp  al, '9'                  ; character <= '9'
          jnle endwhileOK               ; exit if not
          and  eax, 0000000fh           ; convert ASCII to integer value
          mov  DWORD PTR [ebp-16], eax  ; put integer in memory
          fimul DWORD PTR [ebp-4]       ; value := value * 10
          fiadd DWORD PTR [ebp-16]      ; value := value + digit
          cmp  DWORD PTR [ebp-8], -1    ; already found a decimal point?
          jne  endifDec                 ; skip if not
          fxch                          ; put divisor in ST and value in ST(1)
          fimul DWORD PTR [ebp-4]       ; divisor := divisor * 10
          fxch                          ; value to ST; divisor back to ST(1)
endifDec:
nextChar: inc  esi                      ; point at next source character
          jmp  whileOK
endwhileOK:

          fdivr                         ; value := value / divisor
          cmp  DWORD PTR [ebp-12], -1   ; was there a minus sign?
          jne  endifNeg
          fchs                          ; value := -value
endifNeg:
          pop  esi                      ; restore registers
          pop  eax
          mov  esp, ebp
          pop  ebp
          ret                           ; return
atofproc  ENDP
          END
