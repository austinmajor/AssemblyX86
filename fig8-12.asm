; Translate upper case letters to lower case; don't change lower
; case letters and digits. Translate other characters to spaces.
; author: R. Detmer
; revised: 7/2013

.586
.MODEL FLAT
.STACK  4096
EXTERN strlen:PROC

.DATA
string      BYTE   "This is a #!$& STRING",0
table       BYTE   48 DUP (' '), "0123456789", 7 DUP (' ')
            BYTE   "abcdefghijklmnopqrstuvwxyz", 6 DUP (' ')
            BYTE   "abcdefghijklmnopqrstuvwxyz", 133 DUP (' ')
.CODE
main        PROC
            lea    eax, string    ; get string length
            push   eax            ; parameter
            call   strlen         ; strlen(string)
            add    esp, 4         ; remove parameter
            mov    ecx, eax       ; string length
            lea    ebx, table     ; address of translation table
            lea    esi, string    ; address of string
            lea    edi, string    ; destination also string
forIndex:   lodsb                 ; copy next character to AL
            xlat                  ; translate character
            stosb                 ; copy character back into string
            loop   forIndex       ; repeat for all characters

            mov    eax, 0
            ret 
main        ENDP
END