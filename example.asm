; ***************************
; * Author:  Austin Major	*
; * Date:    10/10/2018		*
; * Home Assignment 5		*
; * ((A*B)+(C*5))/13		*
; ***************************

.586										; 32 bit processor memory call
.MODEL FLAT									; flat memory model

INCLUDE io.h								; header file for input/output

.STACK 4096									; tell assembler to reserve 4096 uninitialized bytes 

.DATA										; ***VARIABLE AND MEMORY DECLARATION***
numberA		DWORD   ?						; container A - 32bit - 4byte - unitialized
numberB		DWORD   ?						; container B - 32bit - 4byte - unitialized
numberC		DWORD	?						; container C - 32bit - 4byte - unitialized
constant5	DWORD	5						; constant of 5 - 32bit - 4byte - initialized 
constant13	DWORD	13						; constnt of 13 - 32bit - 4byte - initialized
resultAB	DWORD	?						; (A*B) - 32bit - 4byte - unitialized
result5C	DWORD	?						; (5*C) - 32bit - 4byte - unitialized
sum			DWORD	?						; (A*B)+(5*C) - 32bit - 4byte - unitialized
quotient	DWORD	?						; (A*B)+(5*C)/13 quotient in eax - 32bit - 4byte - unitialized
remainder	DWORD	?						; (A*B)+(5*C)/13 remainder in edx - 32bit - 4byte - unitiailzed
promptA		BYTE    "Please enter a:", 0	; input for A - 8bit - 1byte - 0 null character - initialized
promptB		BYTE    "Please enter b:", 0	; input for B - 8bit - 1byte - 0 null character - initialized
promptC		BYTE	"Please enter c:", 0	; input for C - 8bit - 1byte - 0 null character - initialized
string		BYTE    40 DUP (?)				; temp string for converting to integer - 8bit x 40 - 1byte x 40 - unitialized
qResult		BYTE	"Quotient is", 0		; output for quotient - 8bit - 1byte - 0 null character - initialized
rResult		BYTE	"Remainder is", 0		; output for remainder - 8bit - 1byte - 0 null character - initialized
qPrint		BYTE	11 DUP (?), 0			; print quotient - 8bit x 11 - 1byte x 11 - 0 null character - unitialized 
rPrint		BYTE	11 DUP (?), 0			; print remainder - 8bit x 11 - 1byte x 11 - 0 null character - unitialized

.CODE										; ***CODE BLOCK AND INSTRUCTIONS***
_MainProc PROC								; INSTRUCTIONS
        input   promptA, string, 40			; read input for A ASCII characters, store in temp string
        atod    string						; convert to integer
        mov     numberA, eax				; store in container A

        input   promptB, string, 40			; read input for B ASCII characters, store in temp string
        atod    string						; convert to integer
        mov     numberB, eax				; store in container B

		input   promptC, string, 40			; read input for C ASCII characters, store in temp string
        atod    string						; convert to integer
        mov     numberC, eax				; store in container C

        mov     eax, numberA				; move A into eax for manipulation
        imul    numberB						; signed multiplication, (A*B)
		mov		resultAB, eax				; move product from eax to resultAB

		mov		eax, numberC				; move C into eax for manipulation
		imul	constant5					; signed multiplication, (C*5)
		mov		result5C, eax				; move product from eax to result5C
		
		mov		eax, resultAB				; move result of (A*B) into eax for manipulation
		mov		ebx, result5C				; move result of (C*5) into ebx for manipulation
		add		eax, ebx					; add ebx to eax = (A*B)+(C*5) 
		mov		sum, eax					; move result into sum = (A*B)+(C*5)

		mov		eax, sum					; move sum into eax for manipulation
		mov		ebx, constant13				; move constant of 13 into ebx for manipulation
		cdq									; convert double word to quad, prepares division
		idiv	ebx							; divide eax/ebx, (A*B)+(C*5)/13 
		mov		quotient, eax				; move (A*B)+(C*5)/13 quotient from eax to quotient
		mov		remainder, edx				; move (A*B)+(C*5)/13 remainder stored in edx into remainder

		dtoa    qPrint, quotient			; convert quotient to ASCII characters stored in qPrint
        output  qResult, qPrint				; output quotient - qPrint stored in message qResult 

		dtoa    rPrint, remainder			; convert remainder to ASCII characters stored in rPrint
        output  rResult, rPrint				; output remainder - rPrint stored in message rResult

        mov     eax, 0						; exit with return code 0
        ret									; end
_MainProc ENDP								; ***END OF CODE BLOCK***
END											; ***END OF PROGRAM***						

