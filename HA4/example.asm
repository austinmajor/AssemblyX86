; ***************************
; * Author:  Austin Major	*
; * Date:    9/30/2018		*
; * Perimeter of rectangle	*
; * 2x(length + width)		*
; ***************************

.586
.MODEL FLAT
.STACK  4096

INCLUDE io.h

.DATA
long		DWORD	?
wide		DWORD	?
prompt1		BYTE	"Please enter the length of the rectangle:", 0
prompt2		BYTE	"Please enter the width of the rectangle:", 0
string		BYTE	40 DUP (?), 0
resultLbl	BYTE	"The perimeter of your rectangle is:", 0
perimeter	BYTE    11 DUP (?), 0

.CODE
_MainProc    PROC
			input	prompt1, string, 40			; get length
			atod	string						; convert to int
			mov		long, eax					; store in memory

			input	prompt2, string, 40			; get width
			atod	string						; convert to int
			mov		wide, eax					; store in memory

			mov    eax, long					; move length to eax
            add    eax, wide					; add width to length 
            add    eax, eax						; 2x(length + width)

			dtoa    perimeter, eax				; convert to ASCII characters
			output  resultLbl, perimeter        ; output result and perimeter

            mov    eax, 0						; exit with return code 0
            ret
_MainProc    ENDP
END