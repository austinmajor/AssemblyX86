; ***************************
; * Author:  Austin Major	*
; * Date:    10/10/2018		*
; * Home Assignment 7		*
; ***************************

; *** PSEUDOCODE ***
; Declare a 32-bit integer array A[10] in memory

; REPEAT
; Prompt for and input user's array length L
; UNTIL 0 <= L <= 10

; FOR i := 0 to (L-1)
; Prompt for and input A[i]
; END FOR

; WHILE (First character of prompted input string for searching = 'Y' or 'y')
; Prompt for and input value V to be searched
; found := FALSE
; FOR i := 0 to (L-1)
;   IF V = A[i] then
;     found := TRUE
;     break
;   END IF
;  END FOR

; IF (found) THEN
;   Display message that value was found at position i
; ELSE
;   Display message that value was not found
; END IF
; END WHILE

; (Note: To read a Y or N character from the keyboard, use the same input macro to read a string of one character 
; (followed by the null byte), and look at the first byte of the string read.)

; *** END OF PSEUDOCODE ***

.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA										; ***VARIABLE DECLARATION***
promptL		BYTE	"Please input array length between 0 and 10: ", 0
promptA		BYTE	"Please input a value: ", 0
promptC		BYTE	"Do you want to look for a value, Yes or No: ", 0
promptV		BYTE	"Please input a value to search for: ", 0
foundAt		BYTE	"[i] was found at: ", 0
nFound		BYTE	"Value was not found!", 0
result		BYTE	"Result is: ", 0
array		DWORD	10 DUP (?)
string		BYTE	40 DUP (?)
lengthA		DWORD   ?
found		BYTE	?
print		BYTE	11 DUP (?), 0


.CODE										; ***CODE BLOCK***
_MainProc PROC

; do {

prompt:	
		input   promptL, string, 40			
        atod    string

 ;} while (L < 0 || L > 10) {
 			
		cmp		eax, 0
		jl		prompt
		cmp		eax, 10
		jg		prompt
		mov		lengthA, eax
; };

; for (i= 0; i<=(L-1); i++) {

		mov	    ecx, 0					; //i=0
fLoop:
		cmp     ecx,lengthA
		jge     fLoopEnds				; //i < (L - 1)

		input   promptA, string, 40		; //Prompt for and input A[i]	
        atod    string
		
		mov     [array + 4*ecx], eax	; //store value into A[i]

		inc     ecx						; //i++
		jmp     fLoop

fLoopEnds:
; }

; while (input = 'Y' || 'y') {

searchAgain:
				input	promptC, string, 2			
				mov		al, string	
				cmp		al, 'Y'
				je		whileBody
				cmp		al, 'y'
				je		whileBody
				jmp		endOfProgram
	whileBody:	
				input	promptV, string, 40
				atod	string
				mov		found, 0	; //found = false
		
				; for (i= 0; i<=(L-1); i++) {

					mov	    ecx, 0	; //i=0

					fLoop1:
							cmp     ecx,[lengthA]
							jge     fLoopEnds1	; //i < (L - 1)

							; if (eax = A[i]) {

								cmp     [array + 4*ecx], eax	; //compare value at A[i]

							; //return not found
								jne		notfound

							; //OR

							; //return found
								mov found, 1	; //return found = true
								jmp	endwhile

								notfound:	
								inc     ecx		; i++
								jmp     fLoop1

							; }

					fLoopEnds1:
				; }
		
endWhile:
; }

; if (found) {

		cmp		found, 1

		; //return YES found
		je		yes

		; //OR

		; //return NO found
		jmp		no

; //found
yes:	
		dtoa    print, ecx
		output	foundAt, print
		jmp		searchAgain

; } else { 

; //not found
no:		
		output	result, nFound
		jmp		searchAgain

; }

endOfProgram:

		mov     eax, 0
        ret
_MainProc ENDP
END											; ***END OF PROGRAM***						

