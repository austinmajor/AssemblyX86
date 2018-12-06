; ***************************
; * Author:  Austin Major	*
; * Date:    11/24/2018		*
; * Home Assignment 8		*
; ***************************

											; *** PSEUDOCODE ***
;int main(){
    ;int array[4, -2, -7, 0, -7], size, eax=0;


    ;/* Iterate form index 0 to size and 
 ;check for negative numbers */
    ;for(var int index = 0; index < size; index++){
        ;if(array[index] < 0) {
            ;eax++;
        ;}
    ;}
 
    ;printf("Number of Negative Elements in Array : %d\n", counter);

    ;return 0;
;}

; outputs: 3
											; *** END OF PSEUDOCODE ***

.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA										; *** VARIABLE DECLARATION ***
string		BYTE	40 DUP (?)

print		BYTE	11 DUP (?), 0

result		BYTE	"There are X negatives: ", 0

array		DWORD   4, -2, -7, 0, -7 DUP (?)
sizeA		DWORD   ?



.CODE										; *** CODE BLOCK ***

; main ()
; {
_MainProc PROC

		push	sizeA
		push	array
		call	CountNeg
		add		esp, 8

		dtoa    print, eax
		output	result, print

		mov     eax, 0
        ret

_MainProc ENDP
; }

; CountNeg ( array, size ) {
CountNeg  PROC
        push  ebp           ; save base pointer
        mov   ebp,esp       ; establish stack frame
        push  eax           ; save registers
        push  ebx
        push  ecx
        push  edx
        push  esi

		;for(var index = 0; index < size; eax++){
forLoop:
		cmp	  ecx, sizeA
		jnl	  ifSmaller

		;if(array[index] < 0) {
ifSmaller:
		dec	  sizeA
		inc	  eax

        cmp   eax, 0		; a[i] < 0?
        jnl   incEax   ; skip if not

		   ;eax++;
incEax:
		inc   eax
		add	  ebp, 4
		jmp   forLoop

        ;}

; }

exitCode:
        pop    esi          ; restore registers
        pop    edx
        pop    ecx
        pop    ebx
        pop    eax
        pop    ebp
        ret                 ; return
CountNeg  ENDP
; }	

END											; *** END OF PROGRAM ***						

