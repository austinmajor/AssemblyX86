; *************************
; * Author:  Austin Major *
; * Date:    9/19/2018	  *
; * Adds three numbers	  *
; *************************
; * Variable Types		  *
; * BYTE:  1 byte, 8 bit  *
; * WORD:  2 byte, 16 bit *
; * DWORD: 4 byte, 32 bit *
;**************************

.586
.MODEL FLAT
										 ; ***INCLUDE EXTERNAL FILES***
INCLUDE io.h							 ; header file for input/output

.STACK 4096

.DATA									 ; ***VARIABLE AND MEMORY DECLARATION***  
number1 DWORD   ?						 ; number1 var name, DWORD 4 bytes, unassigned value
number2 DWORD   ?
number3	DWORD	?
prompt1 BYTE    "Enter first number", 0	 ; prompt1 var declaration, 1 byte, 0 null character
prompt2 BYTE    "Enter second number", 0 ; prompt2 var declaration, 1 byte, 0 null character
prompt3 BYTE	"Enter third number", 0  ; prompt3 var declaration, 1 byte, 0 null character
string  BYTE    40 DUP (?)				 
resultLbl BYTE  "The sum is", 0
sum     BYTE    11 DUP (?), 0

.CODE									 ; ***CODE BLOCK INSTRUCTIONS***
_MainProc PROC							 ; main procedure
        input   prompt1, string, 40      ; read ASCII characters
        atod    string					 ; convert to integer
        ;mov     number1, eax			 ; store in memory

        ;input   prompt2, string, 40      ; repeat for second number
        ;atod    string
        ;mov     number2, eax
;
		;input	prompt3, string, 40		; repeat for third number
		;atod	string
		;mov		number3, eax
        
        ;mov     ecx, 1			; first number to EAX
		;mov		string, cx
        ;add     eax, number2			; add second number
		;add		eax, number3			; add third number
        dtoa    sum, eax		; convert to ASCII characters
        output  resultLbl, sum          ; output label and sum

        mov     eax, 0					; exit with return code 0
        ret
_MainProc ENDP
END										; end of source code

