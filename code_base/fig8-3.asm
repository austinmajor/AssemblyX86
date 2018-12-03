; strcopy procedure and test driver
; author: R. Detmer
; revised: 7/2013

.586
.MODEL FLAT
.STACK  4096
INCLUDE io.h            ; header file for input/output

.DATA                   ; reserve storage for data
prompt      BYTE   "Original string?  ",0
stringIn    BYTE   80 DUP (?)
displayLbl  BYTE   "Your string was...", 0
stringOut   BYTE   80 DUP (?)

.CODE
_MainProc PROC
          input  prompt, stringIn, 80   ; ask for string
          lea    eax, stringIn     ; source
          push   eax               ; second parameter
          lea    eax, stringOut    ; destination address
          push   eax               ; first parameter
          call   strcopy           ; strcopy(dest, source)
          add    esp, 8            ; remove parameters
          output displayLbl, stringOut  ; display result
          mov     eax, 0           ; exit with return code 0
          ret
_MainProc ENDP

strcopy   PROC NEAR32
; Procedure to copy string until null byte in source is copied.
; Destination location assumed to be long enough to hold copy.
; Parameters:
;  (1)  address of destination
;  (2)  address of source
          push   ebp               ;save base pointer
          mov    ebp,esp           ;copy stack pointer
          push   edi               ;save registers 
          push   esi
          pushfd                   ;save flags

          mov    edi,[ebp+8]       ;destination
          mov    esi,[ebp+12]      ;initial source address
          cld                      ;clear direction flag
whileNoNull:
          cmp    BYTE PTR [esi],0  ;null source byte?
          je     endWhileNoNull    ;stop copying if null
          movsb                    ;copy  one byte
          jmp    whileNoNull       ;go check next byte
endWhileNoNull:
          mov    BYTE PTR [edi],0  ;terminate destination string

          popfd                    ;restore flags
          pop    esi               ;restore registers
          pop    edi
          pop    ebp
          ret                      ;return
strcopy   ENDP
END