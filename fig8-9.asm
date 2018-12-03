; Program to locate a character within a string.
; The string is displayed from the character to the end.
; author: R. Detmer
; revised:  7/2013

.586
.MODEL FLAT
.STACK  4096
INCLUDE io.h
EXTRN strlen:PROC

.DATA
prompt1     BYTE   "String?", 0
prompt2     BYTE   "Character?", 0
string      BYTE   80 DUP (?)
char        BYTE   5 DUP (?)
label1      BYTE   "Rest of the string ", 0

.CODE
_MainProc   PROC
            input  prompt1, string,80    ; get string
            lea    eax, string    ; find length of string
            push   eax            ; parameter
            call   strlen         ; strlen(string)
            add    esp, 4         ; remove argument from stack
            inc    eax            ; include null in string length
            mov    ecx, eax       ; save length of string
            input  prompt2, char,5   ; get character
            mov    al, char       ; character to AL
            lea    edi, string    ; offset of string
            cld                   ; forward movement
            repne scasb           ; scan while character not found
            dec    edi            ; back up to null or matching character
            output label1, [edi]  ; output string
            mov    eax, 0         ; exit with return code 0
            ret
_MainProc   ENDP
END
