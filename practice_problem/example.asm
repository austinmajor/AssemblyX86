; ***************************
; * Author:  Austin Major	*
; * Date:    11/24/2018		*
; * Practice Problem		*
; ***************************

											; ***** PSEUDOCODE *****
; #include <stdio.h>
; int mymul(int a, int b);
; int main() 
; {
;    int a, b;
;    printf("Enter a: ");
;    scanf("%d", &a);
; 
;    printf("Enter b: ");
;    scanf("%d", &b);
; 
;    printf("The answer is %d.", mymul(a,b));
;    return 0;
; }
; 
; int mymul(int a, int b)
; {
;     if (b > 0)
;        return mymul(a , b - 1) + a;
; 
;   return 0;
; }
; inputs
; a: 2
; b: 3

; outputs
; gcd: 6
											; ***** END OF PSEUDOCODE *****

.586										; *** HEADERS ***
.MODEL FLAT
INCLUDE io.h
.STACK 40

.DATA										; *** VARIABLE DECLARATION ***
string		BYTE	40 DUP (?)
varA		DWORD	?
varB		DWORD	?

print		BYTE	11 DUP (?), 0

promptA		BYTE	"Please enter a: ", 0
promptB		BYTE	"Please enter b: ", 0
result		BYTE	"a x b = ", 0



.CODE										; *** CODE BLOCK ***

; int main() 
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
		call	mymul
		add		esp, 8

		dtoa    print, eax
		output	result, print

		mov     eax, 0
        ret

_MainProc ENDP
; }

; int mymul(int a, int b) {
mymul PROC

		push	ebp
		mov		ebp, esp

;		if (b > 0) {
			mov		eax, [ebp + 12]	; b
			cmp		eax, 0			; b > 0
			jna		finish

;			return mymul(a , b - 1) + a;
				dec		eax			
				push	eax			; b-1
				push	[ebp + 8]	; a
				call	mymul
				add		esp, 8
				add		eax, [ebp + 8]
				pop		ebp
				ret
;		}

; return 0
finish:
		mov		eax, 0
		pop		ebp
		ret

mymul ENDP
; }

END											; *** END OF PROGRAM ***						

