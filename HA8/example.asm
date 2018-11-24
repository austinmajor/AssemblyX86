; ***************************
; * Author:  Austin Major	*
; * Date:    11/24/2018		*
; * Home Assignment 8		*
; ***************************

; ***** PSEUDOCODE *****
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
; ***** END OF PSEUDOCODE *****

.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA										; ***VARIABLE DECLARATION***
string		BYTE	40 DUP (?)
varA		DWORD	?
varB		DWORD	?

print		BYTE	11 DUP (?), 0

promptA		BYTE	"Please enter a: ", 0
promptB		BYTE	"Please enter b: ", 0
result		BYTE	"GCD of a and b is: ", 0



.CODE										; ***CODE BLOCK***
_MainProc PROC
; main ()
; {
		input   promptA, string, 40
        atod    string
        mov     varA, eax

		input   promptB, string, 40
        atod    string
        mov     varB, eax

		mov		eax, varA
		mov		ebx, varB
; }

; unsigned int gcd ( unsigned int a, unsigned int b ) {
recur:
		cmp		eax, ebx
		je		done

	; if ( a > b ) {
			cmp		eax, ebx
			jb		alb
	
	; return (a - b, b);
			sub		eax, ebx
			
			cmp		eax, ebx
			je		done
			jmp		recur
	; }
	
	; if (a < b) {
	alb:
	
	; return (a, b - a)
			sub		ebx, eax
	
			cmp		eax, ebx
			je		done
	
			jmp		recur
	; }

; return a;
done:
		dtoa    print, eax
		output	result, print	
		
;	}
; }	

		mov     eax, 0
        ret
_MainProc ENDP
END											; ***END OF PROGRAM***						

