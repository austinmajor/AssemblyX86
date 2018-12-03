; program to search for one string embedded in another
; author:  R. Detmer
; revised: 7/2013

.586
.MODEL FLAT
.STACK  4096
INCLUDE io.h

.DATA
prompt1     BYTE  "String to search?", 0
prompt2     BYTE  "Key to search for?", 0
target      BYTE  80 DUP (?)
key         BYTE  80 DUP (?)
trgtLength  DWORD ?
keyLength   DWORD ?
lastPosn    DWORD ?
resultLbl   BYTE  "Search Results", 0
failure     BYTE  "The key does not appear in the string", 0
success     BYTE  "The key appears at position"
position    BYTE  11 DUP (?)
            BYTE  "   in the string.", 0

.CODE
_MainProc   PROC
            input  prompt1, target,80  ; input target string
            lea    eax, target      ; address of target
            push   eax              ; parameter
            call   strlen           ; strlen(target)
            add    esp, 4           ; remove parameter
            mov    trgtLength,eax   ; save length of target
            input  prompt2, key,80  ; input key string
            lea    eax, key         ; address of key
            push   eax              ; parameter
            call   strlen           ; strlen(key)
            add    esp, 4           ; remove parameter
            mov    keyLength,eax    ; save length of key

; calculate last position of target to check
            mov    eax,trgtLength 
            sub    eax,keyLength
            inc    eax              ; trgtLength - keyLength + 1
            mov    lastPosn, eax
            cld                     ; left to right comparison

            mov    eax,1            ; starting position
whilePosn:  cmp    eax,lastPosn     ; position <= last_posn?
            jnle   endWhilePosn     ; exit if past last position

            lea    esi,target       ; address of target string
            add    esi,eax          ; add position
            dec    esi              ; address of position to check
            lea    edi,key          ; address of key
            mov    ecx,keyLength    ; number of positions to check
            repe cmpsb              ; check
            jz     found            ; exit on success
            inc    eax              ; increment position
            jmp    whilePosn        ; repeat
endWhilePosn:

            output resultLbl, failure  ; the search failed
            jmp    quit             ; exit

found:      dtoa   position,eax     ; convert position to ASCII
            output resultLbl, success  ; search succeeded
quit:
            mov     eax, 0           ; exit with return code 0
            ret            
_MainProc   ENDP
            

strlen      PROC
; int strlen(char str[])
            push    ebp             ; establish stack frame
            mov     ebp, esp
            push    ebx             ; save EBX
            sub     eax, eax        ; length := 0
            mov     ebx, [ebp+8]    ; address of string
whileChar:  cmp     BYTE PTR [ebx], 0  ; null byte?
            je      endWhileChar    ; exit if so
            inc     eax             ; increment length
            inc     ebx             ; point at next character
            jmp     whileChar       ; repeat
endWhileChar:
            pop     ebx             ; restore registers
            pop     ebp
            ret                     ; return
strlen      ENDP
END