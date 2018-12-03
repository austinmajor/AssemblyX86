; procedure minMax to find smallest and largest elements in an array
; and test driver for minMax   --   64-bit version
; author: R. Detmer
; date: 6/2013

.DATA
minimum   QWORD  ?
maximum   QWORD  ?
nbrArray  QWORD  25, 47, 95, 50, 16, 95 DUP (?)

.CODE
main    PROC
        sub  rsp, 32       ; local stack space
        lea  rcx, nbrArray ; 1st parameter
        mov  rdx, 5        ; 2nd parameter (number of elements)
        lea  r8, minimum   ; 3rd parameter
        lea  r9, maximum   ; 4th parameter
        call minMax    ; minMax(nbrArray, 5, minimum, maximum)

quit:   add  rsp, 32    ; clean up stack
        mov  rax, 0    ; exit with return code 0
        ret
main    ENDP

; void minMax(int arr[], int count, int& min, int& max);
; Set min to smallest value in arr[0],..., arr[count-1]
; Set max to largest value in arr[0],..., arr[count-1]
minMax PROC
    push rax      ; save registers
    push rsi

    mov  rsi,rcx  ; get address of array arr (1st parameter)
    mov  rcx,rdx  ; get value of count (2nd parameter)
    
    mov  rax, 7fffffffffffffffh ; largest possible integer
    mov  QWORD PTR [r8], rax
    mov  rax, 8000000000000000h ; smallest possible integer
    mov  QWORD PTR [r9], rax
    jrcxz exitCode    ; exit if there are no elements

forLoop:
    mov  rax, [rsi]   ; a[i]
    cmp  rax, [r8]    ; a[i] < min?
    jnl  endIfSmaller ; skip if not
    mov  [r8], rax    ; min := a[i]
endIfSmaller:
    cmp  rax, [r9]    ; a[i] > max?
    jng  endIfLarger  ; skip if not
    mov  [r9], rax    ; max := a[i]
endIfLarger:
    add  rsi, 8    ; point at next array element
    loop forLoop   ; repeat for each element of array

exitCode:
    pop  rsi     ; restore registers
    pop  rax
    ret          ; return
minMax ENDP
END
