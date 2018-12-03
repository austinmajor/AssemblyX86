; program to find the area of a rectangle
; author:  R. Detmer
; date:  revised 6/2013

.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA
long        DWORD  ?
wide        DWORD  ?
prompt1 BYTE    "Length of rectangle?", 0
prompt2 BYTE    "Width of rectangle", 0
string  BYTE    30 DUP (?)
areaLbl BYTE    "The area is", 0
area    BYTE    11 DUP (?), 0

.CODE
_MainProc PROC
        input   prompt1, string, 30   ; get length
        atod    string          ; convert to integer
        mov     long, eax       ; store in memory

        input   prompt2, string, 40    ; repeat for width
        atod    string
        mov     wide, eax
        
        mov     eax, long       ; length to EAX
        mul     wide            ; length*width
        dtoa    area, eax       ; convert to ASCII
        output  areaLbl, area   ; output label and area

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END
