; procedure minMax to find smallest and largest elements in an array
; author:  R. Detmer
; date:  6/2013

.586
.MODEL FLAT

.CODE

; void minMax(int arr[], int count, int& min, int& max);
; Set min to smallest value in arr[0],..., arr[count-1]
; Set max to largest value in arr[0],..., arr[count-1]
minMax  PROC
        push  ebp           ; save base pointer
        mov   ebp,esp       ; establish stack frame
        push  eax           ; save registers
        push  ebx
        push  ecx
        push  edx
        push  esi

        mov   esi,[ebp+8]   ; get address of array arr
        mov   ecx,[ebp+12]  ; get value of count
        mov   ebx, [ebp+16] ; get address of min
        mov   edx, [ebp+20] ; get address of max
        
        mov   DWORD PTR [ebx], 7fffffffh  ; largest possible integer
        mov   DWORD PTR [edx], 80000000h  ; smallest possible integer
        jecxz exitCode      ; exit if there are no elements

forLoop:
        mov   eax, [esi]    ; a[i]
        cmp   eax, [ebx]    ; a[i] < min?
        jnl   endIfSmaller  ; skip if not
        mov   [ebx], eax    ; min := a[i]
endIfSmaller:
        cmp   eax, [edx]    ; a[i] > max?
        jng   endIfLarger   ; skip if not
        mov   [edx], eax    ; max := a[i]
endIfLarger:
        add   esi, 4        ; point at next array element
        loop  forLoop       ; repeat for each element of array

exitCode:
        pop    esi          ; restore registers
        pop    edx
        pop    ecx
        pop    ebx
        pop    eax
        pop    ebp
        ret                 ; return
minMax  ENDP
END
