; ***************************
; * Author:  Austin Major	*
; * Date:    11/24/2018		*
; * Home Assignment 8		*
; ***************************

											; *** PSEUDOCODE ***
; unsigned int gcd ( unsigned int a, unsigned int b ) {
;   if ( a > b )
;     return gcd ( a - b, b ) ;

;   if ( a < b )
;     return gcd ( a, b - a ) ;

;   return a ;
; }

; inputs
; a: 24
; b: 54

; outputs
; gcd: 6
											; *** END OF PSEUDOCODE ***

.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA										; *** VARIABLE DECLARATION ***
string		BYTE	40 DUP (?)
varA		DWORD	?
varB		DWORD	?
answer		DWORD	?

print		BYTE	11 DUP (?), 0

promptA		BYTE	"Please enter a: ", 0
promptB		BYTE	"Please enter b: ", 0
result		BYTE	"GCD of a and b is: ", 0



.CODE										; *** CODE BLOCK ***

; main ()
; {
_MainProc PROC

		input   promptA, string, 40
        atod    string
        mov     varA, eax

		input   promptB, string, 40
        atod    string
        mov     varB, eax

		push	varB
		push	varA
		call	gcd
		add		esp, 8

		dtoa    print, answer
		output	result, print

		mov     eax, 0
        ret

_MainProc ENDP
; }

; unsigned int gcd ( unsigned int a, unsigned int b ) {
gcd PROC

		push	ebp
		mov		ebp, esp

;recur:
		;cmp		eax, ebx
		;je		done

		mov		eax, [ebp + 8]  ; a
		mov		ebx, [ebp + 12] ; b
		cmp		eax, ebx
		je		done

	; if ( a > b ) {
			;mov		eax, [ebp + 8]  ; a
			;mov		ebx, [ebp + 12] ; b
			cmp		eax, ebx
			jb		alb
	
			; return (a - b, b);
					sub		eax, ebx
					push	eax			; a - b
					push	[ebp + 12]	; b
					call	gcd
					add		esp, 8
					mov		eax, [ebp + 12]     ; these were add
					pop		ebp
					ret
	; }
	
	; if (a < b) {
	alb:
	
			; return (a, b - a)
					sub		ebx, eax
					push	ebx			; b - a
					push	[ebp + 8]	; a
					call	gcd
					add		esp, 8
					mov		eax, [ebp + 8]    ; these were add
					pop		ebp
					ret
	; }

; return a;
done:
			mov		answer, eax
			mov		eax, 0
			pop		ebp
			ret
		
;	}
gcd ENDP
; }	

END											; *** END OF PROGRAM ***						

